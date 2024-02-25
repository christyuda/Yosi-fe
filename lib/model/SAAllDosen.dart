class Dosen {
  final String nidn;
  final String? namaLengkap;
  Dosen({
    required this.nidn,
    this.namaLengkap,
  });

  factory Dosen.fromJson(Map<String, dynamic> json) {
    return Dosen(
      nidn: json['nidn'],
      namaLengkap: json['nama_lengkap'],
    );
  }
}
