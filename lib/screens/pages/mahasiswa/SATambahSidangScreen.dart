import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sidang_apps/controllers/SAGetAlldosen.dart';
import 'package:sidang_apps/controllers/SASidangController.dart';
import 'package:sidang_apps/model/SAAllDosen.dart';

class TambahSidangScreen extends StatelessWidget {
  final TextEditingController urlProposalController = TextEditingController();
  final TextEditingController judulController = TextEditingController();
  final TextEditingController tahunAkademikController = TextEditingController();
  final TextEditingController jenisSidangController = TextEditingController();
  final TextEditingController revisiTextController = TextEditingController();
  final List<String> revisiTextList = [];
  final TextEditingController pembimbingController = TextEditingController();
  final TextEditingController pengujiController = TextEditingController();
  final DosenController dosenController = Get.put(DosenController());
  final RxList<Dosen> filteredDosenList = <Dosen>[].obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Data Sidang'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 16),
            _buildAutocomplete(
              hintText: 'Pembimbing',
              controller: pembimbingController,
            ),
            SizedBox(height: 16),
            _buildAutocomplete(
              hintText: 'Penguji',
              controller: pengujiController,
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: urlProposalController,
              decoration: InputDecoration(
                labelText: 'URL Proposal',
                hintText: 'Masukkan URL Proposal',
                hintStyle: TextStyle(color: Colors.grey), // Warna teks hint
                labelStyle: TextStyle(color: Colors.blue), // Warna teks label
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.blue), // Warna garis border saat fokus
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey), // Warna garis border saat aktif
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.red), // Warna garis border saat error
                ),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: judulController,
              decoration: InputDecoration(
                labelText: 'Judul',
                hintText: 'Masukkan Judul',
                hintStyle: TextStyle(color: Colors.grey),
                labelStyle: TextStyle(color: Colors.blue),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: tahunAkademikController,
              decoration: InputDecoration(
                labelText: 'Tahun Akademik',
                hintText: 'Masukkan Tahun Akademik',
                hintStyle: TextStyle(color: Colors.grey),
                labelStyle: TextStyle(color: Colors.blue),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: jenisSidangController,
              decoration: InputDecoration(
                labelText: 'Jenis Sidang',
                hintText: 'Masukkan Jenis Sidang',
                hintStyle: TextStyle(color: Colors.grey),
                labelStyle: TextStyle(color: Colors.blue),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final sidangController = Get.find<SidangController>();
                String urlProposal = urlProposalController.text;
                String judul = judulController.text;
                String tahunAkademik = tahunAkademikController.text;
                String jenisSidang = jenisSidangController.text;
                String pembimbing = pembimbingController.text;
                String penguji = pengujiController.text;

                try {
                  await sidangController.postSidangData(
                    urlProposal: urlProposal,
                    judul: judul,
                    tahunAkademik: tahunAkademik,
                    jenisSidang: jenisSidang,
                    pembimbing: pembimbing,
                    penguji: penguji,
                  );
                } catch (error) {
                  String errorMessage = error.toString();
                  if (errorMessage.contains("Kuota penguji telah penuh")) {
                    Get.snackbar('Error', 'Kuota penguji telah penuh',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        duration: Duration(seconds: 5));
                  } else {
                    Get.snackbar('Error', errorMessage,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        duration: Duration(seconds: 5));
                  }
                }
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAutocomplete({
    required String hintText,
    required TextEditingController controller,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: hintText,
        border: OutlineInputBorder(),
        hintStyle: TextStyle(color: Colors.grey),
        labelStyle: TextStyle(color: Colors.blue),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
      onTap: () {
        _showAutocomplete(Get.context!, hintText, controller);
      },
    );
  }

  void _showAutocomplete(
      BuildContext context, String hintText, TextEditingController controller) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Cari ${hintText}',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      // Implementasi logika pencarian
                      final String query = value.toLowerCase();
                      if (query.isEmpty) {
                        // Jika nilai pencarian kosong, tampilkan semua dosen
                        filteredDosenList.assignAll(dosenController.dosenList);
                      } else {
                        // Jika ada nilai pencarian, filter dosen berdasarkan nama atau NIDN
                        filteredDosenList.assignAll(dosenController.dosenList
                            .where((dosen) =>
                                dosen.namaLengkap!
                                    .toLowerCase()
                                    .contains(query) ||
                                dosen.nidn!.contains(query)));
                      }
                    },
                  ),
                  SizedBox(height: 16),
                  Obx(() {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredDosenList.length,
                      itemBuilder: (context, index) {
                        final dosen = filteredDosenList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: ListTile(
                              title:
                                  Text('${dosen.nidn} - ${dosen.namaLengkap}'),
                              onTap: () {
                                controller.text = '${dosen.nidn}';
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
