import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDb {
  SupabaseDb._();

  static SupabaseDb? _instance;

  factory SupabaseDb() => _instance ??= SupabaseDb._();

  final SupabaseClient _db = Supabase.instance.client;

  Future<PostgrestList> getAll({
    required String table,
    String? columns,
  }) async {
    return await _db.from(table).select('*');
  }

  PostgrestFilterBuilder<List<Map<String, dynamic>>> get({
    required String table,
    String? columns,
  }) {
    return _db.from(table).select(columns ?? '*');
  }

  SupabaseStreamFilterBuilder getStream({required String table}) {
    return _db.from(table).stream(primaryKey: ['id']);
  }

  Future<void> add({
    required String table,
    required Map<String, dynamic> data,
  }) async {
    await _db.from(table).insert(data);
  }

  Future<void> update({
    required String table,
    required Map<String, dynamic> data,
    required dynamic id,
  }) async {
    await _db.from(table).update(data).eq('id', id);
  }

  Future<void> delete({
    required String table,
    required dynamic id,
  }) async {
    await _db.from(table).delete().eq('id', id);
  }
}
