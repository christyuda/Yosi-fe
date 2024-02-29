import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sidang_apps/model/SASidangData.dart';
import 'package:sidang_apps/controllers/SATokenController.dart';
import 'package:sidang_apps/screens/pages/mahasiswa/SAListAllSidang.dart';

class SidangService {
  final Dio _dio = Dio();

  Future<List<SidangData>> fetchSidangData() async {
    try {
      String? token = TokenController.instance.token.value;

      if (token.isNotEmpty) {
        Options options = Options(headers: {'login': token});

        final response = await _dio.get(
          dotenv.env['API_SIDANG']!,
          options: options,
        );
        if (response.statusCode == 200) {
          Iterable list = response.data['data'];
          return list.map((model) => SidangData.fromJson(model)).toList();
        } else {
          throw Exception('Failed to load sidang data');
        }
      } else {
        throw Exception('Token is null or empty');
      }
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
      String? token = TokenController.instance.token.value;

      if (token == null || token.isEmpty) {
        throw Exception('Token is null or empty');
      }

      Options options = Options(headers: {'login': token});

      final response = await _dio.post(
        dotenv.env['API_POST_SIDANG']!,
        options: options,
        data: {
          'url_proposal': urlProposal,
          'judul': judul,
          'tahun_akademik': tahunAkademik,
          'jenis_sidang': jenisSidang,
          'pembimbing': pembimbing,
          'penguji': penguji,
        },
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', response.data['message'],
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: Duration(seconds: 5));
        Get.offAll(() => AllSidangScreen());
      } else if (response.statusCode == 401) {
        throw DioException(
            response: response, requestOptions: response.requestOptions);
      } else {
        throw Exception(
            'Failed to post sidang data. Status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 400) {
        Get.snackbar('Error', e.response!.data['error'],
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: Duration(seconds: 5));
        throw Exception(e.response!.data['error']);
      } else {
        throw Exception('Failed to post sidang data: ${e.toString()}');
      }
    } catch (e) {
      String errorMessage = e.toString();

      throw Exception('Failed to post sidang data: $errorMessage');
    }
  }
}
