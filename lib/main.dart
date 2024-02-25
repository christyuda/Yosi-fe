import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sidang_apps/controllers/SANavigationController.dart';
import 'package:sidang_apps/controllers/SATokenController.dart';
import 'package:sidang_apps/screens/pages/SALoginScreen.dart';
import 'package:sidang_apps/services/SAGetAlldosenService.dart';

void main() async {
  await dotenv.load();
  Get.put(TokenController());
  Get.put(DosenService());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course App',
      theme: ThemeData(),
      home: LoginScreen(),
      initialBinding: BindingsBuilder(() {
        Get.put(NavigationController());
      }),
    );
  }
}
