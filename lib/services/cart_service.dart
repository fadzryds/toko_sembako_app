import 'package:supabase_flutter/supabase_flutter.dart';

class CartService {

  final supabase = Supabase.instance.client;

  Future<void> tambahKeKeranjang(
    int barangId,
  ) async {

    final user =
        supabase.auth.currentUser;

    if (user == null) {
      throw Exception("User belum login");
    }

    final existing =
        await supabase
            .from('keranjang')
            .select()
            .eq('user_id', user.id)
            .eq('barang_id', barangId);

    if (existing.isNotEmpty) {

      final qtyLama =
          existing.first['qty'];

      await supabase
          .from('keranjang')
          .update({
            'qty': qtyLama + 1,
          })
          .eq(
            'id',
            existing.first['id'],
          );

    } else {

      await supabase
          .from('keranjang')
          .insert({
            'user_id': user.id,
            'barang_id': barangId,
            'qty': 1,
          });
    }
  }

  Future<List<dynamic>> getKeranjang() async {

   final user = supabase.auth.currentUser;

    if (user == null) {
      print("USER NULL");
      return [];
    }

    final data = await supabase
        .from('keranjang')
        .select('''
          *,
          barang(*)
        ''')
        .eq('user_id', user.id);

    print("DATA KERANJANG:");
    print(data);

    return data;
  }

  Future<void> tambahQty(
    int keranjangId,
    int qty,
  ) async {

    await supabase
        .from('keranjang')
        .update({
          'qty': qty + 1,
        })
        .eq(
          'id',
          keranjangId,
        );
  }

  Future<void> kurangQty(
    int keranjangId,
    int qty,
  ) async {

    if (qty <= 1) {

      await supabase
          .from('keranjang')
          .delete()
          .eq(
            'id',
            keranjangId,
          );

      return;
    }

    await supabase
        .from('keranjang')
        .update({
          'qty': qty - 1,
        })
        .eq(
          'id',
          keranjangId,
        );
  }

  Future<void> hapusItem(
    int keranjangId,
  ) async {

    await supabase
        .from('keranjang')
        .delete()
        .eq(
          'id',
          keranjangId,
        );
  }
}