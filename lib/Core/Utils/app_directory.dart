import 'dart:io';
import 'package:path_provider/path_provider.dart' as path;

class AppDirectory {
  AppDirectory._();

  static AppDirectory? _instance;

  factory AppDirectory() {
    _instance ??= AppDirectory._();
    return _instance!;
  }

  Future<Directory> getAppDirectory() async =>
      await path.getApplicationDocumentsDirectory();

  Future<String> getAppDirectoryPath() async =>
      (await path.getApplicationDocumentsDirectory()).path;

  Future<Directory> getTemporaryDirectory() async =>
      await path.getTemporaryDirectory();

  Future<String> getTemporaryDirectoryPath() async =>
      (await path.getTemporaryDirectory()).path;

  Future<Directory?> getDownloadsDirectory() async =>
      await path.getDownloadsDirectory();

  Future<String?> getDownloadsDirectoryPath() async =>
      (await path.getDownloadsDirectory())?.path;
}
