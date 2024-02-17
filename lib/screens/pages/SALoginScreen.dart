import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sidang_apps/controllers/SALoginController.dart';

class LoginScreen extends StatelessWidget {
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(
            //   'assets/images/login_logo.png', // Ubah sesuai dengan lokasi logo Anda
            //   width: 150,
            //   height: 150,
            //   fit: BoxFit.contain,
            // ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) => _loginController.setUsername(value),
              decoration: InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) => _loginController.setPassword(value),
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Obx(() => DropdownButtonFormField<String>(
                  value: _loginController.role.value.toLowerCase(),
                  onChanged: (value) =>
                      _loginController.setRole(value!.toLowerCase()),
                  items: <String>['Mahasiswa', 'Dosen'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value.toLowerCase(),
                      child: Text(value.toLowerCase()),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Role',
                    border: OutlineInputBorder(),
                  ),
                )),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                _loginController.login();
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text(
                'Login',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
