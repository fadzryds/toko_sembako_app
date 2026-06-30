import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {

  final SupabaseClient supabase =
      Supabase.instance.client;

  // ======================
  // REGISTER
  // ======================

  Future<String?> register({
    required String nama,
    required String email,
    required String password,
  }) async {

    try {

      print("=== REGISTER DIMULAI ===");
      print("Nama     : $nama");
      print("Email    : $email");

      final AuthResponse response =
          await supabase.auth.signUp(
        email: email,
        password: password,
      );

      final user = response.user;

      if (user == null) {
        return "Gagal membuat akun";
      }

      // Cek apakah data user sudah ada
      final existingUser =
          await supabase
              .from('users')
              .select()
              .eq('id', user.id)
              .maybeSingle();

      if (existingUser == null) {

        await supabase.from('users').insert({
          'id': user.id,
          'nama': nama,
          'email': email,
          'role': 'customer',
        });
      }

      return null;

    } on AuthException catch (e) {

      print("AUTH ERROR: ${e.message}");
      return e.message;

    } catch (e) {

      print("REGISTER ERROR: $e");
      return e.toString();
    }
  }

  // ======================
  // LOGIN
  // ======================

  Future<String?> signIn({
    required String email,
    required String password,
  }) async {

    try {

      await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      return null;

    } on AuthException catch (e) {

      print("LOGIN ERROR: ${e.message}");
      return e.message;

    } catch (e) {

      print("LOGIN ERROR: $e");
      return e.toString();
    }
  }

  // ======================
  // LOGOUT
  // ======================

  Future<void> signOut() async {

    await supabase.auth.signOut();
  }

  // ======================
  // CURRENT USER
  // ======================

  User? getCurrentUser() {

    return supabase.auth.currentUser;
  }

  // ======================
  // GET ROLE
  // ======================

  Future<String?> getRole() async {

    try {

      final user =
          supabase.auth.currentUser;

      if(user == null) return null;

      final data =
          await supabase
              .from('users')
              .select('role')
              .eq('id', user.id)
              .single();

      return data['role'];

    } catch (e) {

      print(
        "GET ROLE ERROR: $e",
      );

      return null;
    }
  }
}