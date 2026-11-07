import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_dialogs.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';
import 'package:resto_qr/Core/Utils/native_toast.dart';
import 'package:resto_qr/Core/Utils/toast.dart';
import 'package:resto_qr/Core/Widgets/bloc_widget.dart';
import 'package:resto_qr/Core/Widgets/custom_container.dart';
import 'package:resto_qr/Core/Widgets/info_box.dart';
import 'package:resto_qr/Core/Widgets/sliver_sized_box.dart';
import 'package:resto_qr/Feature/Qr/Dialogs/share_options_sheet.dart';
import 'package:resto_qr/Feature/Qr/View%20Model/QR%20Code%20Cubit/qr_code_cubit.dart';
import 'package:resto_qr/Feature/Qr/View%20Model/QR%20Code%20Cubit/qr_code_state.dart';
import 'package:resto_qr/Feature/Qr/Widgets/qr_code_widget.dart';

class QrCodePage extends StatefulWidget {
  const QrCodePage({super.key});

  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  final GlobalKey _qrKey = GlobalKey();

  late final String menuUrl;

  @override
  void initState() {
    menuUrl = context.read<QrCodeCubit>().menuUrl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return BlocListener<QrCodeCubit, QrCodeState>(
      listener: _listener,
      child: Scaffold(
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              title: Text(l10n.qrCode),
              centerTitle: true,
              floating: true,
              snap: true,
            ),

            const SliverSizedBox(height: 24),

            SliverPadding(
              padding: const .symmetric(horizontal: 16),
              sliver: SliverMainAxisGroup(
                slivers: [
                  SliverToBoxAdapter(
                    child: CustomContainer(
                      padding: const .all(24),
                      child: Column(
                        spacing: 28,
                        children: [
                          RepaintBoundary(
                            key: _qrKey,
                            child: QrCodeWidget(data: menuUrl),
                          ),

                          urlLabel(context),
                        ],
                      ),
                    ),
                  ),

                  const SliverSizedBox(height: 20),

                  SliverToBoxAdapter(
                    child: InfoBox(
                      info: l10n.qrCodeInfo,
                    ),
                  ),

                  const SliverSizedBox(height: 32),

                  SliverToBoxAdapter(
                    child: Text(
                      l10n.actions,
                      style: AppText().semiBold16(context),
                    ),
                  ),

                  const SliverSizedBox(height: 4),

                  SliverToBoxAdapter(
                    child: Text(
                      l10n.qrCodeActionsDescription,
                      style: AppText().caption(context),
                    ),
                  ),

                  const SliverSizedBox(height: 16),

                  SliverToBoxAdapter(
                    child: Column(
                      spacing: 12,
                      children: [
                        Row(
                          spacing: 12,
                          children: [
                            Expanded(
                              child: BlocWidget<QrCodeCubit, QrCodeState>(
                                builder: (context, state) {
                                  var isLoading = state is QrCodeLoading;

                                  return _filledButton(
                                    context,
                                    label: l10n.share,
                                    icon: Icons.share_rounded,
                                    onPressed: isLoading
                                        ? null
                                        : () {
                                            AppSheets().showSheet(
                                              context: context,
                                              child: ShareOptionsSheet(
                                                onShareURL: isLoading
                                                    ? null
                                                    : () {
                                                        context
                                                            .read<QrCodeCubit>()
                                                            .shareQrCodeURL();
                                                      },
                                                onShareImage: isLoading
                                                    ? null
                                                    : () {
                                                        context
                                                            .read<QrCodeCubit>()
                                                            .shareQrCodeImage(
                                                              qrKey: _qrKey,
                                                            );
                                                      },
                                              ),
                                            );
                                          },
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              child: BlocWidget<QrCodeCubit, QrCodeState>(
                                builder: (context, state) {
                                  var isLoading = state is QrCodeLoading;

                                  return _outlinedButton(
                                    context,
                                    label: l10n.print,
                                    icon: Icons.print_rounded,
                                    onPressed: isLoading
                                        ? null
                                        : () {
                                            context
                                                .read<QrCodeCubit>()
                                                .printQrCode(qrKey: _qrKey);
                                          },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          width: .infinity,
                          child: BlocWidget<QrCodeCubit, QrCodeState>(
                            builder: (context, state) {
                              var isLoading = state is QrCodeLoading;

                              return _filledButton(
                                context,
                                label: l10n.saveToGallery,
                                icon: Icons.download_rounded,
                                onPressed: isLoading
                                    ? null
                                    : () {
                                        context
                                            .read<QrCodeCubit>()
                                            .saveQrCodeToGallery(qrKey: _qrKey);
                                      },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SliverSizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _listener(BuildContext context, state) {
    if (state is QrCodeSaveSuccess) {
      NativeToast().show(message: AppLocalization.of(context).saveToGallery);
    } else if (state is QrCodeSaveError) {
      Toast().showSuccess(
        title: AppLocalization.of(context).saveToGallery,
        description: AppLocalization.of(context).savedToGalleryDescription,
      );
    } else if (state is QrCodePrintError) {
      Toast().showError(
        title: AppLocalization.of(context).printFailed,
        description: AppLocalization.of(context).qrPrintErrorDescription,
      );
    } else if (state is QrCodeShareError) {
      Toast().showError(
        title: AppLocalization.of(context).shareFailed,
        description: AppLocalization.of(context).qrShareErrorDescription,
      );
    }
  }

  Widget urlLabel(BuildContext context) {
    return Material(
      type: .transparency,
      child: InkWell(
        borderRadius: .circular(12),
        onTap: () async {
          await Clipboard.setData(.new(text: menuUrl));
          if (context.mounted) {
            NativeToast().show(
              message: AppLocalization.of(context).menuUrlCopied,
            );
          }
        },
        child: Padding(
          padding: const .symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: .center,
            spacing: 6,
            children: [
              Icon(
                Icons.copy,
                color: AppConstants().neonBlue,
              ),
              Flexible(
                child: Text(
                  menuUrl,
                  style: AppText().semiBold14(
                    context,
                    AppConstants().neonBlue,
                  ),
                  maxLines: 1,
                  overflow: .ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _filledButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    VoidCallback? onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label, style: AppText().semiBold16(context, Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppConstants().neonBlue,
        disabledBackgroundColor: AppTheme().borderColor(context),
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const .symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: .circular(12),
        ),
      ),
    );
  }

  Widget _outlinedButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    VoidCallback? onPressed,
  }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label, style: AppText().semiBold16(context)),
      style: OutlinedButton.styleFrom(
        disabledBackgroundColor: AppTheme().borderColor(context),
        foregroundColor: AppTheme().primaryText(context),
        padding: const .symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: .circular(12),
        ),
        side: BorderSide(
          color: AppTheme().borderColor(context),
          width: 2,
        ),
      ),
    );
  }
}
