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
            TextField(
              onChanged: (value) => _loginController.setUsername(value),
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) => _loginController.setPassword(value),
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Obx(() => DropdownButtonFormField<String>(
                  value: _loginController.role.value,
                  onChanged: (value) => _loginController.setRole(value!),
                  items: <String>['Mahasiswa', 'Dosen'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                _loginController.login();
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
