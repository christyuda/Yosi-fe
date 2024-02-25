import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sidang_apps/model/SASidangData.dart';
import 'package:sidang_apps/controllers/SATokenController.dart';

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
}
