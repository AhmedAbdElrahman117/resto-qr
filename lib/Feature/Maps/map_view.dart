import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:resto_qr/Core/Cubit/app_cubit.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';
import 'package:resto_qr/Core/Utils/location.dart';
import 'package:resto_qr/Core/Utils/navigation.dart';
import 'package:resto_qr/Core/Widgets/bloc_widget.dart';
import 'package:resto_qr/Core/Widgets/empty_state_widget.dart';
import 'package:resto_qr/Core/Widgets/loading_widget.dart';
import 'package:resto_qr/Feature/Maps/Model/place_model.dart';
import 'package:resto_qr/Feature/Maps/View%20Model/map_cubit.dart';
import 'package:resto_qr/Feature/Maps/View%20Model/map_state.dart';
import 'package:resto_qr/Feature/Maps/Widgets/location_details.dart';
import 'package:resto_qr/Feature/Maps/Widgets/my_location_button.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  // ---------------------------------------------------------------------------
  // Constants
  // ---------------------------------------------------------------------------
  static const double _initialZoom = 14;

  static const String _sourceId = 'places-source';
  static const String _clustersLayerId = 'clusters';
  static const String _clusterCountLayerId = 'cluster-count';
  static const String _unclusteredLayerId = 'unclustered-points';
  static const String _markerImageId = 'custom-marker';

  // Mapbox Standard style: the theme is driven by the `lightPreset` config of
  // the `basemap` import, so switching light/dark never reloads the style.
  static const String _basemapImportId = 'basemap';
  static const String _lightPresetKey = 'lightPreset';
  static const String _lightPresetDay = 'day';
  static const String _lightPresetNight = 'night';

  // ---------------------------------------------------------------------------
  // Map state
  // ---------------------------------------------------------------------------
  MapboxMap? mapController;
  CameraOptions? position;
  Timer? _debounceTimer;
  Position? lastFetchedPosition;
  double zoom = _initialZoom;

  final ValueNotifier<PlaceModel?> selectedPlace = ValueNotifier<PlaceModel?>(
    null,
  );
  final ValueNotifier<bool> showCurrentLocationButton = ValueNotifier<bool>(
    false,
  );

  late final AppLifecycleListener _lifecycleListener;

  List<PlaceModel> _cachedPlaces = [];
  StyleImage? _markerImage;
  bool _isStyleLoaded = false;

  /// Created once, so rebuilding [MapWidget] never re-applies the initial
  /// camera and snaps the map back to where it started.
  CameraViewportState? _initialViewport;

  /// Last `MapInitalized` state that was handled, so the (idempotent) handler
  /// does not overwrite [position] on unrelated rebuilds.
  MapInitalized? _handledInitState;
  String? _appliedMapKey;

  // ---------------------------------------------------------------------------
  // Theme state (driven by AppCubit, applied through the Standard lightPreset)
  // ---------------------------------------------------------------------------
  late bool _isDark;
  StreamSubscription<Object?>? _themeSubscription;

  // ---------------------------------------------------------------------------
  // Serialized map operations
  // ---------------------------------------------------------------------------
  Future<void> _syncChain = Future<void>.value();
  bool _placesSyncPending = false;

  @override
  void initState() {
    super.initState();

    final appCubit = context.read<AppCubit>();
    _isDark = appCubit.state.mode == ThemeMode.dark;
    _themeSubscription = appCubit.stream.listen((state) {
      final isDark = state.mode == ThemeMode.dark;
      if (isDark == _isDark) return;
      _isDark = isDark;

      // AppTheme colors come from the widget tree, so wait for the new theme
      // to be built before reading them.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _enqueue(_applyTheme);
      });
      WidgetsBinding.instance.ensureVisualUpdate();
    });

    _lifecycleListener = AppLifecycleListener(
      onPause: () {
        if (mounted) context.read<MapCubit>().stopLocationStream();
      },
      onResume: () {
        if (mounted) context.read<MapCubit>().resumeLocationStream();
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocWidget<MapCubit, MapState>(
          listener: _listener,
          buildWhen: (previous, current) =>
              current is MapInitalized ||
              current is MapLoadingInitState ||
              current is MapInitalizationError,
          builder: (context, state) {
            if (state is MapLoadingInitState) {
              return const Center(child: LoadingWidget());
            } else if (state is MapInitalizationError) {
              return EmptyStateWidget(
                title: 'Error',
                message: state.message,
              );
            }

            final location = state as MapInitalized;

            // Idempotent. Guarantees the token is set before the first
            // MapWidget is created, even if the listener missed this state.
            _handleInitialized(location);

            _initialViewport ??= CameraViewportState(
              center: Point(
                coordinates: Position(
                  location.initialLng ?? 0,
                  location.initialLat ?? 0,
                ),
              ),
              zoom: _initialZoom,
            );

            return Stack(
              children: [
                MapWidget(
                  viewport: _initialViewport!,
                  onMapCreated: _onMapCreated,
                  onCameraChangeListener: _onCameraChangeListener,
                  onStyleLoadedListener: (styleLoadedEventData) {
                    _onStyleLoaded();
                  },
                  styleUri: MapboxStyles.STANDARD,
                ),

                Align(
                  alignment: .bottomCenter,
                  child: Container(
                    width: .infinity,
                    padding: const .symmetric(vertical: 24, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: const .only(
                        topLeft: .circular(16),
                        topRight: .circular(16),
                      ),
                      color: AppTheme().primaryBackground(context),
                    ),
                    child: ValueListenableBuilder<PlaceModel?>(
                      valueListenable: selectedPlace,
                      builder: (context, value, child) => AnimatedSize(
                        duration: const Duration(milliseconds: 150),
                        child: value != null
                            ? LocationDetails(
                                place: value,
                                onSelect: () {
                                  Navigation().pop(context, value);
                                },
                              )
                            : Text(
                                'Select your restaurant',
                                style: AppText().bold24(context),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: showCurrentLocationButton,
        builder: (context, value, child) {
          if (!value) return const SizedBox.shrink();
          return child!;
        },
        child: MyLocationButton(
          onPressed: () async {
            if (position?.center != null) {
              await mapController?.flyTo(
                CameraOptions(
                  center: Point(
                    coordinates: Position(
                      position!.center!.coordinates.lng,
                      position!.center!.coordinates.lat,
                    ),
                  ),
                ),
                MapAnimationOptions(duration: 500),
              );
            }
          },
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Bloc handling
  // ---------------------------------------------------------------------------
  void _handleInitialized(MapInitalized state) {
    if (identical(_handledInitState, state)) return;
    _handledInitState = state;

    if (_appliedMapKey != state.mapKey) {
      MapboxOptions.setAccessToken(state.mapKey);
      _appliedMapKey = state.mapKey;
    }

    _markerImage = state.marker;

    final lng = state.initialLng;
    final lat = state.initialLat;
    if (lng != null && lat != null) {
      position = CameraOptions(
        center: Point(coordinates: Position(lng, lat)),
        zoom: zoom,
      );
    }
  }

  void _listener(BuildContext _, MapState state) async {
    if (state is MapInitalized) {
      _handleInitialized(state);
    } else if (state is MapLocationUpdated) {
      position = CameraOptions(
        center: Point(
          coordinates: Position(state.lng, state.lat),
        ),
        zoom: zoom,
      );
      await updateLocation();
    } else if (state is MapPlacesLoaded) {
      _cachedPlaces = state.places;
      _schedulePlacesSync();
    }
  }

  // ---------------------------------------------------------------------------
  // Camera
  // ---------------------------------------------------------------------------
  void _onCameraChangeListener(CameraChangedEventData cameraChangedEventData) {
    zoom = cameraChangedEventData.cameraState.zoom.toDouble();
    final currentLng = cameraChangedEventData.cameraState.center.coordinates.lng
        .toDouble();
    final currentLat = cameraChangedEventData.cameraState.center.coordinates.lat
        .toDouble();

    if (lastFetchedPosition != null) {
      double distanceMoved = Location().distanceBetween(
        lastFetchedPosition!.lat.toDouble(),
        lastFetchedPosition!.lng.toDouble(),
        currentLat,
        currentLng,
      );

      if (distanceMoved < 1000) return;
    }

    if (_debounceTimer?.isActive == true) _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(seconds: 1), () {
      if (!mounted) return;
      lastFetchedPosition = Position(currentLng, currentLat);
      context.read<MapCubit>().getMapLocations(
        lng: currentLng,
        lat: currentLat,
      );
    });
  }

  // ---------------------------------------------------------------------------
  // Serialized sync
  //
  // Every operation that touches the style (image, source, layers, preset) goes
  // through [_enqueue], so two of them can never interleave their awaits (e.g.
  // both seeing "source does not exist" and both trying to add it).
  // ---------------------------------------------------------------------------
  void _enqueue(Future<void> Function() task) {
    _syncChain = _syncChain.then((_) async {
      if (!mounted) return;
      try {
        await task();
      } catch (e, s) {
        log('Map sync failed: $e', error: e, stackTrace: s);
      }
    });
  }

  /// Coalesces bursts: while a places sync is waiting in the queue, further
  /// requests are no-ops because the task always reads the latest
  /// [_cachedPlaces] when it actually runs.
  void _schedulePlacesSync() {
    if (_placesSyncPending) return;
    _placesSyncPending = true;
    _enqueue(() async {
      _placesSyncPending = false;
      await _applyPlaces();
    });
  }

  // ---------------------------------------------------------------------------
  // Places source + layers
  // ---------------------------------------------------------------------------
  String _createGeoJson(List<PlaceModel> places) {
    final features = places.map((place) {
      return {
        "type": "Feature",
        "geometry": {
          "type": "Point",
          "coordinates": [place.lng, place.lat],
        },
        "properties": place.toJson(),
      };
    }).toList();

    return jsonEncode({
      "type": "FeatureCollection",
      "features": features,
    });
  }

  Future<void> _applyPlaces() async {
    final map = mapController;
    final places = _cachedPlaces;
    if (!mounted || map == null || !_isStyleLoaded || places.isEmpty) return;

    final geoJsonString = _createGeoJson(places);
    final textColor = AppTheme().primaryText(context, false).toARGB32();

    final sourceExists = await map.styleSourceExists(_sourceId);

    if (sourceExists) {
      final source = await map.getSource(_sourceId) as GeoJsonSource;
      await source.updateGeoJSON(geoJsonString);
      return;
    }

    await map.addSource(
      GeoJsonSource(
        id: _sourceId,
        data: geoJsonString,
        cluster: true,
        clusterMinPoints: 2,
        clusterMaxZoom: 14,
        clusterRadius: 50,
      ),
    );

    await map.addLayer(
      CircleLayer(
        id: _clustersLayerId,
        sourceId: _sourceId,
        filter: ['has', 'point_count'],
        circleColor: AppConstants().neonBlue.toARGB32(),
        circleRadius: 18.0,
        circleStrokeWidth: 2.0,
        circleStrokeColor: Colors.white.toARGB32(),
      ),
    );

    await map.addLayer(
      SymbolLayer(
        id: _clusterCountLayerId,
        sourceId: _sourceId,
        filter: ['has', 'point_count'],
        textField: '{point_count}',
        textSize: 14.0,
        textColor: textColor,
      ),
    );

    await map.addLayer(
      SymbolLayer(
        id: _unclusteredLayerId,
        sourceId: _sourceId,
        filter: [
          '!',
          ['has', 'point_count'],
        ],
        iconImage: _markerImageId,
        iconSize: 0.25,
        textField: '{name}',
        textOffset: [0.0, 2.5],
        textColor: textColor,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Theme (Standard style light preset)
  // ---------------------------------------------------------------------------
  String _rgba(int argb) {
    final a = ((argb >> 24) & 0xFF) / 255;
    final r = (argb >> 16) & 0xFF;
    final g = (argb >> 8) & 0xFF;
    final b = argb & 0xFF;
    return 'rgba($r, $g, $b, ${a.toStringAsFixed(3)})';
  }

  Future<void> _applyTheme() async {
    final map = mapController;
    if (!mounted || map == null || !_isStyleLoaded) return;

    // Read everything that needs `context` before the first await.
    final isDark = _isDark;
    final textColor = _rgba(AppTheme().primaryText(context, false).toARGB32());

    await map.setStyleImportConfigProperty(
      _basemapImportId,
      _lightPresetKey,
      isDark ? _lightPresetNight : _lightPresetDay,
    );

    // The label colors were baked in when the layers were created; keep them
    // in sync with the theme without recreating the layers.
    for (final layerId in [_clusterCountLayerId, _unclusteredLayerId]) {
      if (await map.styleLayerExists(layerId)) {
        await map.setStyleLayerProperty(layerId, 'text-color', textColor);
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Map callbacks
  // ---------------------------------------------------------------------------
  void _onStyleLoaded() {
    // A (re)loaded style has none of our image/source/layers yet.
    _isStyleLoaded = false;

    _enqueue(() async {
      final map = mapController;
      if (map == null) return;

      final markerImage = _markerImage;
      if (markerImage != null) {
        try {
          // sdf defaults to false and no stretch/content areas, same as before.
          await map.addImage(_markerImageId, 3.0, markerImage);
        } catch (e) {
          log('Error adding style image: $e');
        }
      }

      _isStyleLoaded = true;

      await _applyTheme();
      await _applyPlaces();
    });
  }

  void _onMapCreated(MapboxMap controller) async {
    mapController = controller;
    await updateLocation();
    if (!mounted) return;
    showCurrentLocationButton.value = true;

    controller.addInteraction(
      TapInteraction(
        FeaturesetDescriptor(layerId: _unclusteredLayerId),
        (feature, interactionContext) {
          final properties = feature.properties as Map<String, dynamic>;

          selectedPlace.value = PlaceModel(
            id: properties['id'] as String,
            name: properties['name'] as String,
            lng: (properties['lng'] as num).toDouble(),
            lat: (properties['lat'] as num).toDouble(),
            address: properties['address'] as String,
          );
        },
      ),
    );

    controller.addInteraction(
      TapInteraction(
        FeaturesetDescriptor(layerId: _clustersLayerId),
        (feature, interactionContext) async {
          await mapController?.flyTo(
            CameraOptions(
              center: interactionContext.point,
              zoom: zoom + 2.5,
            ),
            MapAnimationOptions(duration: 500),
          );
        },
      ),
    );
  }

  Future<void>? updateLocation() {
    return mapController?.location.updateSettings(
      LocationComponentSettings(
        enabled: true,
        pulsingEnabled: true,
        puckBearingEnabled: true,
        showAccuracyRing: true,
      ),
    );
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _themeSubscription?.cancel();
    _lifecycleListener.dispose();
    selectedPlace.dispose();
    showCurrentLocationButton.dispose();
    super.dispose();
  }
}
