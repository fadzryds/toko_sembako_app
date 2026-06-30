import 'package:flutter/material.dart';
import '../../services/cart_service.dart';
import 'checkout_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartService cartService = CartService();

  List<dynamic> keranjang = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadKeranjang();
  }

  Future<void> loadKeranjang() async {
    try {
      final data = await cartService.getKeranjang();

      print("DATA CART:");
      print(data);

      setState(() {
        keranjang = data;
        isLoading = false;
      });
    } catch (e) {
      print("ERROR CART : $e");

      setState(() {
        isLoading = false;
      });
    }
  }

  int getTotal() {
    int total = 0;

    for (var item in keranjang) {
      final barang = item['barang'];

      total +=
          ((barang['harga'] as num).toInt()) *
          ((item['qty'] as num).toInt());
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),

      appBar: AppBar(
        title: const Text("Keranjang"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : keranjang.isEmpty
              ? const Center(
                  child: Text(
                    "Keranjang kosong",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: keranjang.length,
                        itemBuilder: (context, index) {
                          final item = keranjang[index];

                          final barang = item['barang'];

                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),

                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),

                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 10,
                                ),
                              ],
                            ),

                            child: Padding(
                              padding: const EdgeInsets.all(12),

                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(15),

                                    child: Image.network(
                                      barang['gambar'] ?? '',
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,

                                      errorBuilder:
                                          (_, __, ___) {
                                        return Container(
                                          width: 80,
                                          height: 80,
                                          color: Colors.grey.shade200,
                                          child: const Icon(
                                            Icons.image,
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                                  const SizedBox(width: 12),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,

                                      children: [
                                        Text(
                                          barang['nama_barang'],
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        const SizedBox(height: 5),

                                        Text(
                                          "Rp ${barang['harga']}",
                                          style: const TextStyle(
                                            color: Color(0xff5EDAE5),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        const SizedBox(height: 10),

                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () async {
                                                await cartService.kurangQty(
                                                  item['id'],
                                                  item['qty'],
                                                );

                                                loadKeranjang();
                                              },

                                              icon: const Icon(
                                                Icons.remove_circle_outline,
                                              ),
                                            ),

                                            Text(
                                              item['qty'].toString(),
                                              style: const TextStyle(
                                                fontWeight:
                                                    FontWeight.bold,
                                              ),
                                            ),

                                            IconButton(
                                              onPressed: () async {
                                                await cartService.tambahQty(
                                                  item['id'],
                                                  item['qty'],
                                                );

                                                loadKeranjang();
                                              },

                                              icon: const Icon(
                                                Icons.add_circle_outline,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  IconButton(
                                    onPressed: () async {
                                      await cartService.hapusItem(
                                        item['id'],
                                      );

                                      loadKeranjang();
                                    },

                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.all(20),

                      decoration: const BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),

                      child: Column(
                        mainAxisSize: MainAxisSize.min,

                        children: [
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,

                            children: [
                              const Text(
                                "Total",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Text(
                                "Rp ${getTotal()}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff5EDAE5),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 15),

                          SizedBox(
                            width: double.infinity,
                            height: 55,

                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color(0xff5EDAE5),

                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(15),
                                ),
                              ),

                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => CheckoutPage(
                                      keranjang: keranjang,
                                      total: getTotal(),
                                    ),
                                  ),
                                );
                              },

                              child: const Text(
                                "Checkout",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}