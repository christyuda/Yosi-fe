import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidang_apps/controllers/SATokenController.dart';
import 'package:sidang_apps/services/SASidangService.dart';

class SidangController extends GetxController {
  var sidangDataList = [].obs;
  var isLoading = true.obs;
  SidangService _sidangService = SidangService();

  @override
  void onInit() {
    getTokenAndFetchSidangData();
    super.onInit();
  }

  Future<void> getTokenAndFetchSidangData() async {
    try {
      isLoading(true);
      String token = TokenController.instance.token.value;
      print('Token: $token');

      if (token.isNotEmpty) {
        print('Token: $token');

        await fetchSidangData(token);
      } else {
        throw Exception('Token not found or empty');
      }
    } catch (e) {
      print('Failed to load sidang data: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchSidangData(String token) async {
    try {
      var sidangData = await _sidangService.fetchSidangData();
      sidangDataList.assignAll(sidangData);
    } catch (e) {
      throw Exception('Failed to load sidang data: $e');
    }
  }
}
