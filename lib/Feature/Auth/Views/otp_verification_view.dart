import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/navigation.dart';
import 'package:resto_qr/Core/Utils/toast.dart';
import 'package:resto_qr/Core/Widgets/custom_icon.dart';
import 'package:resto_qr/Core/Widgets/loading_view.dart';
import 'package:resto_qr/Feature/Auth/Helper/otp_timer_controller.dart';
import 'package:resto_qr/Feature/Auth/View%20Model/Otp%20Cubit/otp_cubit.dart';
import 'package:resto_qr/Feature/Auth/View%20Model/Otp%20Cubit/otp_state.dart';
import 'package:resto_qr/Feature/Auth/Widgets/otp_text_field.dart';
import 'package:resto_qr/Feature/Auth/Widgets/otp_timer.dart';
import 'package:resto_qr/Feature/Auth/Widgets/resend_code_button.dart';

class OtpVerificationView extends StatefulWidget {
  const OtpVerificationView({
    super.key,
    required this.email,
    this.onError,
  });

  final void Function(String message)? onError;
  final String email;

  @override
  State<OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView> {
  final TextEditingController otpController = .new();

  final OtpTimerController timer = OtpTimerController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpCubit(email: widget.email),
      child: BlocListener<OtpCubit, OtpState>(
        listener: listener,
        child: Builder(
          builder: (context) {
            final l10n = AppLocalization.of(context);
            return Stack(
              children: [
                Scaffold(
                  appBar: AppBar(),
                  body: Center(
                    child: SingleChildScrollView(
                      padding: .all(20),
                      child: Column(
                        mainAxisAlignment: .center,
                        children: [
                          CustomIcon(icon: Icons.email),
                          SizedBox(height: 20),
                          Text(
                            l10n.enterVerificationCode,
                            style: AppText().bold24(context),
                          ),
                          SizedBox(height: 12),
                          introText(context),
                          SizedBox(height: 40),
                          OtpTextField(
                            controller: otpController,
                            onCompleted: (value) async {
                              if (value.trim().isNotEmpty) {
                                context.read<OtpCubit>().verifyOTP(code: value);
                              }
                            },
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return l10n.otpRequired;
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 32),
                          OtpTimer(seconds: timer),
                          SizedBox(height: 20),
                          ResendCodeButton(
                            seconds: timer,
                            onTap: () async {
                              timer.checkTriesCount();
                              context.read<OtpCubit>().sendOTP();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                BlocSelector<OtpCubit, OtpState, bool>(
                  selector: (state) {
                    return state is OtpLoading;
                  },
                  builder: (context, state) {
                    return LoadingView(show: state);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void listener(BuildContext context, OtpState state) async {
    if (state is OtpSent) {
      timer.startTimer();
      Toast().showSuccess(
        title: AppLocalization.of(context).otpSent,
        description: AppLocalization.of(context).otpSentToEmail,
      );
    } else if (state is OtpSuccess) {
      Navigation().pop(context, true);
    } else if (state is OtpFailed) {
      otpController.clear();
      widget.onError?.call(state.message);
      Toast().showError(
        title: AppLocalization.of(context).loginFailed,
        description: state.message,
      );
    }
  }

  RichText introText(BuildContext context) {
    return RichText(
      textAlign: .center,
      text: TextSpan(
        text: AppLocalization.of(context).verificationCodeIntro,
        style: AppText().regular18(context),
        children: [
          TextSpan(
            text: widget.email,
            style: AppText().semiBold16(context),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    timer.dispose();
    super.dispose();
  }
}
