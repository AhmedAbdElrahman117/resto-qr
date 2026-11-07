import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';
import 'package:resto_qr/Core/Utils/navigation.dart';
import 'package:resto_qr/Core/Widgets/custom_dialog.dart';
import 'package:resto_qr/Core/Widgets/custom_switch_tile.dart';
import 'package:resto_qr/Core/Widgets/full_width_button.dart';
import 'package:resto_qr/Feature/Auth/Widgets/pick_image_button.dart';
import 'package:resto_qr/Feature/Website/Banners/Models/banner_model.dart';
import 'package:resto_qr/Feature/Website/Banners/View%20Model/banner_cubit.dart';
import 'package:resto_qr/Feature/Website/Banners/View%20Model/banner_state.dart';

class AddBannerDialog extends StatefulWidget {
  final BannerCubit cubit;
  final String menuId;
  final String ownerId;
  final BannerModel? currentBanner;

  const AddBannerDialog({
    super.key,
    required this.cubit,
    required this.menuId,
    required this.ownerId,
    this.currentBanner,
  });

  @override
  State<AddBannerDialog> createState() => _AddBannerDialogState();
}

class _AddBannerDialogState extends State<AddBannerDialog> {
  final _formKey = GlobalKey<FormState>();

  String? _imagePath;

  late final ValueNotifier<String?> _selectedItemId = ValueNotifier<String?>(
    widget.currentBanner?.redirectUrl,
  );

  late final ValueNotifier<bool> _isLive = ValueNotifier<bool>(
    widget.currentBanner?.isLive ?? true,
  );

  late final ValueNotifier<DateTime?> _expiresAt = ValueNotifier<DateTime?>(
    widget.currentBanner?.expiresAt,
  );

  @override
  void initState() {
    widget.cubit.getMenuItems(ownerId: widget.ownerId);
    super.initState();
  }

