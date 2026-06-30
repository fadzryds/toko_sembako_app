import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DetailRiwayatPage extends StatefulWidget {

  final Map transaksi;

  const DetailRiwayatPage({
    super.key,
    required this.transaksi,
  });

  @override
  State<DetailRiwayatPage> createState() =>
      _DetailRiwayatPageState();
}

class _DetailRiwayatPageState
    extends State<DetailRiwayatPage> {

  final supabase = Supabase.instance.client;

  bool loading = true;

  List detail = [];

  @override
  void initState() {
    super.initState();
    getDetail();
  }

  Future<void> getDetail() async {

    final data = await supabase
        .from('detail_transaksi')
        .select('''
          *,
          barang(*)
        ''')
        .eq(
          'transaksi_id',
          widget.transaksi['id'],
        );

    setState(() {

      detail = data;

      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xffF6F7FB),

      appBar: AppBar(
        title:
            const Text("Detail Pesanan"),
      ),

      body: loading
          ? const Center(
              child:
                  CircularProgressIndicator(),
            )
          : Column(
              children: [

                Container(

                  margin:
                      const EdgeInsets.all(15),

                  padding:
                      const EdgeInsets.all(
                    20,
                  ),

                  decoration:
                      BoxDecoration(
                    color:
                        Colors.white,
                    borderRadius:
                        BorderRadius.circular(
                      20,
                    ),
                  ),

                  child: Column(

                    children: [

                      detailInfo(
                        "Nomor Pesanan",
                        "TRX-${widget.transaksi['id']}",
                      ),

                      detailInfo(
                        "Metode",
                        widget.transaksi[
                            'metode_pembayaran'],
                      ),

                      detailInfo(
                        "Status",
                        widget.transaksi[
                            'status'],
                      ),

                      detailInfo(
                        "Total",
                        "Rp ${widget.transaksi['total_harga']}",
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child:
                      ListView.builder(

                    itemCount:
                        detail.length,

                    itemBuilder:
                        (context, index) {

                      final item =
                          detail[index];

                      return Card(

                        margin:
                            const EdgeInsets.symmetric(
                          horizontal:
                              15,
                          vertical: 6,
                        ),

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                            15,
                          ),
                        ),

                        child: ListTile(

                          leading:
                              ClipRRect(
                            borderRadius:
                                BorderRadius.circular(
                              10,
                            ),

                            child:
                                Image.network(
                              item['barang']
                                  ['gambar'],
                              width: 50,
                              height: 50,
                              fit:
                                  BoxFit.cover,
                            ),
                          ),

                          title: Text(
                            item['barang']
                                [
                                'nama_barang'],
                          ),

                          subtitle: Text(
                            "Qty ${item['qty']}",
                          ),

                          trailing:
                              Text(
                            "Rp ${item['subtotal']}",
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget detailInfo(
    String title,
    String value,
  ) {

    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 10,
      ),

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween,

        children: [
          Text(title),
          Text(
            value,
            style:
                const TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}