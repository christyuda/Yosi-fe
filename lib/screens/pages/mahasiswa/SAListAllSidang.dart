import 'package:flutter/material.dart';
import 'package:flutter_scrolling_fab_animated/flutter_scrolling_fab_animated.dart';
import 'package:get/get.dart';
import 'package:sidang_apps/controllers/SASidangController.dart';
import 'package:sidang_apps/model/SASidangData.dart';
import 'package:sidang_apps/screens/components/ConvertSidang.dart';
import 'package:sidang_apps/screens/pages/mahasiswa/SADetailSidangScreen.dart';
import 'package:sidang_apps/screens/pages/mahasiswa/SATambahSidangScreen.dart';

class AllSidangScreen extends StatelessWidget {
  final SidangController sidangController = Get.put(SidangController());

  @override
  Widget build(BuildContext context) {
    final SidangData? sidangData = Get.arguments as SidangData?;
    final List<SidangData> sidangList = sidangController.sidangDataList
        .map((data) => data as SidangData)
        .toList();
    ScrollController _scrollController = ScrollController();

    return Scaffold(
        appBar: AppBar(
          title: Text("List Sidang Mahasiswa"),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: SidangSearchDelegate(sidangList));
              },
            ),
          ],
        ),
        body: Obx(
          () {
            if (sidangController.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: sidangController.sidangDataList.length,
                itemBuilder: (context, index) {
                  final sidangData = sidangController.sidangDataList[index];
                  String jenisSidang = '';

                  if (sidangData != null) {
                    jenisSidang = sidangData.jenisSidang;

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
                  }
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => DetailSidangScreen(), arguments: sidangData);
                    },
                    child: Container(
                      margin: EdgeInsets.all(15),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nama Sidang : ${jenisSidang}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text("Tanggal Sidang: ${sidangData.tglSidang}" ??
                              "Belum Ditentukan"),
                          SizedBox(height: 5),
                          Text("Status: ${sidangData.status}"),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
        floatingActionButton: ScrollingFabAnimated(
          icon: Icon(
            Icons.add,
            color: Colors.blue,
          ),
          text: Text(
            'Tambah Data Sidang',
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
          onPress: () {
            Get.off(() => TambahSidangScreen());
          },
          radius: 10.0,
          animateIcon: true,
          curve: Curves.bounceInOut,
          width: 200.0,
          duration: Duration(milliseconds: 500),
          scrollController: _scrollController,
        ));
  }
}

class SidangSearchDelegate extends SearchDelegate<void> {
  final List<SidangData> sidangList;
  SidangSearchDelegate(this.sidangList);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading icon on the left of the app bar
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<SidangData> filteredSidangList = sidangList
        .where((sidang) =>
            sidang.jenisSidang.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (filteredSidangList.isEmpty) {
      return Center(
        child: Text('Tidak ada hasil yang cocok'),
      );
    }

    return ListView.builder(
        itemCount: filteredSidangList.length,
        itemBuilder: (context, index) {
          final selectedSidang = filteredSidangList[index];
          if (selectedSidang != null) {
            final jenisSidang = convertJenisSidang(selectedSidang.jenisSidang);
            return ListTile(
              title: Text(jenisSidang),
              onTap: () {
                Get.to(() => DetailSidangScreen(), arguments: selectedSidang);
              },
            );
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<SidangData> filteredSuggestions = query.isEmpty
        ? sidangList
        : sidangList
            .where((suggestion) => convertJenisSidang(suggestion.jenisSidang)
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: filteredSuggestions.length,
      itemBuilder: (context, index) {
        final jenisSidang =
            convertJenisSidang(filteredSuggestions[index].jenisSidang);
        return ListTile(
          title: Text(jenisSidang),
          onTap: () {
            query = filteredSuggestions[index].jenisSidang;
            showResults(context);
          },
        );
      },
    );
  }

  void showResults(BuildContext context) {
    FocusScope.of(context).unfocus();

    final List<SidangData> filteredSidangList = sidangList
        .where((sidang) =>
            sidang.jenisSidang.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (filteredSidangList.isEmpty) {
      Get.snackbar(
        'Pencarian',
        'Tidak ada hasil yang cocok',
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 2),
      );
    } else {
      Get.to(() => DetailSidangScreen(), arguments: filteredSidangList.first);
    }
  }
}
