import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthDatasource {
  final supabase = Supabase.instance.client;

  Future<void> signUp(String email, String password, {String? fullName}) async {
    await supabase.auth.signUp(
      email: email,
      password: password,
      data: {if (fullName != null) 'full_name': fullName},
    );
  }

  Future<void> login(String email, String password) async {
    await supabase.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  bool isLoggedIn() {
    return supabase.auth.currentSession != null;
  }

  String? getUserId() {
    return supabase.auth.currentUser?.id;
  }
}
