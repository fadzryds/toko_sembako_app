class BarangModel {

  final int id;
  final String namaBarang;
  final double harga;
  final int stok;
  final String gambar;
  final int kategoriId;

  BarangModel({
    required this.id,
    required this.namaBarang,
    required this.harga,
    required this.stok,
    required this.gambar,
    required this.kategoriId,
  });

  factory BarangModel.fromJson(
      Map<String, dynamic> json) {

    return BarangModel(
      id: json['id'],
      namaBarang: json['nama_barang'],
      harga:
          double.parse(json['harga'].toString()),
      stok: json['stok'],
      gambar: json['gambar'] ?? '',
      kategoriId: json['kategori_id'],
    );
  }
}