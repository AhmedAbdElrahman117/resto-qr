import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/navigation.dart';
import 'package:resto_qr/Core/Widgets/custom_text_field.dart';
import 'package:resto_qr/Core/Widgets/full_width_button.dart';
import 'package:resto_qr/Core/Widgets/info_box.dart';
import 'package:resto_qr/Core/Widgets/loading_scaffold.dart';
import 'package:resto_qr/Core/Widgets/sliver_sized_box.dart';
import 'package:resto_qr/Feature/Auth/Widgets/pick_image_button.dart';
import 'package:resto_qr/Feature/Menu/Models/category_model.dart';
import 'package:resto_qr/Feature/Menu/View%20Model/Category%20Cubit/category_cubit.dart';
import 'package:resto_qr/Feature/Menu/View%20Model/Category%20Cubit/category_state.dart';
import 'package:resto_qr/Feature/Menu/Widgets/customer_visibility_switch.dart';

class AddCategoryView extends StatefulWidget {
  const AddCategoryView({
    super.key,
    this.currentCategory,
  });

  final CategoryModel? currentCategory;

  @override
  State<AddCategoryView> createState() => _AddCategoryViewState();
}

class _AddCategoryViewState extends State<AddCategoryView> {
  late final TextEditingController _categoryNameController;

  late bool isVisible;

  String? image;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _categoryNameController = .new(text: widget.currentCategory?.name);

    isVisible = widget.currentCategory?.isVisible ?? true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return BlocListener<CategoryCubit, CategoryState>(
      listener: (context, state) {
        if (state is CategoryAdded || state is CategoryUpdated) {
          Navigation().pop(context);
        }
      },
      child: LoadingScaffold<CategoryCubit, CategoryState>(
        body: Form(
          key: _formKey,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                title: Text(
                  isNewCategory() ? l10n.addCategory : l10n.editCategory,
                ),
                centerTitle: true,
                floating: true,
                snap: true,
              ),

              const SliverSizedBox(height: 16),

              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverMainAxisGroup(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Text(
                        l10n.categoryImage,
                        style: AppText().semiBold16(context),
                      ),
                    ),

                    const SliverSizedBox(height: 4),

                    SliverToBoxAdapter(
                      child: Text(
                        l10n.categoryImageDescription,
                        style: AppText().caption(context),
                      ),
                    ),

                    const SliverSizedBox(height: 12),

                    SliverToBoxAdapter(
                      child: PickImageButton(
                        initialValue: isNewCategory()
                            ? null
                            : [?widget.currentCategory!.imageURL],
                        title: l10n.uploadCategoryImage,
                        onImageSelected: (imagePath) {
                          image = imagePath;
                        },
                      ),
                    ),

                    const SliverSizedBox(height: 28),

                    SliverToBoxAdapter(
                      child: Text(
                        l10n.categoryDetails,
                        style: AppText().semiBold16(context),
                      ),
                    ),

                    const SliverSizedBox(height: 4),

                    SliverToBoxAdapter(
                      child: Text(
                        l10n.categoryDetailsDescription,
                        style: AppText().caption(context),
                      ),
                    ),

                    const SliverSizedBox(height: 12),

                    SliverToBoxAdapter(
                      child: CustomTextField(
                        controller: _categoryNameController,
                        labelText: l10n.categoryName,
                        hintText: l10n.categoryNameHint,
                        prefixIcon: Icons.category_rounded,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return l10n.enterCategoryName;
                          }
                          return null;
                        },
                      ),
                    ),

                    const SliverSizedBox(height: 28),

                    SliverToBoxAdapter(
                      child: Text(
                        l10n.displaySetting,
                        style: AppText().semiBold16(context),
                      ),
                    ),

                    const SliverSizedBox(height: 4),

                    SliverToBoxAdapter(
                      child: Text(
                        l10n.categoryVisibilityDescription,
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

                    const SliverSizedBox(height: 16),

                    SliverToBoxAdapter(
                      child: InfoBox(
                        info: l10n.categoryInfo,
                      ),
                    ),

                    const SliverSizedBox(height: 32),

                    SliverToBoxAdapter(
                      child: Center(
                        child: FullWidthButton(
                          labelText: l10n.saveCategory,
                          icon: Icons.check_rounded,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (isNewCategory()) {
                                await addCategory(context);
                              } else {
                                await editCategory(context);
                              }
                            }
                          },
                        ),
                      ),
                    ),

                    const SliverSizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> editCategory(BuildContext context) async {
    var newCategory = widget.currentCategory!.copyWith(
      name: _categoryNameController.text.trim(),
      isVisible: isVisible,
    );
    await context.read<CategoryCubit>().updateCategory(
      category: newCategory,
      image: image,
    );
  }

  Future<void> addCategory(BuildContext context) async {
    var category = CategoryModel(
      menuID: context.read<CategoryCubit>().menuID,
      name: _categoryNameController.text.trim(),
      isVisible: isVisible,
    );

    await context.read<CategoryCubit>().addCategory(
      category: category,
      image: image!,
    );
  }

  bool isNewCategory() => widget.currentCategory == null;

  @override
  void dispose() {
    _categoryNameController.dispose();
    super.dispose();
  }
}
