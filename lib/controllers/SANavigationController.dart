import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sidang_apps/screens/pages/mahasiswa/SAListAllSidang.dart';

class NavigationController extends GetxController {
  // Navigasi ke halaman AllSidangScreen
  void goToAllSidangScreen() {
    Get.to(AllSidangScreen());
  }
}
