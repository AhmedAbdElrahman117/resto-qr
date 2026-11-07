import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Cubit/safe_cubit.dart';
import 'package:resto_qr/Feature/Menu/Models/item_model.dart';
import 'package:resto_qr/Feature/Menu/Repo/items_repo.dart';
import 'package:resto_qr/Feature/Menu/View%20Model/Item%20Cubit/item_states.dart';

class ItemCubit extends Cubit<ItemStates> with SafeCubit {
  ItemCubit({required this.categoryID}) : super(ItemInitialState()) {
    getItems();
  }

  final ItemsRepo _itemsRepo = ItemsRepo();

  final String categoryID;

  StreamSubscription? _subscription;

  void getItems() async {
    safeEmit(ItemsLoading());

    _subscription = _itemsRepo.itemsStream.stream.listen(
      (items) {
        if (items.isEmpty) {
          safeEmit(ItemsEmpty());
        } else {
          safeEmit(ItemsLoaded(items: items));
        }
      },
      onError: (error) {
        safeEmit(ItemsError(message: error.toString()));
      },
    );

    await _itemsRepo.getItems(categoryID: categoryID);
  }

  void addItem({
    required ItemModel item,
    required List<String> images,
  }) async {
    safeEmit(ItemsLoading());

    var result = await _itemsRepo.addItem(
      item: item,
      images: images,
      categoryID: categoryID,
    );

    result.fold(
      (l) => safeEmit(ItemsError(message: l.message)),
      (r) => safeEmit(ItemAdded()),
    );
  }

  Future<void> updateItem({
    required ItemModel item,
    List<String>? images,
    List<String>? deletedImageUrls,
  }) async {
    safeEmit(ItemsLoading());

    var result = await _itemsRepo.updateItem(
      item: item,
      images: images,
      deletedImageUrls: deletedImageUrls,
      categoryID: categoryID,
    );

    result.fold(
      (l) => safeEmit(ItemsError(message: l.message)),
      (r) => safeEmit(ItemUpdated()),
    );
  }

  Future<void> deleteItem({
    required ItemModel item,
  }) async {
    safeEmit(ItemsLoading());

    var result = await _itemsRepo.deleteItem(item: item);

    result.fold(
      (l) => safeEmit(ItemsError(message: l.message)),
      (r) => safeEmit(ItemDeleted()),
    );
  }

  Future<void> toggleAvailability({
    required ItemModel item,
    required bool isVisible,
  }) async {
    var result = await _itemsRepo.toggleItemVisibility(
      item: item,
      isVisible: isVisible,
    );

    result.fold(
      (l) => safeEmit(ItemsError(message: l.message)),
      (r) => safeEmit(ItemUpdated()),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    _itemsRepo.dispose();
    return super.close();
  }
}
