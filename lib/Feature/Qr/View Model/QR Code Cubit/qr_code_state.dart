import 'package:resto_qr/Core/Base%20State/base_state.dart';

class QrCodeState {}

class QrCodeInitial extends QrCodeState {}

class QrCodeLoading extends QrCodeState implements DataLoading {}

class QrCodeShareSuccess extends QrCodeState {}

class QrCodeShareError extends QrCodeState {}

class QrCodePrintSuccess extends QrCodeState {}

class QrCodePrintError extends QrCodeState {}

class QrCodeSaveSuccess extends QrCodeState {}

class QrCodeSaveError extends QrCodeState {}
