import 'package:flutter/material.dart';

class HomeDetail extends StatelessWidget {
  const HomeDetail({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        child: Container(
                          margin: EdgeInsets.only(top: 50, left: 20),
                          child: Text(
                            "Detail Sidang",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 100, left: 20),
                            child: Text(
                              "Nama Mahasiswa",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 5),
                            child: Text(
                              "NIM Mahasiswa",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 200,
              left: 20,
              right: 20,
              child: SingleChildScrollView(
                child: Container(
                  height:
                      900, // You might want to adjust this height based on your content
                  width: 200,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 122, 162, 248),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      // Add your scrollable content here
                      // Example:
                      Container(
                        height: 1000, // Example content height
                        child: Text("Scrollable Content"),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
