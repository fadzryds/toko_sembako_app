import 'package:flutter/material.dart';

class DetailBarangPage extends StatelessWidget {
  final Map<String, dynamic> barang;

  const DetailBarangPage({
    super.key,
    required this.barang,
  });

  String formatHarga(dynamic harga) {
    return "Rp ${harga.toString()}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        children: [

          // FOTO PRODUK
          Expanded(
            flex: 4,
            child: Stack(
              children: [

                Image.network(
                  barang['gambar'],
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // DETAIL
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: const BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    barang['nama_barang'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    formatHarga(
                      barang['harga'],
                    ),
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [

                      const Icon(
                        Icons.inventory_2,
                        color: Colors.grey,
                      ),

                      const SizedBox(width: 8),

                      Text(
                        "Stok : ${barang['stok']}",
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Deskripsi",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    barang['deskripsi'] ??
                    "Produk sembako berkualitas dan segar.",
                  ),

                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    height: 55,

                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(
                          0xff5EDAE5,
                        ),
                      ),

                      onPressed: () {},

                      child: const Text(
                        "Tambah Ke Keranjang",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}