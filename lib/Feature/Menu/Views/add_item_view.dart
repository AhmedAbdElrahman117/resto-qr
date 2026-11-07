import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Utils/app_dialogs.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Widgets/custom_container.dart';
import 'package:resto_qr/Core/Widgets/custom_text_field.dart';
import 'package:resto_qr/Core/Widgets/full_width_button.dart';
import 'package:resto_qr/Core/Widgets/loading_scaffold.dart';
import 'package:resto_qr/Core/Widgets/sliver_sized_box.dart';
import 'package:resto_qr/Feature/Auth/View%20Model/Login%20Cubit/login_cubit.dart';
import 'package:resto_qr/Feature/Auth/Widgets/pick_image_button.dart';
import 'package:resto_qr/Feature/Menu/Dialogs/add_ingredients_dialog.dart';
import 'package:resto_qr/Feature/Menu/Models/item_model.dart';
import 'package:resto_qr/Feature/Menu/View%20Model/Item%20Cubit/item_cubit.dart';
import 'package:resto_qr/Feature/Menu/View%20Model/Item%20Cubit/item_states.dart';
import 'package:resto_qr/Feature/Menu/Widgets/customer_visibility_switch.dart';

class AddItemView extends StatefulWidget {
  const AddItemView({super.key, this.currentItem});

  final ItemModel? currentItem;

  @override
  State<AddItemView> createState() => _AddItemViewState();
}

class _AddItemViewState extends State<AddItemView> {
  late final TextEditingController nameController;
  late final TextEditingController priceController;
  late final TextEditingController descriptionController;

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode priceFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();

  List<String>? imagePaths;
  List<String>? newImages;
  List<String>? deletedImages;

  late final ValueNotifier<List<String>?> ingredients;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late bool isVisible;

  @override
  void initState() {
    nameController = .new(text: widget.currentItem?.name);
    priceController = .new(text: widget.currentItem?.price);
    descriptionController = .new(text: widget.currentItem?.description);
    isVisible = widget.currentItem?.isVisible ?? true;
    ingredients = .new(widget.currentItem?.ingredients);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return BlocListener<ItemCubit, ItemStates>(
      listener: _listener,
      child: LoadingScaffold<ItemCubit, ItemStates>(
        body: Form(
          key: formKey,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                title: Text(
                  isNewItem ? l10n.addNewItem : l10n.editItem,
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
                        initialValue: widget.currentItem?.imageURL,
                        title: l10n.uploadFoodImages,
                        isMultiImage: true,
                        onMultiImageSelected: (images) {
                          imagePaths = images;
                        },
                      ),
                    ),

                    const SliverSizedBox(height: 28),

                    SliverToBoxAdapter(
                      child: Text(
                        l10n.itemDetails,
                        style: AppText().semiBold16(context),
                      ),
                    ),

                    const SliverSizedBox(height: 4),

                    SliverToBoxAdapter(
                      child: Text(
                        l10n.fillItemDetails,
                        style: AppText().caption(context),
                      ),
                    ),

                    const SliverSizedBox(height: 12),

                    SliverToBoxAdapter(
                      child: CustomTextField(
                        controller: nameController,
                        focusNode: nameFocusNode,
                        nextFocus: priceFocusNode,
                        labelText: l10n.itemName,
                        hintText: l10n.itemNameHint,
                        prefixIcon: Icons.restaurant_menu_rounded,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return l10n.enterItemName;
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
                        keyboardType: const TextInputType.numberWithOptions(
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
                        focusNode: descriptionFocusNode,
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
                        l10n.ingredientsOptional,
                        style: AppText().semiBold16(context),
                      ),
                    ),

                    const SliverSizedBox(height: 4),

                    SliverToBoxAdapter(
                      child: Text(
                        l10n.ingredientsDescription,
                        style: AppText().caption(context),
                      ),
                    ),

                    const SliverSizedBox(height: 12),

                    SliverToBoxAdapter(
                      child: GestureDetector(
                        onTap: () async {
                          var res = await AppDialogs().showDialog(
                            context: context,
                            child: AddIngredientsDialog(
                              initialIngredients:
                                  widget.currentItem?.ingredients ??
                                  ingredients.value,
                            ),
                          );

                          ingredients.value = res;
                        },
                        child: CustomContainer(
                          borderRadius: 12,
                          padding: const .symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: ValueListenableBuilder(
                            valueListenable: ingredients,
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
                                        ? l10n.addIngredients
                                        : l10n.ingredientsCount(value.length),
                                    style: AppText().semiBold14(context),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),

                    const SliverSizedBox(height: 28),

                    SliverToBoxAdapter(
                      child: Text(
                        l10n.availability,
                        style: AppText().semiBold16(context),
                      ),
                    ),

                    const SliverSizedBox(height: 4),

                    SliverToBoxAdapter(
                      child: Text(
                        l10n.itemVisibilityDescription,
                        style: AppText().caption(context),
                      ),
                    ),

                    const SliverSizedBox(height: 12),

                    SliverToBoxAdapter(
                      child: CustomerVisibilitySwitch(
                        initialValue: isVisible,
                        onToggle: (value) {
                          isVisible = value;
                        },
                      ),
                    ),

                    const SliverSizedBox(height: 32),

                    SliverToBoxAdapter(
                      child: Center(
                        child: FullWidthButton(
                          labelText: l10n.saveItem,
                          icon: Icons.check_rounded,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (isNewItem) {
                                addItem(context);
                              } else {
                                updateItem();
                              }
                            }
                          },
                        ),
                      ),
                    ),

                    const SliverSizedBox(height: 120),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _listener(BuildContext context, state) {
    if (state is ItemAdded || state is ItemUpdated) {
      Navigator.pop(context);
    }
  }

  void updateItem() {
    organizeImages();

    context.read<ItemCubit>().updateItem(
      item: widget.currentItem!.copyWith(
        name: nameController.text.trim(),
        price: priceController.text.trim(),
        description: descriptionController.text.trim(),
        isVisible: isVisible,
        ingredients: ingredients.value,
      ),
      images: newImages,
      deletedImageUrls: deletedImages,
    );
  }

  void addItem(BuildContext context) {
    var userLogin = context.read<LoginCubit>().state.user;
    context.read<ItemCubit>().addItem(
      item: ItemModel(
        ownerID: userLogin.id,
        restaurantID: userLogin.restaurantID,
        categoryID: context.read<ItemCubit>().categoryID,
        name: nameController.text.trim(),
        price: priceController.text.trim(),
        description: descriptionController.text.trim(),
        imageURL: imagePaths ?? [],
        isVisible: isVisible,
        ingredients: ingredients.value,
      ),
      images: imagePaths!,
    );
  }

  bool get isNewItem => widget.currentItem == null;

  void organizeImages() {
    if (isNewItem) return;

    if (imagePaths == null) {
      deletedImages = [];
      newImages = [];
      return;
    }

    var currentImages = widget.currentItem!.imageURL;

    deletedImages = currentImages.where((element) {
      return !imagePaths!.contains(element);
    }).toList();

    newImages = imagePaths!.where((element) {
      return !currentImages.contains(element);
    }).toList();
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    nameFocusNode.dispose();
    priceFocusNode.dispose();
    descriptionFocusNode.dispose();
    ingredients.dispose();
    super.dispose();
  }
}
