import 'package:resto_qr/Core/Base%20State/base_state.dart';
import 'package:resto_qr/Feature/Menu/Models/item_model.dart';

class TopItemsState {}

class TopItemsInitial extends TopItemsState {}

class TopItemsLoadingState extends TopItemsState implements DataLoading {}

class TopItemsLoadedState extends TopItemsState implements DataLoaded {
  final List<ItemModel> topItems;

  TopItemsLoadedState({required this.topItems});

  @override
  get data => topItems;
}

class TopItemsEmptyState extends TopItemsState implements DataEmpty {}

class TopItemsErrorState extends TopItemsState implements DataError {
  final String message;

  TopItemsErrorState({required this.message});

  @override
  get errorMessage => message;
}
