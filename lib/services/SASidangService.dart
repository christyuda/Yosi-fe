import 'package:dio/dio.dart';
import 'package:sidang_apps/model/SASidangData.dart';
import 'package:sidang_apps/controllers/SATokenController.dart';

class SidangService {
  final Dio _dio = Dio();

  Future<List<SidangData>> fetchSidangData() async {
    try {
      // Ambil token dari TokenController
      String? token = TokenController.instance.token.value;

      // Periksa apakah token tidak null dan tidak kosong
      if (token != null && token.isNotEmpty) {
        // Tambahkan token ke dalam header permintaan
        Options options = Options(headers: {'login': token});

        final response = await _dio.get(
          'http://10.0.2.2:3000/mahasiswa/sidang',
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
}
