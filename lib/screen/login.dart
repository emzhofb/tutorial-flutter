import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatbot/bloc/auth_bloc.dart';
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
  bool isLoading = false;

  void login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isNotEmpty && password.isNotEmpty) {
      setState(() {
        isLoading = true;
      });

      context.read<AuthBloc>().add(LoginRequested(username, password));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("username and password are required!"),
        ),
      );
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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          setState(() {
            isLoading = false;
          });

          SchedulerBinding.instance.addPostFrameCallback((_) {
            if (navigatorKey.currentContext != null) {
              ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
                const SnackBar(content: Text("Login Successful!")),
              );
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
        } else if (state is AuthFailure) {
          setState(() {
            isLoading = false;
          });

          ScaffoldMessenger.of(
            navigatorKey.currentContext!,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: buildLoginUI(context),
    );
  }

  Widget buildLoginUI(BuildContext context) {
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
