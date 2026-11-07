import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Models/user_model.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_dialogs.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';
import 'package:resto_qr/Core/Utils/navigation.dart';
import 'package:resto_qr/Core/Widgets/custom_container.dart';
import 'package:resto_qr/Core/Widgets/custom_text_field.dart';
import 'package:resto_qr/Core/Widgets/full_width_button.dart';
import 'package:resto_qr/Core/Widgets/loading_scaffold.dart';
import 'package:resto_qr/Core/Widgets/sliver_sized_box.dart';
import 'package:resto_qr/Feature/Auth/View%20Model/Login%20Cubit/login_cubit.dart';
import 'package:resto_qr/Feature/Auth/Widgets/pick_image_button.dart';
import 'package:resto_qr/Feature/Menu/Dialogs/add_offer_item_dialog.dart';
import 'package:resto_qr/Feature/Menu/Models/item_model.dart';
import 'package:resto_qr/Feature/Menu/Models/offer_model.dart';
import 'package:resto_qr/Feature/Menu/View%20Model/Offer%20Cubit/offer_cubit.dart';
import 'package:resto_qr/Feature/Menu/View%20Model/Offer%20Cubit/offer_states.dart';
import 'package:resto_qr/Feature/Menu/Widgets/customer_visibility_switch.dart';

class AddOfferView extends StatefulWidget {
  const AddOfferView({super.key, this.currentOffer});

  final OfferModel? currentOffer;

  @override
  State<AddOfferView> createState() => _AddOfferViewState();
}

