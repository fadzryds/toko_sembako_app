import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileService {

  final supabase = Supabase.instance.client;

  Future<Map<String, dynamic>?> getProfile() async {

    final user = supabase.auth.currentUser;

    if (user == null) return null;

    final data = await supabase
        .from('profiles')
        .select()
        .eq('id', user.id)
        .maybeSingle();

    return data;
  }

  Future<void> saveProfile({
    required String nama,
    required String hp,
    required String alamat,
  }) async {

    final user = supabase.auth.currentUser;

    if (user == null) return;

    await supabase
        .from('profiles')
        .upsert({
          'id': user.id,
          'email': user.email,
          'nama_lengkap': nama,
          'no_hp': hp,
          'alamat': alamat,
          'updated_at': DateTime.now().toIso8601String(),
        });
  }
}