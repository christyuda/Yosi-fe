import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sidang_apps/model/SAAllDosen.dart';
import 'package:sidang_apps/services/SAGetAlldosenService.dart';

class DosenController extends GetxController {
  final DosenService _dosenService = Get.find<DosenService>();
  final RxList<Dosen> dosenList = <Dosen>[].obs;

  @override
  void onInit() {
    fetchDosenList();

    super.onInit();
  }

  Future<void> fetchDosenList() async {
    try {
      final List<Dosen> result = await _dosenService.getAllDosen();
      dosenList.value = result;
    } catch (e) {
      print('Error fetching dosen list: $e');
    }
  }
}
