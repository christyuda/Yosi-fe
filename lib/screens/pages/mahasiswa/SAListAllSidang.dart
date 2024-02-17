import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sidang_apps/screens/pages/mahasiswa/SADetailSidangScreen.dart';

class AllSidangScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Sidang Mahasiswa"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Tampilkan dialog pencarian
              showSearch(context: context, delegate: SidangSearchDelegate());
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigasi ke detail screen sidang
              Get.to(DetailSidangScreen(
                sidangName: "Nama Sidang ${index + 1}",
              ));
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
                    "Nama Sidang ${index + 1}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text("Tanggal: 01/01/2024"),
                  SizedBox(height: 5),
                  Text("Waktu: 08:00 - 10:00"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SidangSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions for app bar
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
    final List<String> sidangList = [
      'Sidang 1',
      'Sidang 2',
      'Sidang 3',
      'Sidang 4',
      'Sidang 5',
      'Sidang 6',
      'Sidang 7',
      'Sidang 8',
      'Sidang 9',
      'Sidang 10',
    ];

    final List<String> filteredSidangList =
        sidangList.where((sidang) => sidang.contains(query)).toList();

    if (filteredSidangList.isEmpty) {
      return Center(
        child: Text('Tidak ada hasil yang cocok'),
      );
    }

    return ListView.builder(
      itemCount: filteredSidangList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(filteredSidangList[index]),
          onTap: () {
            final selectedSidang = filteredSidangList[index];
            Get.to(
              DetailSidangScreen(sidangName: selectedSidang),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show suggestions while typing in the search bar
    final List<String> suggestions = [
      'Sidang 1',
      'Sidang 2',
      'Sidang 3',
    ];

    final List<String> filteredSuggestions = query.isEmpty
        ? suggestions
        : suggestions
            .where((suggestion) => suggestion.contains(query))
            .toList();

    return ListView.builder(
      itemCount: filteredSuggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(filteredSuggestions[index]),
          onTap: () {
            query = filteredSuggestions[index];
            showResults(context);
          },
        );
      },
    );
  }
}
