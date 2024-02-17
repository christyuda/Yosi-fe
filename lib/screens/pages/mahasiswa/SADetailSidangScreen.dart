import 'package:flutter/material.dart';

class DetailSidangScreen extends StatelessWidget {
  final String sidangName;

  DetailSidangScreen({required this.sidangName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Sidang"),
      ),
      body: Center(
        child: Text("Detail Sidang: $sidangName"),
      ),
    );
  }
}
