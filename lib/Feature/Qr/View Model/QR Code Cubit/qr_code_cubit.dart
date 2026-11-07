import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Cubit/safe_cubit.dart';
import 'package:resto_qr/Core/Services/gallery_service.dart';
import 'package:resto_qr/Core/Services/print_service.dart';
import 'package:resto_qr/Core/Utils/app_share.dart';
import 'package:resto_qr/Feature/Qr/View%20Model/QR%20Code%20Cubit/qr_code_state.dart';
import 'package:share_plus/share_plus.dart';

class QrCodeCubit extends Cubit<QrCodeState> with SafeCubit {
  QrCodeCubit({required this.menuUrl}) : super(QrCodeInitial());

  final QrPrinter _qrPrinter = QrPrinter();

  final GalleryService _galleryService = GalleryService();

  final AppShare _appShare = AppShare();

  Uint8List? qrImageBytes;

  final String menuUrl;

  void shareQrCodeImage({required GlobalKey qrKey}) async {
    safeEmit(QrCodeLoading());

    var res = await _appShare.shareFiles(
      files: [
        XFile.fromData(
          await _qrToImgae(qrKey: qrKey),
          name: 'qr_code.png',
          mimeType: 'image/png',
        ),
      ],
    );

    res ? safeEmit(QrCodeShareSuccess()) : safeEmit(QrCodeShareError());
  }

  void shareQrCodeURL() async {
    safeEmit(QrCodeLoading());

    var res = await _appShare.shareText(text: menuUrl);

    res ? safeEmit(QrCodeShareSuccess()) : safeEmit(QrCodeShareError());
  }

  void printQrCode({required GlobalKey qrKey}) async {
    safeEmit(QrCodeLoading());
    try {
      final imageBytes = await _qrToImgae(qrKey: qrKey);

      await _qrPrinter.print(imageBytes);

      safeEmit(QrCodePrintSuccess());
    } catch (e) {
      safeEmit(QrCodePrintError());
    }
  }

  void saveQrCodeToGallery({required GlobalKey qrKey}) async {
    safeEmit(QrCodeLoading());
    try {
      final imageBytes = await _qrToImgae(qrKey: qrKey);

      await _galleryService.saveBytes(imageBytes);

      safeEmit(QrCodeSaveSuccess());
    } catch (e) {
      safeEmit(QrCodeSaveError());
    }
  }

  Future<Uint8List> _qrToImgae({required GlobalKey qrKey}) async {
    if (qrImageBytes == null) {
      RenderRepaintBoundary boundary =
          qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      final ui.Image image = await boundary.toImage();

      final ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      qrImageBytes = byteData!.buffer.asUint8List();

      return qrImageBytes!;
    }
    return qrImageBytes!;
  }
}
