import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'detail_riwayat_page.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {

  final supabase = Supabase.instance.client;

  bool loading = true;

  List transaksi = [];

  @override
  void initState() {
    super.initState();
    getRiwayat();
  }

    Future<void> getRiwayat() async {
    
    try {
    
      final user =
          supabase.auth.currentUser;
  
      print(
        "USER LOGIN : ${user?.id}",
      );
  
      final data =
          await supabase
              .from('transaksi')
              .select()
              .eq(
                'user_id',
                user!.id,
              )
              .order(
                'created_at',
                ascending: false,
              );
  
      print(
        "DATA TRANSAKSI : $data",
      );
  
      setState(() {
      
        transaksi = data;
  
        loading = false;
      });
  
    } catch (e) {
    
      print(
        "ERROR RIWAYAT : $e",
      );
  
      setState(() {
        loading = false;
      });
    }
  }

  Color statusColor(String status) {

    switch (status) {

      case "Diproses":
        return Colors.orange;

      case "Dikirim":
        return Colors.blue;

      case "Selesai":
        return Colors.green;

      default:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xffF6F7FB),

      appBar: AppBar(
        title: const Text(
          "Riwayat Pesanan",
        ),
        centerTitle: true,
      ),

      body: loading
          ? const Center(
              child:
                  CircularProgressIndicator(),
            )
          : transaksi.isEmpty
              ? const Center(
                  child: Text(
                    "Belum ada pesanan",
                  ),
                )
              : ListView.builder(

                  padding:
                      const EdgeInsets.all(15),

                  itemCount:
                      transaksi.length,

                  itemBuilder:
                      (context, index) {

                    final item =
                        transaksi[index];

                    return GestureDetector(

                      onTap: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                DetailRiwayatPage(
                              transaksi:
                                  item,
                            ),
                          ),
                        );
                      },

                      child: Container(

                        margin:
                            const EdgeInsets.only(
                          bottom: 15,
                        ),

                        padding:
                            const EdgeInsets.all(
                          16,
                        ),

                        decoration:
                            BoxDecoration(

                          color: Colors.white,

                          borderRadius:
                              BorderRadius.circular(
                            20,
                          ),

                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.black12,
                              blurRadius: 10,
                            )
                          ],
                        ),

                        child: Column(
                          children: [

                            Row(
                              children: [

                                Container(
                                  padding:
                                      const EdgeInsets.all(
                                    10,
                                  ),

                                  decoration:
                                      BoxDecoration(
                                    color:
                                        const Color(
                                      0xff5EDAE5,
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(
                                      12,
                                    ),
                                  ),

                                  child:
                                      const Icon(
                                    Icons.receipt,
                                    color:
                                        Colors.white,
                                  ),
                                ),

                                const SizedBox(
                                    width: 12),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,

                                    children: [

                                      Text(
                                        "TRX-${item['id']}",
                                        style:
                                            const TextStyle(
                                          fontWeight:
                                              FontWeight.bold,
                                          fontSize:
                                              16,
                                        ),
                                      ),

                                      Text(
                                        item['created_at']
                                            .toString()
                                            .substring(
                                              0,
                                              10,
                                            ),
                                        style:
                                            const TextStyle(
                                          color:
                                              Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(
                                    horizontal:
                                        12,
                                    vertical:
                                        6,
                                  ),

                                  decoration:
                                      BoxDecoration(
                                    color: statusColor(
                                      item['status'],
                                    ),

                                    borderRadius:
                                        BorderRadius.circular(
                                      20,
                                    ),
                                  ),

                                  child: Text(
                                    item['status'],
                                    style:
                                        const TextStyle(
                                      color:
                                          Colors.white,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                                height: 15),

                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,

                              children: [

                                const Text(
                                  "Total",
                                ),

                                Text(
                                  "Rp ${item['total_harga']}",
                                  style:
                                      const TextStyle(
                                    fontWeight:
                                        FontWeight.bold,
                                    color:
                                        Color(
                                      0xff5EDAE5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}