class _AddOfferViewState extends State<AddOfferView>
    with TickerProviderStateMixin {
  late final TextEditingController nameController;
  late final TextEditingController priceController;
  late final TextEditingController descriptionController;

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode priceFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? image;

  ValueNotifier<List<ItemModel>?> offerItems = ValueNotifier(null);

  late ValueNotifier<bool> isVisible;

  late final ValueNotifier<DateTime?> startDate;

  late final ValueNotifier<DateTime?> endDate;

  late final AnimationController _animationController;

  late final ScrollController _scrollController;

  @override
  void initState() {
    nameController = .new(text: widget.currentOffer?.name);
    priceController = .new(text: widget.currentOffer?.price);
    descriptionController = .new(text: widget.currentOffer?.description);
    isVisible = .new(widget.currentOffer?.isVisible ?? true);
    startDate = .new(widget.currentOffer?.startsAt);
    endDate = .new(widget.currentOffer?.endsAt);
    offerItems = .new(widget.currentOffer?.items);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      reverseDuration: const Duration(milliseconds: 60),
    );

    toggleAnimation(isVisible.value);

    _scrollController = .new();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return LoadingScaffold<OfferCubit, OfferStates>(
      body: BlocListener<OfferCubit, OfferStates>(
        listener: (context, state) {
          if (state is OfferAdded || state is OfferUpdated) {
            Navigation().pop(context);
          }
        },
        child: Form(
          key: formKey,
          child: CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                title: Text(
                  widget.currentOffer == null
                      ? l10n.addNewOffer
                      : l10n.editOffer,
                ),
                centerTitle: true,
                floating: true,
                snap: true,
              ),

              const SliverSizedBox(height: 16),

              SliverPadding(
                padding: const .symmetric(horizontal: 16),
                sliver: SliverMainAxisGroup(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Text(
                        l10n.itemImages,
                        style: AppText().semiBold16(context),
                      ),
                    ),

                    const SliverSizedBox(height: 4),

                    SliverToBoxAdapter(
                      child: Text(
                        l10n.uploadClearPhotos,
                        style: AppText().caption(context),
                      ),
                    ),

                    const SliverSizedBox(height: 12),

                    SliverToBoxAdapter(
                      child: PickImageButton(
                        initialValue: widget.currentOffer != null
                            ? [widget.currentOffer!.imageUrl]
                            : null,
                        title: l10n.uploadOfferImage,
                        onImageSelected: (imagePath) {
                          image = imagePath;
                        },
                      ),
                    ),

                    const SliverSizedBox(height: 28),

                    SliverToBoxAdapter(
                      child: Text(
                        l10n.offerDetails,
                        style: AppText().semiBold16(context),
                      ),
                    ),

                    const SliverSizedBox(height: 4),

                    SliverToBoxAdapter(
                      child: Text(
                        l10n.offerDetailsDescription,
                        style: AppText().caption(context),
                      ),
                    ),

                    const SliverSizedBox(height: 12),

                    SliverToBoxAdapter(
                      child: CustomTextField(
                        controller: nameController,
                        focusNode: nameFocusNode,
                        nextFocus: priceFocusNode,
                        labelText: l10n.offerName,
                        hintText: l10n.offerNameHint,
                        prefixIcon: Icons.restaurant_menu_rounded,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return l10n.enterOfferName;
                          }

                          return null;
                        },
                      ),
                    ),

                    const SliverSizedBox(height: 16),

                    SliverToBoxAdapter(
                      child: CustomTextField(
                        controller: priceController,
                        focusNode: priceFocusNode,
                        nextFocus: descriptionFocusNode,
                        labelText: l10n.price,
                        hintText: l10n.priceHint,
                        prefixIcon: Icons.attach_money_rounded,
                        keyboardType: const .numberWithOptions(
                          decimal: true,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return l10n.enterPrice;
                          }
                          return null;
                        },
                      ),
                    ),

                    const SliverSizedBox(height: 16),

                    SliverToBoxAdapter(
                      child: CustomTextField(
                        controller: descriptionController,
                        labelText: l10n.description,
                        hintText: l10n.descriptionHint,
                        maxLines: 4,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return l10n.enterDescription;
                          }
                          return null;
                        },
                      ),
                    ),

                    const SliverSizedBox(height: 28),

                    SliverToBoxAdapter(
                      child: Text(
                        AppLocalization.of(context).offerItems,
                        style: AppText().semiBold16(context),
                      ),
                    ),

                    const SliverSizedBox(height: 4),

                    SliverToBoxAdapter(
                      child: Text(
                        AppLocalization.current.offerItemsDescription,
                        style: AppText().caption(context),
                      ),
                    ),

                    const SliverSizedBox(height: 12),

                    SliverToBoxAdapter(
                      child: FormField<List<ItemModel>>(
                        initialValue:
                            widget.currentOffer?.items ?? offerItems.value,
                        validator: (value) {
                          return value == null ||
                                  value.isEmpty ||
                                  (widget.currentOffer != null &&
                                      widget.currentOffer!.items.isEmpty)
                              ? AppLocalization.current.addAtLeastOneItem
                              : null;
                        },
                        builder: (field) => GestureDetector(
                          onTap: () async {
                            var res = await AppDialogs()
                                .showDialog<List<ItemModel>>(
                                  context: context,
                                  child: BlocProvider.value(
                                    value: context.read<OfferCubit>(),
                                    child: AddOfferItemDialog(
                                      initialItems:
                                          widget.currentOffer?.items ??
                                          offerItems.value,
                                    ),
                                  ),
                                );

                            offerItems.value = res != null && res.isNotEmpty
                                ? List.from(res)
                                : null;

                            field.didChange(offerItems.value);
                            field.validate();
                          },
                          child: CustomContainer(
                            borderRadius: 12,
                            padding: const .symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            borderColor: field.hasError
                                ? AppConstants().errorRed
                                : null,
                            child: ValueListenableBuilder(
                              valueListenable: offerItems,
                              builder: (context, value, child) {
                                return Row(
                                  spacing: 16,
                                  children: [
                                    Icon(
                                      value == null
                                          ? Icons.add_rounded
                                          : Icons.edit_rounded,
                                    ),
                                    Text(
                                      value == null
                                          ? AppLocalization.current.addItems
                                          : '${AppLocalization.formatNumber(value.length)} ${AppLocalization.current.items}',
                                      style: AppText().semiBold14(context),
                                    ),

                                    // Explicitly draw the error text if validation fails
                                    if (field.hasError) ...[
                                      const SizedBox(height: 6),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 12,
                                        ),
                                        child: Text(
                                          field.errorText!,
                                          style: AppText()
                                              .caption(context)
                                              .copyWith(
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.error,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SliverSizedBox(height: 28),

                    SliverToBoxAdapter(
                      child: Text(
                        AppLocalization.current.availability,
                        style: AppText().semiBold16(context),
                      ),
                    ),

                    const SliverSizedBox(height: 4),

                    SliverToBoxAdapter(
                      child: Text(
                        AppLocalization.current.itemVisibilityDescription,
                        style: AppText().caption(context),
                      ),
                    ),

                    const SliverSizedBox(height: 12),

                    SliverToBoxAdapter(
                      child: CustomerVisibilitySwitch(
                        initialValue: isVisible.value,
                        onToggle: (value) {
                          isVisible.value = value;
                          toggleAnimation(value);
                          startDate.value = null;
                          endDate.value = null;
                          if (value) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeInOut,
                              );
                            });
                          }
                        },
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: ListenableBuilder(
                        listenable: Listenable.merge([
                          isVisible,
                          startDate,
                          endDate,
                        ]),
                        builder: (context, child) {
                          return Visibility(
                            visible: isVisible.value,
                            child:
                                Column(
                                  crossAxisAlignment: .start,
                                  children: [
                                    const SizedBox(height: 28),

                                    Text(
                                      AppLocalization.current.limitedTimeOffer,
                                      style: AppText().semiBold16(context),
                                    ),

                                    const SizedBox(height: 4),

                                    Text(
                                      AppLocalization
                                          .current
                                          .setDateTimeForOffer,
                                      style: AppText().caption(context),
                                    ),

                                    const SizedBox(height: 12),

                                    dateTile(
                                      context: context,
                                      icon: Icons.calendar_month_rounded,
                                      title: l10n.startDate,
                                      subtitle: startDate.value == null
                                          ? AppLocalization
                                                .current
                                                .selectDateTime
                                          : AppLocalization.formatDateTime(
                                              startDate.value!,
                                            ),
                                      onTap: () {
                                        pickDateTime(
                                          context: context,
                                          initialDate: startDate.value,
                                          onDatePicked: (dateTime) {
                                            startDate.value = dateTime;
                                          },
                                        );
                                      },
                                    ),

                                    const SizedBox(height: 16),

                                    dateTile(
                                      context: context,
                                      icon: Icons.calendar_month_rounded,
                                      title: l10n.endDate,
                                      subtitle: endDate.value == null
                                          ? AppLocalization
                                                .current
                                                .selectDateTime
                                          : AppLocalization.formatDateTime(
                                              endDate.value!,
                                            ),
                                      onTap: () {
                                        pickDateTime(
                                          context: context,
                                          initialDate: endDate.value,
                                          onDatePicked: (dateTime) {
                                            endDate.value = dateTime;
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ).animate(
                                  autoPlay: false,
                                  controller: _animationController,
                                  effects: [
                                    FadeEffect(),
                                    SlideEffect(
                                      begin: const Offset(0, -0.1),
                                      end: Offset.zero,
                                    ),
                                  ],
                                ),
                          );
                        },
                      ),
                    ),

                    const SliverSizedBox(height: 32),

                    SliverToBoxAdapter(
                      child: Center(
                        child: FullWidthButton(
                          labelText: l10n.saveOffer,
                          icon: Icons.check_rounded,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              var userInfo = context
                                  .read<LoginCubit>()
                                  .state
                                  .user;
                              if (widget.currentOffer == null) {
                                addItem(context, userInfo);
                              } else {
                                updateItem(context);
                              }
                            }
                          },
                        ),
                      ),
                    ),

                    const SliverSizedBox(height: 60),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateItem(BuildContext context) {
    context.read<OfferCubit>().updateOffer(
      offer: widget.currentOffer!.copyWith(
        name: nameController.text.trim(),
        price: priceController.text.trim(),
        description: descriptionController.text.trim(),
        items: offerItems.value!,
        isVisible: isVisible.value,
        startsAt: startDate.value,
        endsAt: endDate.value,
      ),
      image: image,
    );
  }

  void addItem(BuildContext context, UserModel userInfo) {
    context.read<OfferCubit>().addOffer(
      offer: OfferModel(
        restaurantId: userInfo.restaurantID!,
        ownerId: userInfo.id!,
        menuId: userInfo.menuId!,
        name: nameController.text.trim(),
        price: priceController.text.trim(),
        description: descriptionController.text.trim(),
        items: offerItems.value!,
        imageUrl: image!,
        isVisible: isVisible.value,
        startsAt: startDate.value,
        endsAt: endDate.value,
      ),
      image: image!,
    );
  }

  void toggleAnimation(bool value) {
    if (value) {
      _animationController.forward(from: 0);
    } else {
      _animationController.reverse();
    }
  }

  ListTile dateTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    String? subtitle,
    void Function()? onTap,
  }) {
    return ListTile(
      tileColor: AppTheme().fillColor(context),
      shape: RoundedRectangleBorder(
        borderRadius: .circular(12),
      ),
      leading: Icon(
        icon,
        color: AppTheme().primaryText(context),
      ),
      title: Text(
        title,
        style: AppText().semiBold14(context),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: AppText().caption(context),
            )
          : null,
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 18,
        color: AppTheme().primaryText(context),
      ),
      onTap: onTap,
    );
  }

  void pickDateTime({
    required BuildContext context,
    required void Function(DateTime) onDatePicked,
    DateTime? initialDate,
  }) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && context.mounted) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: initialDate != null
            ? TimeOfDay(
                hour: initialDate.hour,
                minute: initialDate.minute,
              )
            : TimeOfDay.now(),
      );

      if (pickedTime != null) {
        DateTime finalDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        onDatePicked(finalDateTime);
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    isVisible.dispose();
    offerItems.dispose();
    _animationController.dispose();
    _scrollController.dispose();
    startDate.dispose();
    endDate.dispose();
    super.dispose();
  }
}
