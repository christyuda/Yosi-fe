import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sidang_apps/controllers/SANavigationController.dart';
import 'package:sidang_apps/controllers/SASidangController.dart';
import 'package:sidang_apps/model/SABanner.dart';
import 'package:sidang_apps/model/SASidangData.dart';
import 'package:sidang_apps/model/SASidangDataModel.dart';
import 'package:sidang_apps/utils/SAConstants.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MahasiswaScreen extends StatelessWidget {
  final SidangController sidangController = Get.put(SidangController());

  final List<GridItem> gridItems = [
    GridItem(title: 'Approved', imagePath: 'assets/images/music.png'),
    GridItem(title: 'Completed', imagePath: 'assets/images/music.png'),
    GridItem(title: 'Not Approved', imagePath: 'assets/images/music.png'),
    GridItem(title: 'Pending', imagePath: 'assets/images/music.png'),
  ];

  final List<BannerItem> bannerItems = [
    BannerItem(imagePath: 'assets/images/sidangbanner.png'),
    BannerItem(imagePath: 'assets/images/sidangbanner2.png'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20, top: 50, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SvgPicture.asset("assets/icons/menu.svg"),
                Image.asset("assets/images/user.png"),
              ],
            ),
            SizedBox(height: 30),
            Text("Hey Username,", style: kHeadingextStyle),
            Text("Temukan Kebutuhan Sidang Kamu", style: kSubheadingext2Style),
            CarouselSlider(
              options: CarouselOptions(
                height: 180,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 10),
                autoPlayAnimationDuration: Duration(milliseconds: 2000),
                pauseAutoPlayOnTouch: true,
                viewportFraction: 1,
              ),
              items: bannerItems.map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.asset(
                            item.imagePath,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Category", style: kTitleTextStyle),
                TextButton(
                  onPressed: () {
                    // Menggunakan controller navigasi
                    Get.find<NavigationController>().goToAllSidangScreen();
                  },
                  child: Text(
                    "See All",
                    style: kSubtitleTextSyule.copyWith(color: kBlueColor),
                  ),
                ),
              ],
            ),
            SizedBox(height: 18),
            Expanded(
              child: Obx(() {
                if (sidangController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    itemCount: sidangController.sidangDataList.length,
                    itemBuilder: (BuildContext context, int index) =>
                        GestureDetector(
                      onTap: () {
                        final sidangData =
                            sidangController.sidangDataList[index];
                        Get.find<NavigationController>()
                            .goToDetailScreen(sidangData);
                        print('Item $index tapped');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 3,
                          ),

                          gradient: Gradient.lerp(
                            LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFFF9F07A).withOpacity(0.2),
                                Colors.white,
                                Color(0xFF645CBB).withOpacity(0.1),
                                Color(0xFFA084DC).withOpacity(1),
                              ],
                            ),
                            LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFFBFACE2).withOpacity(0.9),
                                Colors.white,
                                Color(0xFFBFACE2).withOpacity(1),
                              ],
                            ),
                            0.5,
                          ),
                          // image: DecorationImage(
                          //   opacity: 0.5,
                          //   image: AssetImage(gridItems[index].imagePath),
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 2),
                                  margin: EdgeInsets.only(top: 5, right: 2),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(sidangController
                                        .sidangDataList[index].status),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: Text(
                                    sidangController
                                        .sidangDataList[index].status,
                                    style: kStatusStyle,
                                  ),
                                ),
                              ],
                            ),
                            index.isEven
                                ? _buildSidangIcon(
                                    sidangController.sidangDataList[index],
                                    true,
                                  )
                                : _buildSidangIcon2(
                                    sidangController.sidangDataList[index],
                                  ),
                          ],
                        ),
                      ),
                    ),
                    staggeredTileBuilder: (int index) =>
                        StaggeredTile.count(1, index.isEven ? 1.1 : 1.3),
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: 20.0,
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

Color _getStatusColor(String status) {
  switch (status) {
    case 'Approved':
      return Color.fromARGB(255, 53, 252, 70); // Green
    case 'Completed':
      return Colors.blue;
    case 'Pending':
      return Colors.yellow;
    case 'Not Approved':
      return Colors.red;
    default:
      return Colors.grey;
  }
}

