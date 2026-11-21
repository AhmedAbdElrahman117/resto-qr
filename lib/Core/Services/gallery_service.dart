import 'dart:typed_data';

import 'package:gal/gal.dart';

class GalleryService {
  Future<bool> init() async => await Gal.requestPermission(toAlbum: true);

  Future<bool> get hasAccess async => await Gal.hasPermission();

  Future<void> saveBytes(Uint8List bytes) async =>
      await hasAccess.then((access) async {
        if (access) {
          await Gal.putImageBytes(bytes, name: DateTime.now().toString());
        }
      });

  Future<void> saveFile(String path) async =>
      await hasAccess.then((access) async {
        if (access) {
          await Gal.putImage(path);
        }
      });
}
