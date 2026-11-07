import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseRpc {
  SupabaseRpc._();

  static SupabaseRpc? _instance;

  factory SupabaseRpc() => _instance ??= SupabaseRpc._();

  final SupabaseClient _rpc = Supabase.instance.client;

  Future<dynamic> call({
    required String function,
    Map<String, dynamic>? params,
  }) async => await _rpc.rpc(function, params: params);
}
