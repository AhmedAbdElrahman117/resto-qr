import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Cubit/safe_cubit.dart';
import 'package:resto_qr/Feature/Menu/Repo/items_repo.dart';
import 'package:resto_qr/Feature/Home/View%20Model/Top%20Items%20Cubit/top_items_state.dart';

class TopItemsCubit extends Cubit<TopItemsState> with SafeCubit {
  TopItemsCubit({required this.restaurantId}) : super(TopItemsInitial()) {
    getAllItems();
  }

  final _repo = ItemsRepo();

  final String restaurantId;

  void getAllItems() async {
    safeEmit(TopItemsLoadingState());

    var res = await _repo.getAllItems(restaurantId: restaurantId);

    res.fold(
      (l) => safeEmit(TopItemsErrorState(message: l.message)),
      (r) => r.isEmpty
          ? safeEmit(TopItemsEmptyState())
          : safeEmit(TopItemsLoadedState(topItems: r)),
    );
  }
}