  @override
  void dispose() {
    _selectedItemId.dispose();
    _isLive.dispose();
    _expiresAt.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      if (_imagePath == null && widget.currentBanner == null) return;

      if (widget.currentBanner != null) {
        final updatedBanner = widget.currentBanner!.copyWith(
          redirectUrl: _selectedItemId.value,
          isLive: _isLive.value,
          expiresAt: _expiresAt.value,
        );

        widget.cubit.updateBanner(
          banner: updatedBanner,
          image: _imagePath,
        );
      } else {
        final banner = BannerModel(
          id: '',
          menuId: widget.menuId,
          imageUrl: '', // Will be updated by Repo
          redirectUrl: _selectedItemId.value,
          isLive: _isLive.value,
          interactions: 0,
          createdAt: DateTime.now(),
          expiresAt: _expiresAt.value,
        );

        widget.cubit.addBanner(banner: banner, image: _imagePath!);
      }
    }
  }

  Future<void> _pickExpiryDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _expiresAt.value ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
      builder: (context, child) {
        return child!;
      },
    );

    if (date != null && mounted) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_expiresAt.value ?? DateTime.now()),
      );

      if (time != null && mounted) {
        _expiresAt.value = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return BlocProvider.value(
      value: widget.cubit,
      child: BlocListener<BannerCubit, BannerState>(
        listener: (context, state) {
          if (state is BannerAddedSuccess || state is BannerUpdatedSuccess) {
            Navigation().pop(context);
          }
        },
        child: CustomDialog(
          padding: const .all(20),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: .min,
                crossAxisAlignment: .start,
                children: [
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text(
                        widget.currentBanner == null
                            ? l10n.addNewBanner
                            : l10n.editBanner,
                        style: AppText().bold20(context),
                      ),

                      CloseButton(
                        color: AppTheme().primaryText(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  PickImageButton(
                    title: l10n.uploadBannerImage,
                    initialValue: widget.currentBanner?.imageUrl != null
                        ? [widget.currentBanner!.imageUrl]
                        : null,
                    onImageSelected: (path) => _imagePath = path,
                  ),

                  const SizedBox(height: 20),

                  Text(
                    l10n.redirectToItemOptional,
                    style: AppText().semiBold14(context),
                  ),

                  const SizedBox(height: 8),

                  BlocBuilder<BannerCubit, BannerState>(
                    bloc: widget.cubit,

                    builder: (context, state) {
                      if (state is BannerItemsLoadingState) {
                        return const Padding(
                          padding: .symmetric(vertical: 8),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else if (state is BannerErrorState) {
                        return Text(
                          l10n.failedToLoadItems(state.message),
                          style: AppText()
                              .regular14(context)
                              .copyWith(color: AppConstants().errorRed),
                        );
                      }
                      var items = state is BannerItemsLoadedState
                          ? state.items
                          : [];

                      return ValueListenableBuilder<String?>(
                        valueListenable: _selectedItemId,
                        builder: (context, selectedItemValue, _) {
                          return _itemsDropdown(
                            selectedItemValue,
                            context,
                            items,
                          );
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  Text(
                    l10n.bannerExpirationDateOptional,
                    style: AppText().semiBold14(context),
                  ),

                  const SizedBox(height: 8),

                  ValueListenableBuilder<DateTime?>(
                    valueListenable: _expiresAt,
                    builder: (context, expiresAtValue, _) {
                      return _expireDatePicker(context, expiresAtValue);
                    },
                  ),

                  const SizedBox(height: 20),

                  ValueListenableBuilder<bool>(
                    valueListenable: _isLive,
                    builder: (context, isLiveValue, _) {
                      return CustomSwitchTile(
                        title: l10n.makeBannerLive,
                        color: AppConstants().neonBlue,
                        initialValue: isLiveValue,
                        onToggle: (val) => _isLive.value = val,
                        showIcon: false,
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  BlocBuilder<BannerCubit, BannerState>(
                    builder: (context, state) {
                      return FullWidthButton(
                        onPressed: state is BannerDialogLoadingState
                            ? null
                            : _submit,
                        label: state is BannerDialogLoadingState
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.white,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: .center,
                                children: [
                                  Text(
                                    widget.currentBanner == null
                                        ? l10n.addBanner
                                        : l10n.updateBanner,
                                    style: AppText().semiBold16(
                                      context,
                                      Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InkWell _expireDatePicker(BuildContext context, DateTime? expiresAtValue) {
    return InkWell(
      onTap: _pickExpiryDate,
      borderRadius: .circular(12),
      child: Container(
        padding: const .symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          border: .all(
            color: AppTheme().borderColor(context),
          ),
          borderRadius: .circular(12),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 20,
              color: AppConstants().neonBlue,
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Text(
                expiresAtValue != null
                    ? AppLocalization.formatDateTime(
                        expiresAtValue,
                        context: context,
                      )
                    : AppLocalization.of(context).noExpirationDate,
                style: AppText().regular14(
                  context,
                  expiresAtValue != null
                      ? AppTheme().primaryText(context)
                      : AppTheme().secondaryText(context),
                ),
              ),
            ),
            if (expiresAtValue != null)
              GestureDetector(
                onTap: () => _expiresAt.value = null,
                child: Icon(
                  Icons.close,
                  size: 20,
                  color: AppTheme().secondaryText(context),
                ),
              ),
          ],
        ),
      ),
    );
  }

  DropdownButtonFormField<String> _itemsDropdown(
    String? selectedItemValue,
    BuildContext context,
    List<dynamic> items,
  ) {
    return DropdownButtonFormField<String>(
      initialValue: selectedItemValue,
      dropdownColor: AppTheme().primaryBackground(
        context,
      ),
      style: AppText().regular14(context),
      decoration: InputDecoration(
        hintText: AppLocalization.of(context).selectMenuItem,
        hintStyle: AppText().regular14(
          context,
          AppTheme().secondaryText(context),
        ),
        border: OutlineInputBorder(
          borderRadius: .circular(12),
          borderSide: BorderSide(
            color: AppTheme().borderColor(context),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: .circular(12),
          borderSide: BorderSide(
            color: AppTheme().borderColor(context),
          ),
        ),
      ),
      items: [
        DropdownMenuItem(
          value: null,
          child: Text(AppLocalization.of(context).noRedirect),
        ),
        ...items.map(
          (item) => DropdownMenuItem<String>(
            value: item['id'].toString(),
            child: Text(item['name'].toString()),
          ),
        ),
      ],
      onChanged: (val) {
        _selectedItemId.value = val;
      },
    );
  }
}
