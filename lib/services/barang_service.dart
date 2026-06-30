import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/barang_model.dart';

class BarangService {

  final supabase =
      Supabase.instance.client;

  Future<List<BarangModel>>
      getAllBarang() async {

    final response =
        await supabase
            .from('barang')
            .select();

    return response
        .map<BarangModel>(
          (e) =>
              BarangModel.fromJson(e),
        )
        .toList();
  }
}