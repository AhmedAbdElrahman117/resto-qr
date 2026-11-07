import 'package:flutter_bloc/flutter_bloc.dart';

mixin SafeCubit<State> on Cubit<State> {
  void safeEmit(State state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
