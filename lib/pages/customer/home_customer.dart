import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';  
import '../../services/cart_service.dart';
import 'detail_barang_page.dart';

class HomeCustomer extends StatefulWidget {
  const HomeCustomer({super.key});

  @override
  State<HomeCustomer> createState() => _HomeCustomerState();
}

class _HomeCustomerState extends State<HomeCustomer> {
  final supabase = Supabase.instance.client;

  bool isLoading = true;
  List<dynamic> barangList = [];

  @override
  void initState() {
    super.initState();
    getBarang();
  }

  Future<void> getBarang() async {
    try {
      final data = await supabase
          .from('barang')
          .select()
          .order('id');

      setState(() {
        barangList = data;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("ERROR : $e");

      setState(() {
        isLoading = false;
      });
    }
  }

  String formatHarga(dynamic harga) {
    return "Rp ${harga.toString()}";
  }

  Future<void> tambahKeranjang(
    Map<String, dynamic> barang,
  ) async {
    try {
      await CartService().tambahKeKeranjang(
        barang['id'],
      );
    
      debugPrint(
        "BERHASIL TAMBAH ${barang['id']}"
      );
    
      if (!mounted) return;
    
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "${barang['nama_barang']} ditambahkan",
          ),
        ),
      );
    } catch (e) {
      debugPrint("ERROR CART : $e");
    }
    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),

      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: getBarang,
                child: SingleChildScrollView(
                  physics:
                      const AlwaysScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.all(15),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      // HEADER
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                            children: const [
                              Text(
                                "Hello 👋",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Toko Sembako",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          const CircleAvatar(
                            radius: 25,
                            backgroundColor:
                                Color(0xff5EDAE5),
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // SEARCH
                      TextField(
                        decoration: InputDecoration(
                          hintText:
                              "Cari barang...",
                          prefixIcon:
                              const Icon(Icons.search),

                          filled: true,
                          fillColor:
                              Colors.white,

                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                                    15),
                            borderSide:
                                BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // BANNER
                      Container(
                        height: 180,

                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(
                                  20),

                          image:
                              const DecorationImage(
                            image: AssetImage(
                              "assets/images/banner.png",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        "Best Offer",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      GridView.builder(
                        shrinkWrap: true,

                        physics:
                            const NeverScrollableScrollPhysics(),

                        itemCount:
                            barangList.length,

                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.72,
                        ),

                        itemBuilder:
                            (context, index) {

                          final barang =
                              barangList[index];

                          return InkWell(
                            borderRadius:
                                BorderRadius.circular(
                                    18),

                            onTap: () {

                              Navigator.push(
                                context,

                                MaterialPageRoute(
                                  builder: (_) =>
                                      DetailBarangPage(
                                    barang:
                                        barang,
                                  ),
                                ),
                              );
                            },

                            child: Container(
                              decoration:
                                  BoxDecoration(
                                color:
                                    Colors.white,

                                borderRadius:
                                    BorderRadius
                                        .circular(
                                  18,
                                ),

                                boxShadow: [
                                  BoxShadow(
                                    color: Colors
                                        .black
                                        .withOpacity(
                                            0.05),
                                    blurRadius:
                                        10,
                                    offset:
                                        const Offset(
                                            0, 4),
                                  ),
                                ],
                              ),

                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,

                                children: [

                                  Expanded(
                                    child: Stack(
                                      children: [

                                        Hero(
                                          tag:
                                              "barang_${barang['id']}",

                                          child:
                                              ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft:
                                                  Radius.circular(
                                                      18),
                                              topRight:
                                                  Radius.circular(
                                                      18),
                                            ),

                                            child:
                                                Image.network(
                                              barang[
                                                      'gambar'] ??
                                                  '',

                                              width: double
                                                  .infinity,

                                              fit: BoxFit
                                                  .cover,

                                              errorBuilder:
                                                  (
                                                    context,
                                                    error,
                                                    stack,
                                                  ) {
                                                return const Center(
                                                  child:
                                                      Icon(
                                                    Icons
                                                        .image,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),

                                        Positioned(
                                          top: 8,
                                          right: 8,

                                          child:
                                              GestureDetector(
                                            onTap:
                                                () async {
                                              await tambahKeranjang(
                                                barang,
                                              );
                                            },

                                            child:
                                                Container(
                                              padding:
                                                  const EdgeInsets.all(
                                                      8),

                                              decoration:
                                                  const BoxDecoration(
                                                color:
                                                    Color(
                                                  0xff5EDAE5,
                                                ),

                                                shape: BoxShape
                                                    .circle,
                                              ),

                                              child:
                                                  const Icon(
                                                Icons
                                                    .add,
                                                color:
                                                    Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding:
                                        const EdgeInsets
                                            .all(10),

                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,

                                      children: [

                                        Text(
                                          barang[
                                              'nama_barang'],

                                          maxLines:
                                              1,

                                          overflow:
                                              TextOverflow
                                                  .ellipsis,

                                          style:
                                              const TextStyle(
                                            fontWeight:
                                                FontWeight
                                                    .bold,
                                            fontSize:
                                                14,
                                          ),
                                        ),

                                        const SizedBox(
                                            height:
                                                5),

                                        Text(
                                          formatHarga(
                                            barang[
                                                'harga'],
                                          ),

                                          style:
                                              const TextStyle(
                                            color:
                                                Color(
                                              0xff5EDAE5,
                                            ),

                                            fontWeight:
                                                FontWeight
                                                    .bold,
                                          ),
                                        ),

                                        const SizedBox(
                                            height:
                                                5),

                                        Text(
                                          "Stok : ${barang['stok']}",

                                          style:
                                              const TextStyle(
                                            color:
                                                Colors
                                                    .grey,
                                            fontSize:
                                                12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}