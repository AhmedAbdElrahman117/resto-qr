import 'package:resto_qr/Core/Base%20State/base_state.dart';
import 'package:resto_qr/Feature/Menu/Models/item_model.dart';

class ItemStates {}

class ItemInitialState extends ItemStates {}

class ItemsLoading extends ItemStates implements DataLoading {}

class ItemsLoaded extends ItemStates implements DataLoaded<List<ItemModel>> {
  final List<ItemModel> items;

  ItemsLoaded({required this.items});

  @override
  List<ItemModel> get data => items;
}

class ItemsError extends ItemStates implements DataError {
  final String message;

  ItemsError({required this.message});

  @override
  String get errorMessage => message;
}

class ItemsEmpty extends ItemStates implements DataEmpty {}

class ItemAdded extends ItemStates {}

class ItemUpdated extends ItemStates {}

class ItemDeleted extends ItemStates {}