Widget _buildSidangIcon(SidangData sidangData, bool isEven) {
  if (isEven) {
    switch (sidangData.jenisSidang) {
      case 'p1':
        return Container(
          margin: EdgeInsets.only(top: 8),
          padding: EdgeInsets.only(top: 25, bottom: 25, left: 45, right: 45),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4B527E),
                blurRadius: 2.0,
                offset: Offset.fromDirection(1, 5),
                blurStyle: BlurStyle.outer,
              ),
            ],
            color: const Color(0xFF7091F5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text('P1 ',
                  style: GoogleFonts.poppins(
                      shadows: [
                        Shadow(
                          blurRadius: 20.0,
                          color: const Color.fromARGB(255, 95, 94, 94),
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              Text('Proyek 1 ',
                  style: GoogleFonts.poppins(
                      shadows: [
                        Shadow(
                          blurRadius: 20.0,
                          color: const Color.fromARGB(255, 95, 94, 94),
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ],
          ),
        );
      case 'p2':
        return Container(
          margin: EdgeInsets.only(top: 8),
          padding: EdgeInsets.only(top: 25, bottom: 25, left: 45, right: 45),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4B527E),
                blurRadius: 2.0,
                offset: Offset.fromDirection(1, 5),
                blurStyle: BlurStyle.outer,
              ),
            ],
            color: const Color(0xFF7752FE),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text('P2 ',
                  style: GoogleFonts.poppins(
                      shadows: [
                        Shadow(
                          blurRadius: 20.0,
                          color: const Color.fromARGB(255, 95, 94, 94),
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              Text('Proyek 2 ',
                  style: GoogleFonts.poppins(
                      shadows: [
                        Shadow(
                          blurRadius: 20.0,
                          color: const Color.fromARGB(255, 95, 94, 94),
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ],
          ),
        );
      case 'p3':
        return Container(
          margin: EdgeInsets.only(top: 8),
          padding: EdgeInsets.only(top: 25, bottom: 25, left: 45, right: 45),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4B527E),
                blurRadius: 2.0,
                offset: Offset.fromDirection(1, 5),
                blurStyle: BlurStyle.outer,
              ),
            ],
            color: const Color(0xFF4B527E),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text('P3 ',
                  style: GoogleFonts.poppins(
                      shadows: [
                        Shadow(
                          blurRadius: 20.0,
                          color: const Color.fromARGB(255, 95, 94, 94),
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              Text('Proyek 3 ',
                  style: GoogleFonts.poppins(
                      shadows: [
                        Shadow(
                          blurRadius: 20.0,
                          color: const Color.fromARGB(255, 95, 94, 94),
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ],
          ),
        );
      default:
        return Container();
    }
  } else {
    switch (sidangData.jenisSidang) {
      case 'i1':
        return Container(
          margin: EdgeInsets.only(top: 8),
          padding: EdgeInsets.only(top: 25, bottom: 25, left: 35, right: 35),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4B527E),
                blurRadius: 2.0,
                offset: Offset.fromDirection(1, 5),
                blurStyle: BlurStyle.outer,
              ),
            ],
            color: const Color(0xFF12486B),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text('I1 ',
                  style: GoogleFonts.poppins(
                      shadows: [
                        Shadow(
                          blurRadius: 20.0,
                          color: const Color.fromARGB(255, 95, 94, 94),
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              Text('Internship 1 ',
                  style: GoogleFonts.poppins(
                      shadows: [
                        Shadow(
                          blurRadius: 20.0,
                          color: const Color.fromARGB(255, 95, 94, 94),
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ],
          ),
        );
      case 'i2':
        return Container(
          margin: EdgeInsets.only(top: 8),
          padding: EdgeInsets.only(top: 25, bottom: 25, left: 35, right: 35),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4B527E),
                blurRadius: 2.0,
                offset: Offset.fromDirection(1, 5),
                blurStyle: BlurStyle.outer,
              ),
            ],
            color: const Color(0xFF12486B),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text('I2 ',
                  style: GoogleFonts.poppins(
                      shadows: [
                        Shadow(
                          blurRadius: 20.0,
                          color: const Color.fromARGB(255, 95, 94, 94),
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              Text('Internship 2 ',
                  style: GoogleFonts.poppins(
                      shadows: [
                        Shadow(
                          blurRadius: 20.0,
                          color: const Color.fromARGB(255, 95, 94, 94),
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ],
          ),
        );
      case 'ta':
        return Container(
          margin: EdgeInsets.only(top: 8),
          padding: EdgeInsets.only(top: 25, bottom: 25, left: 35, right: 35),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4B527E),
                blurRadius: 2.0,
                offset: Offset.fromDirection(1, 5),
                blurStyle: BlurStyle.outer,
              ),
            ],
            color: const Color(0xFF6499E9),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text('TA ',
                  style: GoogleFonts.poppins(
                      shadows: [
                        Shadow(
                          blurRadius: 20.0,
                          color: const Color.fromARGB(255, 95, 94, 94),
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              Text('Tugas Akhir ',
                  style: GoogleFonts.poppins(
                      shadows: [
                        Shadow(
                          blurRadius: 20.0,
                          color: const Color.fromARGB(255, 95, 94, 94),
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ],
          ),
        );
      default:
        return Container();
    }
  }
}

Widget _buildSidangIcon2(SidangData sidangData) {
  switch (sidangData.jenisSidang) {
    case 'p1':
      return Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(top: 35, bottom: 45, left: 45, right: 45),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF7091F5),
              blurRadius: 2.0,
              offset: Offset.fromDirection(1, 5),
              blurStyle: BlurStyle.outer,
            ),
          ],
          color: const Color(0xFF7091F5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text('P1 ',
                style: GoogleFonts.poppins(
                    shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: const Color.fromARGB(255, 95, 94, 94),
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Text('Proyek 1 ',
                style: GoogleFonts.poppins(
                    shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: const Color.fromARGB(255, 95, 94, 94),
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ],
        ),
      );
    case 'p2':
      return Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(top: 35, bottom: 45, left: 45, right: 45),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4B527E),
              blurRadius: 2.0,
              offset: Offset.fromDirection(1, 5),
              blurStyle: BlurStyle.outer,
            ),
          ],
          color: const Color(0xFF4B527E),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text('P2 ',
                style: GoogleFonts.poppins(
                    shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: const Color.fromARGB(255, 95, 94, 94),
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Text('Proyek 2 ',
                style: GoogleFonts.poppins(
                    shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: const Color.fromARGB(255, 95, 94, 94),
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ],
        ),
      );
    case 'p3':
      return Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(top: 35, bottom: 45, left: 45, right: 45),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF7752FE),
              blurRadius: 2.0,
              offset: Offset.fromDirection(1, 5),
              blurStyle: BlurStyle.outer,
            ),
          ],
          color: const Color(0xFF7752FE),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text('P3 ',
                style: GoogleFonts.poppins(
                    shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: const Color.fromARGB(255, 95, 94, 94),
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Text('Proyek 3 ',
                style: GoogleFonts.poppins(
                    shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: const Color.fromARGB(255, 95, 94, 94),
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ],
        ),
      );
    case 'i1':
      return Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(top: 35, bottom: 45, left: 35, right: 35),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 95, 94, 94),
              blurRadius: 2.0,
              offset: Offset.fromDirection(1, 5),
              blurStyle: BlurStyle.outer,
            ),
          ],
          color: const Color(0xFF419197),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text('I1 ',
                style: GoogleFonts.poppins(
                    shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: const Color.fromARGB(255, 95, 94, 94),
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Text('Internship 1 ',
                style: GoogleFonts.poppins(
                    shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: const Color.fromARGB(255, 95, 94, 94),
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ],
        ),
      );
    case 'i2':
      return Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(top: 35, bottom: 45, left: 35, right: 35),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 95, 94, 94),
              blurRadius: 2.0,
              offset: Offset.fromDirection(1, 5),
              blurStyle: BlurStyle.outer,
            ),
          ],
          color: const Color(0xFF12486B),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text('I2 ',
                style: GoogleFonts.poppins(
                    shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: const Color.fromARGB(255, 95, 94, 94),
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Text('Internship 2 ',
                style: GoogleFonts.poppins(
                    shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: const Color.fromARGB(255, 95, 94, 94),
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ],
        ),
      );
    case 'ta':
      return Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(top: 35, bottom: 45, left: 35, right: 35),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 95, 94, 94),
              blurRadius: 2.0,
              offset: Offset.fromDirection(1, 5),
              blurStyle: BlurStyle.outer,
            ),
          ],
          color: const Color(0xFF6499E9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text('TA ',
                style: GoogleFonts.poppins(
                    shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: const Color.fromARGB(255, 95, 94, 94),
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Text('Tugas Akhir ',
                style: GoogleFonts.poppins(
                    shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: const Color.fromARGB(255, 95, 94, 94),
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ],
        ),
      );
    default:
      return Container();
  }
}

Widget _buildShimmerGrid() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      itemCount: 6, // Jumlah item shimmer yang ingin ditampilkan
      itemBuilder: (BuildContext context, int index) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.grey[300]!,
            width: 3,
          ),
        ),
      ),
      staggeredTileBuilder: (int index) =>
          StaggeredTile.count(1, index.isEven ? 1.1 : 1.3),
      mainAxisSpacing: 20.0,
      crossAxisSpacing: 20.0,
    ),
  );
}
