import 'package:flutter/material.dart';
import '../../services/checkout_service.dart';

class CheckoutPage extends StatefulWidget {
  final List<dynamic> keranjang;
  final int total;

  const CheckoutPage({super.key, required this.keranjang, required this.total});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String metodePembayaran = "COD";

  final alamatController = TextEditingController();

  @override
  void initState() {
    super.initState();

    alamatController.text = "Jl. Raya Depok No.123";
  }

  @override
  Widget build(BuildContext context) {
    int ongkir = 10000;

    int totalBayar = widget.total + ongkir;

    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),

      appBar: AppBar(
        title: const Text("Checkout"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            // =========================
            // ALAMAT
            // =========================
            Container(
              padding: const EdgeInsets.all(15),

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

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Row(
                    children: [
                      Icon(Icons.location_on, color: Color(0xff5EDAE5)),

                      SizedBox(width: 8),

                      Text(
                        "Alamat Pengiriman",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  TextField(
                    controller: alamatController,
                    maxLines: 3,

                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffF6F7FB),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // =========================
            // PRODUK
            // =========================
            Container(
              padding: const EdgeInsets.all(15),

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

              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,

                    child: Text(
                      "Produk",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  ...widget.keranjang.map((item) {
                    final barang = item['barang'];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),

                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),

                            child: Image.network(
                              barang['gambar'],
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(barang['nama_barang']),

                                Text(
                                  "Qty : ${item['qty']}",
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),

                          Text(
                            "Rp ${barang['harga']}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // =========================
            // PEMBAYARAN
            // =========================
            Container(
              padding: const EdgeInsets.all(15),

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

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Text(
                    "Metode Pembayaran",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  RadioListTile(
                    value: "COD",
                    groupValue: metodePembayaran,

                    onChanged: (value) {
                      setState(() {
                        metodePembayaran = value!;
                      });
                    },

                    title: const Text("Cash On Delivery"),
                  ),

                  RadioListTile(
                    value: "Transfer",
                    groupValue: metodePembayaran,

                    onChanged: (value) {
                      setState(() {
                        metodePembayaran = value!;
                      });
                    },

                    title: const Text("Transfer Bank"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // =========================
            // TOTAL
            // =========================
            Container(
              padding: const EdgeInsets.all(20),

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

              child: Column(
                children: [
                  totalRow("Subtotal", "Rp ${widget.total}"),

                  const SizedBox(height: 10),

                  totalRow("Ongkir", "Rp $ongkir"),

                  const Divider(),

                  totalRow("Total", "Rp $totalBayar", isBold: true),
                ],
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff5EDAE5),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),

                onPressed: () async {
                  try {
                    await CheckoutService().checkout(
                      cartItems: widget.keranjang,
                      alamat: alamatController.text,
                      metodePembayaran: metodePembayaran,
                      totalHarga: totalBayar,
                    );

                    if (!mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Pesanan berhasil dibuat")),
                    );

                    Navigator.pop(context);
                  } catch (e) {
                    if (!mounted) return;

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                },
                child: const Text(
                  "Buat Pesanan",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget totalRow(String title, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Text(title),

        Text(
          value,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,

            fontSize: isBold ? 18 : 14,
          ),
        ),
      ],
    );
  }
}
