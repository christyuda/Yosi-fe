import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenController extends GetxController {
  static TokenController get instance => Get.find<TokenController>();

  var token = ''.obs;

  @override
  void onInit() {
    saveToken(token.value);
    super.onInit();
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> setToken(String newToken) async {
    token.value = newToken;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', newToken);
  }

  Future<void> removeToken() async {
    token.value = '';
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
