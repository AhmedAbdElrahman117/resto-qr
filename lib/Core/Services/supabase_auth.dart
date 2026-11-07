import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuth {
  SupabaseAuth._();

  static SupabaseAuth? _instance;

  factory SupabaseAuth() => _instance ??= SupabaseAuth._();

  final GoTrueClient _auth = Supabase.instance.client.auth;

  Future<User?> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async =>
      (await _auth.signInWithPassword(email: email, password: password)).user;

  Future<User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String userName,
  }) async => (await _auth.signUp(
    email: email,
    password: password,
    data: {'user_name': userName},
  )).user;

  Future<void> logout() async => await _auth.signOut();
}
