import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:resto_qr/Core/Cubit/app_cubit.dart';
import 'package:resto_qr/Core/Models/app_settings.dart';
import 'package:resto_qr/Core/Services/gallery_service.dart';
import 'package:resto_qr/Core/Utils/app_directory.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_permissions.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';
import 'package:resto_qr/Core/Views/app_crash_view.dart';
import 'package:resto_qr/Core/Views/maintenance_view.dart';
import 'package:resto_qr/Core/Widgets/bloc_widget.dart';
import 'package:resto_qr/Feature/Auth/View%20Model/Login%20Cubit/login_cubit.dart';
import 'package:resto_qr/Feature/Splash/splash_view.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initHydratedCubit();

  await AppPermissions().requestLocationPermission();

  await Supabase.initialize(
    publishableKey: 'sb_publishable_gTtn8ZtKaJm3IOxy9fmBaQ_yPYqVfHb',
    url: 'https://kmzvxuzparxejoiawtoy.supabase.co',
    debug: kDebugMode,
  );

  await GalleryService().init();

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return AppCrashView();
  };

  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://b1984bd2e68483011d1f6c05af5e6a9f@o4511569129963520.ingest.de.sentry.io/4511569201659984';
    },
    appRunner: () => runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppCubit(),
            lazy: false,
          ),
          BlocProvider(
            create: (context) => LoginCubit(),
            lazy: false,
          ),
        ],
        child: DefaultAssetBundle(
          bundle: SentryAssetBundle(),
          child: RestoQR(),
        ),
      ),
    ),
  );
}

Future<void> initHydratedCubit() async {
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      await AppDirectory().getAppDirectoryPath(),
    ),
  );
}

class RestoQR extends StatelessWidget {
  const RestoQR({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        navigatorObservers: [
          SentryNavigatorObserver(),
        ],
        debugShowCheckedModeBanner: false,
        theme: AppTheme().themeData(context, Brightness.light),
        darkTheme: AppTheme().themeData(context, Brightness.dark),
        themeMode: context.watch<AppCubit>().state.mode,
        localizationsDelegates: AppLocalization.localizationsDelegates,
        supportedLocales: AppLocalization.supportedLocales,
        locale: Locale(context.watch<AppCubit>().state.languageCode),
        builder: (context, child) {
          return BlocWidget<AppCubit, AppSettings>(
            buildWhen: (previous, current) =>
                previous.isUnderMaintenance != current.isUnderMaintenance,
            builder: (context, state) {
              if (state.isUnderMaintenance) {
                return const MaintenanceView();
              }

              // 4. Otherwise, show the normal app routes
              return child ?? const SizedBox.shrink();
            },
          );
        },
        home: SplashView(),
      ),
    );
  }
}
