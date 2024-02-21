import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidang_apps/controllers/SABottomController.dart';
import 'package:sidang_apps/controllers/SATokenController.dart';
import 'package:sidang_apps/model/SALogin.dart';
// import 'package:sidang_apps/screens/pages/mahasiswa/SAMahasiswaScreen.dart';
// import 'package:sidang_apps/screens/pages/SADosenScreen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  var role = 'Mahasiswa'.obs;

  void setUsername(String value) {
    username.value = value;
  }

  void setPassword(String value) {
    password.value = value;
  }

  void setRole(String value) {
    role.value = value;
  }

  Future<void> login() async {
    final LoginRequest request = LoginRequest(
      username: username.value,
      password: password.value,
      role: role.value,
    );
    try {
      final response = await _postLogin(request);
      final loginResponse = LoginResponse.fromJson(response);
      if (loginResponse.token.isNotEmpty) {
        await TokenController.instance.setToken(loginResponse.token);
      } else {
        throw Exception('Token not found in login response');
      }
      await saveToken(loginResponse.token);
      _navigateToScreen(loginResponse.role);
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  Future<Map<String, dynamic>> _postLogin(LoginRequest request) async {
    final response =
        await Dio().post(dotenv.env['API_LOGIN_URL']!, data: request.toJson());
    return response.data;
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  void _navigateToScreen(String role) {
    if (role.toLowerCase() == 'dosen') {
      Get.offAll(BottomNavController().getMainScreen());
    } else if (role.toLowerCase() == 'mahasiswa') {
      Get.offAll(BottomNavController().getMainScreen());
    } else {
      Get.snackbar('Error', 'Role tidak valid',
          snackPosition: SnackPosition.TOP);
    }
  }

  void _handleError(dynamic e) {
    // ignore: deprecated_member_use
    if (e is DioException) {
      if (e.response != null && e.response!.data != null) {
        Get.snackbar('Error', 'Maaf Username Atau Password Salah',
            snackPosition: SnackPosition.TOP);
      } else {
        Get.snackbar('Error', 'Gagal melakukan permintaan',
            snackPosition: SnackPosition.TOP);
      }
    } else {
      Get.snackbar('Error', 'Terjadi kesalahan: $e',
          snackPosition: SnackPosition.TOP);
    }
  }
}
