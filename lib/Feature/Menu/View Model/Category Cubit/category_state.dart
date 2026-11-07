import 'package:resto_qr/Core/Base%20State/base_state.dart';
import 'package:resto_qr/Feature/Menu/Models/category_model.dart';

class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState implements DataLoading {}

class CategoryActionLoading extends CategoryState implements DataLoading {}

class CategoryEmpty extends CategoryState implements DataEmpty {}

class CategoryError extends CategoryState implements DataError {
  final String message;

  CategoryError(this.message);

  @override
  String get errorMessage => message;
}

class CategoryLoaded extends CategoryState
    implements DataLoaded<List<CategoryModel>> {
  final List<CategoryModel> categories;

  CategoryLoaded({required this.categories});

  @override
  List<CategoryModel> get data => categories;
}

class CategoryAdded extends CategoryState {}

class CategoryUpdated extends CategoryState {}

class CategoryDeleteLoading extends CategoryState {
  final String categoryID;

  CategoryDeleteLoading({required this.categoryID});
}

class CategoryDeleted extends CategoryState {}

class CategoryToggled extends CategoryState {
  final bool isLive;

  CategoryToggled({required this.isLive});
}

class CategoryToggleLoading extends CategoryState {}
