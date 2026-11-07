import 'package:resto_qr/Core/Base%20State/base_state.dart';
import 'package:resto_qr/Core/Models/user_model.dart';

class ProfileStates {}

class ProfileInitialState extends ProfileStates {}

class ProfileLoadingState extends ProfileStates implements DataLoading {}

class ProfileLoadedState extends ProfileStates implements DataLoaded {
  final UserModel user;

  ProfileLoadedState({required this.user});

  @override
  get data => user;
}

class ProfileErrorState extends ProfileStates implements DataError {
  final String message;
  ProfileErrorState({required this.message});

  @override
  String get errorMessage => message;
}
