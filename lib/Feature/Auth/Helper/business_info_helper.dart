import 'package:flutter/material.dart';
import 'package:resto_qr/Feature/Maps/Model/place_model.dart';

class BusinessInfoHelper {
  final TextEditingController nameController = .new();
  final TextEditingController addressController = .new();
  final TextEditingController descriptionController = .new();
  final TextEditingController locationController = .new();

  String? image;

  final FocusNode nameFocus = .new();
  final FocusNode addressFocus = .new();
  final FocusNode descriptionFocus = .new();

  final GlobalKey<FormState> businessInfo = .new();

  PlaceModel? selectedPlace;

  bool validateFields() =>
      businessInfo.currentState != null &&
      businessInfo.currentState!.validate();
}
