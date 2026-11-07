import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:resto_qr/Core/Utils/app_directory.dart';

class ImageCompress {
  Future<List<int>?> compressToList(String path) async {
    final result = await FlutterImageCompress.compressWithFile(
      path,
      quality: 75,
      format: CompressFormat.webp, // 💡 Fixed enum syntax
    );
    return result?.toList();
  }

  Future<File?> compressToFile(String path) async {
    // 1. Get the directory
    final tempDir = await AppDirectory().getTemporaryDirectoryPath();

    // 2. Create a unique file path
    final targetPath = '$tempDir/${DateTime.now().millisecondsSinceEpoch}.webp';

    final result = await FlutterImageCompress.compressAndGetFile(
      path,
      targetPath, // 💡 Pass the full file path here
      quality: 75,
      format: CompressFormat.webp,
    );

    return result != null ? File(result.path) : null;
  }

  Future<String?> compressToPath(String path) async {
    final tempDir = await AppDirectory().getTemporaryDirectoryPath();
    final targetPath = '$tempDir/${DateTime.now().millisecondsSinceEpoch}.webp';

    final result = await FlutterImageCompress.compressAndGetFile(
      path,
      targetPath,
      quality: 75,
      format: CompressFormat.webp,
    );

    return result?.path;
  }
}
