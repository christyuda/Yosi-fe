import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:sidang_apps/controllers/SATokenController.dart';
import 'package:sidang_apps/model/SAAllDosen.dart';

class DosenService extends GetxService {
  final Dio _dio = Dio();

  Future<List<Dosen>> getAllDosen() async {
    try {
      String? token = TokenController.instance.token.value;

      if (token.isNotEmpty) {
        Options options = Options(headers: {'login': token});

        final response = await _dio.get(
          dotenv.env['API_GETALLDOSEN']!,
          options: options,
        );
        if (response.statusCode == 200) {
          List<Dosen> dosenList = [];

          for (var dosenData in response.data['data']) {
            if (dosenData.containsKey('nama_lengkap')) {
              Dosen dosen = Dosen(
                nidn: dosenData['nidn'],
                namaLengkap: dosenData['nama_lengkap'].toString(),
              );
              dosenList.add(dosen);
            } else {
              Dosen dosen = Dosen(
                nidn: dosenData['nidn'],
                namaLengkap: 'Nama Lengkap Tidak Tersedia',
              );
              dosenList.add(dosen);
            }
          }

          return dosenList;
        } else {
          throw Exception('Failed to load dosen data');
        }
      } else {
        throw Exception('Token is null or empty');
      }
    } catch (e) {
      throw Exception('Failed to load dosen data: $e');
    }
  }
}
