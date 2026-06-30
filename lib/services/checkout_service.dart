import 'package:supabase_flutter/supabase_flutter.dart';

class CheckoutService {

  final supabase = Supabase.instance.client;

  Future<void> checkout({
    required List<dynamic> cartItems,
    required String alamat,
    required String metodePembayaran,
    required int totalHarga,
  }) async {

    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception(
        "User belum login",
      );
    }

    final transaksi =
        await supabase
            .from('transaksi')
            .insert({
              'user_id': user.id,
              'alamat': alamat,
              'metode_pembayaran':
                  metodePembayaran,
              'total_harga':
                  totalHarga,
              'status':
                  'Menunggu Konfirmasi',
            })
            .select()
            .single();

    final transaksiId =
        transaksi['id'];

    for (final item in cartItems) {

      await supabase
          .from('detail_transaksi')
          .insert({
            'transaksi_id':
                transaksiId,
            'barang_id':
                item['barang_id'],
            'qty':
                item['qty'],
            'harga':
                item['barang']['harga'],
            'subtotal':
                item['qty'] *
                item['barang']['harga'],
          });

      await supabase
          .from('barang')
          .update({
            'stok':
                item['barang']['stok'] -
                item['qty'],
          })
          .eq(
            'id',
            item['barang_id'],
          );
    }

    await supabase
        .from('cart')
        .delete()
        .eq(
          'user_id',
          user.id,
        );
  }
}