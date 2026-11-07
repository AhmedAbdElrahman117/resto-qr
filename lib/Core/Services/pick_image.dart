import 'package:image_picker/image_picker.dart';

class PickImage {
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> pickSingleImage() async {
    try {
      return await _picker.pickImage(
        source: ImageSource.gallery,
        requestFullMetadata: true,
      );
    } catch (e) {
      return null;
    }
  }

  Future<List<XFile>?> pickMultipleImages() async {
    try {
      return await _picker.pickMultiImage(requestFullMetadata: true);
    } catch (e) {
      return null;
    }
  }
}
