import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  Future<void> postSidangData({
    required String urlProposal,
    required String judul,
    required String tahunAkademik,
    required String jenisSidang,
    required String pembimbing,
    required String penguji,
  }) async {
    try {
      isLoading(true);
      String token = TokenController.instance.token.value;
      print('Token: $token');

      if (token.isNotEmpty) {
        await _sidangService.postSidangData(
          urlProposal: urlProposal,
          judul: judul,
          tahunAkademik: tahunAkademik,
          jenisSidang: jenisSidang,
          pembimbing: pembimbing,
          penguji: penguji,
        );
        await fetchSidangData(token);
      } else {
        throw Exception('Token not found or empty');
      }
    } catch (e) {
      print('Failed to post sidang data: $e');
      String errorMessage = e.toString();
      if (errorMessage.contains("Kuota penguji telah penuh")) {
        Get.snackbar('Error', 'Kuota penguji telah penuh',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: Duration(seconds: 5));
      } else {
        Get.snackbar('Error', errorMessage,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: Duration(seconds: 5));
      }
    } finally {
      isLoading(false);
    }
  }
}
