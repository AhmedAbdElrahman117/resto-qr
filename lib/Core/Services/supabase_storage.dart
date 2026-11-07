import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorage {
  SupabaseStorage._();

  static SupabaseStorage? _instance;

  factory SupabaseStorage() => _instance ??= SupabaseStorage._();

  final _storage = Supabase.instance.client.storage;

  Future<String> store({
    required String bucket,
    required String file,
    required String path,
  }) async {
    return await _storage.from(bucket).upload(path, File(file));
  }

  String getUrl({required String bucket, required String path}) {
    return _storage.from(bucket).getPublicUrl(path);
  }
}
