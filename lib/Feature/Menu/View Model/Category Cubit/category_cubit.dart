import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Cubit/safe_cubit.dart';
import 'package:resto_qr/Feature/Menu/Models/category_model.dart';
import 'package:resto_qr/Feature/Menu/Repo/category_repo.dart';
import 'package:resto_qr/Feature/Menu/View%20Model/Category%20Cubit/category_state.dart';

class CategoryCubit extends Cubit<CategoryState> with SafeCubit {
  CategoryCubit({required this.menuID}) : super(CategoryInitial()) {
    getCategories();
  }

  final CategoryRepo _repo = .new();

  final String menuID;

  StreamSubscription? _subscription;

  Future<void> getCategories() async {
    safeEmit(CategoryLoading());

    await _subscription?.cancel();

    _subscription = null;

    _subscription = _repo.categoriesStream.stream.listen(
      (categories) {
        if (categories.isEmpty) {
          safeEmit(CategoryEmpty());
        } else {
          safeEmit(CategoryLoaded(categories: categories));
        }
      },
      onError: (error) => safeEmit(CategoryError(error.toString())),
    );

    await _repo.getCateogries(menuID: menuID);
  }

  Future<void> addCategory({
    required CategoryModel category,
    required String image,
  }) async {
    safeEmit(CategoryActionLoading());

    var result = await _repo.addCategory(
      category: category,
      image: image,
      menuID: menuID,
    );

    result.fold(
      (failure) => safeEmit(CategoryError(failure.message)),
      (success) => safeEmit(CategoryAdded()),
    );
  }

  Future<void> updateCategory({
    required CategoryModel category,
    String? image,
  }) async {
    safeEmit(CategoryActionLoading());

    var result = await _repo.updateCategory(
      category: category,
      image: image,
      menuID: menuID,
    );

    result.fold(
      (failure) => safeEmit(CategoryError(failure.message)),
      (success) => safeEmit(CategoryUpdated()),
    );
  }

  Future<void> deleteCategory({required CategoryModel category}) async {
    safeEmit(CategoryDeleteLoading(categoryID: category.id!));

    var result = await _repo.deleteCategory(category: category);

    result.fold(
      (failure) => safeEmit(CategoryError(failure.message)),
      (success) => safeEmit(CategoryDeleted()),
    );
  }

  Future<void> toggleCategoryAvailability({
    required CategoryModel category,
    required bool isVisible,
  }) async {
    safeEmit(CategoryToggleLoading());

    var result = await _repo.toggleCategoryVisibility(
      category: category,
      isVisible: isVisible,
    );

    result.fold(
      (failure) => safeEmit(CategoryError(failure.message)),
      (success) => safeEmit(CategoryToggled(isLive: isVisible)),
    );
  }

  @override
  Future<void> close() {
    log('Closing CategoryCubit');
    _subscription?.cancel();
    return super.close();
  }
}
