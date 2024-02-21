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
      jenisSidang = 'Proye 3';
    } else if (jenisSidang.toLowerCase() == 'i1') {
      jenisSidang = 'Internship 1';
    } else if (jenisSidang.toLowerCase() == 'i2') {
      jenisSidang = 'Internship 2';
    } else if (jenisSidang.toLowerCase() == 'ta') {
      jenisSidang = 'Tugas Akhir';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Sidang'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Judul: ${sidangData.judul}'),
            Text('Tahap: ${sidangData.tahap}'),
            Text('Tanggal Pengajuan: ${sidangData.tglPengajuan.toString()}'),

            Text('Tahap: ${jenisSidang}'),
            // Tambahkan informasi lain sesuai kebutuhan
          ],
        ),
      ),
    );
  }
}
