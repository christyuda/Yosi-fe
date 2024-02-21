import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sidang_apps/model/SASidangData.dart';

class DetailSidangScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SidangData sidangData = Get.arguments as SidangData;
    String jenisSidang = sidangData.jenisSidang;

    if (jenisSidang.toLowerCase() == 'p1') {
      jenisSidang = 'Proyek 1';
    } else if (jenisSidang.toLowerCase() == 'p2') {
      jenisSidang = 'Proyek 2';
    } else if (jenisSidang.toLowerCase() == 'p3') {
      jenisSidang = 'Proyek 3';
    } else if (jenisSidang.toLowerCase() == 'i1') {
      jenisSidang = 'Internship 1';
    } else if (jenisSidang.toLowerCase() == 'i2') {
      jenisSidang = 'Internship 2';
    } else if (jenisSidang.toLowerCase() == 'ta') {
      jenisSidang = 'Tugas Akhir';
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Detail Sidang'),
              background: Image.network(
                'https://via.placeholder.com/500x200', // Ganti dengan gambar yang sesuai
                fit: BoxFit.cover,
              ),
            ),
            floating: false,
            pinned: true,
            snap: false,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildInfoRow('Jenis Sidang', jenisSidang),
                      buildInfoRow('Tanggal Pengajuan',
                          sidangData.tglPengajuan.toString()),
                      buildInfoRow('URL Proposal',
                          sidangData.urlProposal ?? 'Tidak Ada'),
                      buildInfoRow('Judul', sidangData.judul),
                      buildInfoRow('Tahap', sidangData.tahap),
                      buildInfoRow('Pembimbing', sidangData.pembimbing),
                      buildInfoRow('Penguji', sidangData.penguji),
                      buildInfoRow('Tahun Akademik', sidangData.tahunAkademik),
                      buildInfoRow(
                          'Tanggal Sidang',
                          sidangData.tglSidang?.toString() ??
                              'Belum Ditentukan'),
                      buildInfoRow('Tanggal Approve',
                          sidangData.tglApprove?.toString() ?? 'Belum Approve'),
                      buildInfoRow('Nilai',
                          sidangData.nilai?.toString() ?? 'Belum Dinilai'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
