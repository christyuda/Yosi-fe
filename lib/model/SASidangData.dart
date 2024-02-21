class SidangData {
  final String mahasiswaId;
  final List<String> revisiText;
  final String status;
  final String jenisSidang;
  final String tglPengajuan;
  final String urlProposal;
  final String judul;
  final String tahap;
  final String pembimbing;
  final String penguji;
  final String tahunAkademik;
  final String? tglSidang;
  final String? tglApprove;
  final String? nilai;
  final String createdAt;

  SidangData({
    required this.mahasiswaId,
    required this.revisiText,
    required this.status,
    required this.jenisSidang,
    required this.tglPengajuan,
    required this.urlProposal,
    required this.judul,
    required this.tahap,
    required this.pembimbing,
    required this.penguji,
    required this.tahunAkademik,
    required this.tglSidang,
    required this.tglApprove,
    required this.nilai,
    required this.createdAt,
  });

  factory SidangData.fromJson(Map<String, dynamic> json) {
    return SidangData(
      mahasiswaId: json['mahasiswa_id'],
      revisiText: List<String>.from(json['revisi_text']),
      status: json['status'],
      jenisSidang: json['jenis_sidang'],
      tglPengajuan: json['tgl_pengajuan'],
      urlProposal: json['url_proposal'],
      judul: json['judul'],
      tahap: json['tahap'],
      pembimbing: json['pembimbing'],
      penguji: json['penguji'],
      tahunAkademik: json['tahun_akademik'],
      tglSidang: json['tgl_sidang'],
      tglApprove: json['tgl_approve'],
      nilai: json['nilai'],
      createdAt: json['createdAt'],
    );
  }
}
