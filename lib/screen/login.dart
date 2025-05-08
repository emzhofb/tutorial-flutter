import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_chatbot/config/app_config.dart';
import 'package:flutter_chatbot/main.dart';
import 'package:flutter_chatbot/screen/homepage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Dio _dio = Dio();
  bool isLoading = false;

  void login() async {
    setState(() {
      isLoading = true;
    });

    final data = {
      "username": _usernameController.text,
      "password": _passwordController.text,
    };

    try {
      Response response = await _dio.post(
        "${AppConfig.apiUrl}/api/v1/login",
        data: data,
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      if (response.statusCode == 200) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          if (navigatorKey.currentContext != null) {
            ScaffoldMessenger.of(
              navigatorKey.currentContext!,
            ).showSnackBar(const SnackBar(content: Text("Login Successful!")));
          }
        });

        Navigator.push(
          navigatorKey.currentContext!,
          MaterialPageRoute(
            builder: (context) {
              return const HomePageScreen();
            },
          ),
        );
      } else {
        showError(response.data['message'] ?? "Invalid Username or Password");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        showError(e.response?.data['message'] ?? "Login Failed");
      } else {
        showError("Network Error");
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void showError(String message) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (navigatorKey.currentContext != null) {
        ScaffoldMessenger.of(
          navigatorKey.currentContext!,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Page")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: "Username"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 24),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(onPressed: login, child: const Text("Login")),
          ],
        ),
      ),
    );
  }
}
