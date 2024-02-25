import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sidang_apps/controllers/SAGetAlldosen.dart';
import 'package:sidang_apps/model/SAAllDosen.dart';

class TambahSidangScreen extends StatelessWidget {
  final TextEditingController urlProposalController = TextEditingController();
  final TextEditingController judulController = TextEditingController();
  final TextEditingController tahunAkademikController = TextEditingController();
  final TextEditingController jenisSidangController = TextEditingController();
  final TextEditingController revisiTextController = TextEditingController();
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
              decoration: InputDecoration(labelText: 'URL Proposal'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: judulController,
              decoration: InputDecoration(labelText: 'Judul'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: tahunAkademikController,
              decoration: InputDecoration(labelText: 'Tahun Akademik'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: jenisSidangController,
              decoration: InputDecoration(labelText: 'Jenis Sidang'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: revisiTextController,
              decoration:
                  InputDecoration(labelText: 'Catatan Revisi (jika ada)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement logic to save the data here
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
                                controller.text =
                                    '${dosen.nidn} - ${dosen.namaLengkap}';
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
