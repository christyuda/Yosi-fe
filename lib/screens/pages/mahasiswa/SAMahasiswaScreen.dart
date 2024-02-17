import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:sidang_apps/controllers/SANavigationController.dart';
import 'package:sidang_apps/model/SABanner.dart';
import 'package:sidang_apps/model/SASidangDataModel.dart';
import 'package:sidang_apps/utils/SAConstants.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MahasiswaScreen extends StatelessWidget {
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
            SizedBox(height: 30),
            Expanded(
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                itemCount: gridItems.length,
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                  onTap: () {
                    // Handle item tap here
                    print('Item $index tapped');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                        opacity: 0.5,
                        image: AssetImage(gridItems[index].imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getStatusColor(gridItems[index].title),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                ),
                              ),
                              child: Text(
                                gridItems[index].title,
                                style: kStatusStyle,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                staggeredTileBuilder: (int index) =>
                    StaggeredTile.count(1, index.isEven ? 1.1 : 1.3),
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0,
              ),
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
