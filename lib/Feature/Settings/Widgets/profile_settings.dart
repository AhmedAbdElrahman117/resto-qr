import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/toast.dart';
import 'package:resto_qr/Core/Widgets/loading_scaffold.dart';
import 'package:resto_qr/Core/Widgets/sliver_sized_box.dart';
import 'package:resto_qr/Core/Widgets/custom_text_field.dart';
import 'package:resto_qr/Core/Widgets/full_width_button.dart';
import 'package:resto_qr/Feature/Auth/View%20Model/Login%20Cubit/login_cubit.dart';
import 'package:resto_qr/Feature/Auth/Widgets/phone_text_field.dart';
import 'package:resto_qr/Feature/Auth/Widgets/pick_image_button.dart';
import 'package:resto_qr/Feature/Settings/View%20Model/Profile%20Settings%20Cubit/profile_cubit.dart';
import 'package:resto_qr/Feature/Settings/View%20Model/Profile%20Settings%20Cubit/profile_states.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  late TextEditingController _userNameController;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> _isButtonEnabled = ValueNotifier<bool>(false);

  late String _initialUserName;
  late String _initialName;
  late String _initialPhone;

  bool _isPhoneValid = true;

  String? image;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    final user = context.read<LoginCubit>().state.user;

    _initialUserName = user.userName;
    _initialName = user.restaurantName;
    _initialPhone = user.phone;

    _userNameController = TextEditingController(text: _initialUserName)
      ..addListener(_validateChanges);
    _nameController = TextEditingController(text: _initialName)
      ..addListener(_validateChanges);
    _emailController = TextEditingController(text: user.email);
    _phoneController = TextEditingController(text: _initialPhone)
      ..addListener(_validateChanges);
  }

  void _onProfileUpdated() {
    final user = context.read<LoginCubit>().state.user;

    setState(() {
      _initialUserName = user.userName;
      _initialName = user.restaurantName;
      _initialPhone = user.phone;

      if (_userNameController.text != _initialUserName) {
        _userNameController.text = _initialUserName;
      }
      if (_nameController.text != _initialName) {
        _nameController.text = _initialName;
      }
      if (_emailController.text != user.email) {
        _emailController.text = user.email;
      }
      if (_phoneController.text != _initialPhone) {
        _phoneController.text = _initialPhone;
      }

      image = null;
    });

    _validateChanges();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _isButtonEnabled.dispose();
    super.dispose();
  }

  void _validateChanges() {
    final bool hasChanged =
        _userNameController.text.trim() != _initialUserName ||
        _nameController.text.trim() != _initialName ||
        _phoneController.text.trim() != _initialPhone ||
        image != null;

    final bool isValid =
        _userNameController.text.trim().isNotEmpty &&
        _nameController.text.trim().isNotEmpty &&
        _phoneController.text.trim().isNotEmpty &&
        _isPhoneValid;

    _isButtonEnabled.value = hasChanged && isValid;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return LoadingScaffold<ProfileCubit, ProfileStates>(
      body: BlocListener<ProfileCubit, ProfileStates>(
        listener: _listener,
        child: Form(
          key: _formKey,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                title: Text(l10n.profileSettings),
                centerTitle: true,
                floating: true,
                snap: true,
              ),

              SliverPadding(
                padding: const .symmetric(horizontal: 16),
                sliver: SliverMainAxisGroup(
                  slivers: [
                    const SliverSizedBox(height: 24),

                    SliverToBoxAdapter(
                      child: PickImageButton(
                        key: ValueKey(
                          context
                              .read<LoginCubit>()
                              .state
                              .user
                              .restaurantLogoURL,
                        ),
                        initialValue: [
                          context
                              .read<LoginCubit>()
                              .state
                              .user
                              .restaurantLogoURL!,
                        ],
                        title: l10n.updateLogo,
                        onImageSelected: (imagePath) {
                          image = imagePath;
                          _validateChanges();
                        },
                      ),
                    ),

                    const SliverSizedBox(height: 16),

                    SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          l10n.updateLogoDescription,
                          style: AppText().caption(context),
                        ),
                      ),
                    ),

                    const SliverSizedBox(height: 32),

                    SliverToBoxAdapter(
                      child: Text(
                        l10n.businessDetails,
                        style: AppText().semiBold16(context),
                      ),
                    ),

                    const SliverSizedBox(height: 4),

                    SliverToBoxAdapter(
                      child: Text(
                        l10n.businessDetailsDescription,
                        style: AppText().caption(context),
                      ),
                    ),

                    const SliverSizedBox(height: 16),

                    SliverToBoxAdapter(
                      child: CustomTextField(
                        controller: _userNameController,
                        labelText: l10n.username,
                        hintText: l10n.usernameHint,
                        onChanged: (value) {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                    ),

                    const SliverSizedBox(height: 16),

                    SliverToBoxAdapter(
                      child: CustomTextField(
                        controller: _nameController,
                        labelText: l10n.restaurantName,
                        hintText: l10n.restaurantNameHint,
                        onChanged: (value) {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your restaurant name';
                          }
                          return null;
                        },
                      ),
                    ),

                    const SliverSizedBox(height: 16),

                    SliverToBoxAdapter(
                      child: CustomTextField(
                        controller: _emailController,
                        enabled: false,
                        labelText: l10n.businessEmail,
                        hintText: '',
                      ),
                    ),

                    const SliverSizedBox(height: 16),

                    SliverToBoxAdapter(
                      child: PhoneTextField(
                        controller: _phoneController,
                        onChanged: (number) {
                          try {
                            _isPhoneValid = number.isValidNumber();
                          } catch (e) {
                            _isPhoneValid = false;
                          }
                          _validateChanges();
                        },
                      ),
                    ),

                    const SliverSizedBox(height: 32),

                    SliverToBoxAdapter(
                      child: Center(
                        child: ValueListenableBuilder<bool>(
                          valueListenable: _isButtonEnabled,
                          builder: (context, isEnabled, child) {
                            return FullWidthButton(
                              labelText: l10n.saveChanges,
                              icon: Icons.save_rounded,
                              onPressed: isEnabled
                                  ? () {
                                      if (_formKey.currentState!.validate()) {
                                        context
                                            .read<ProfileCubit>()
                                            .updateProfile(
                                              userId: context
                                                  .read<LoginCubit>()
                                                  .state
                                                  .user
                                                  .id!,
                                              userName: _userNameController.text
                                                  .trim(),
                                              restaurantName: _nameController
                                                  .text
                                                  .trim(),
                                              phoneNumber: _phoneController.text
                                                  .trim(),
                                              imagePath: image,
                                              oldImagePath: context
                                                  .read<LoginCubit>()
                                                  .state
                                                  .user
                                                  .restaurantLogoURL!,
                                            );
                                      }
                                    }
                                  : null,
                            );
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

  void _listener(BuildContext context, state) {
    if (state is ProfileLoadedState) {
      context.read<LoginCubit>().quickLogin(
        user: state.data,
        openHome: false,
      );
      _onProfileUpdated();

      Toast().showSuccess(
        title: AppLocalization.of(context).profileUpdated,
        description: AppLocalization.of(context).profileUpdatedDescription,
      );
    } else if (state is ProfileErrorState) {
      Toast().showError(
        title: AppLocalization.of(context).error,
        description: state.message,
      );
    }
  }
}
