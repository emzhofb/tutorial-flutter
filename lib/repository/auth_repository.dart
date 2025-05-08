import 'package:dio/dio.dart';
import 'package:flutter_chatbot/bloc/auth_bloc.dart';
import 'package:flutter_chatbot/config/app_config.dart';
import 'package:flutter_chatbot/model/auth_model.dart';

class AuthRepository {
  final Dio _dio = Dio();

  Future<LoginResponse> login(String username, String password) async {
    final response = await _dio.post(
      "${AppConfig.apiUrl}/api/v1/login",
      data: {'username': username, 'password': password},
      options: Options(
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(response.data);
    } else if (response.statusCode == 401) {
      throw AuthFailure('Invalid username and password!');
    } else {
      throw AuthFailure('Login failed with status: ${response.statusCode}');
    }
  }
}
