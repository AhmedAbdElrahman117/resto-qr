import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseFunction {
  SupabaseFunction._();

  static SupabaseFunction? _instance;

  factory SupabaseFunction() => _instance ??= SupabaseFunction._();

  Future<FunctionResponse> call({
    required String name,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    return await Supabase.instance.client.functions.invoke(
      name,
      headers: headers,
      body: body,
    );
  }
}
