import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Cubit/safe_cubit.dart';
import 'package:resto_qr/Feature/Settings/Repo/profile_settings_repo.dart';
import 'package:resto_qr/Feature/Settings/View%20Model/Profile%20Settings%20Cubit/profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates> with SafeCubit {
  ProfileCubit() : super(ProfileInitialState());

  final ProfileSettingsRepo _repo = ProfileSettingsRepo();

  void updateProfile({
    required String userId,
    required String userName,
    required String restaurantName,
    required String phoneNumber,
    required String oldImagePath,
    String? imagePath,
  }) async {
    safeEmit(ProfileLoadingState());

    final res = await _repo.updateProfileSettings(
      userId: userId,
      userName: userName,
      restaurantName: restaurantName,
      phoneNumber: phoneNumber,
      oldImagePath: oldImagePath,
      imagePath: imagePath,
    );

    res.fold(
      (l) => safeEmit(ProfileErrorState(message: l.message)),
      (data) => safeEmit(ProfileLoadedState(user: data)),
    );
  }
}
