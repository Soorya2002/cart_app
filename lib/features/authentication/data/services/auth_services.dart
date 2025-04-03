import 'package:cart_app/core/utils/urls.dart';
import 'package:dio/dio.dart';

class AuthServices {
  final Dio _dio = Dio();

  // Register
  Future<Response> register({
    required String username,
    required String email,
    required String password,
  }) async {
    final Response response = await _dio.post(
      Urls.baseUrl + Urls.register,
      data: {"username": username, "email": email, "password": password},
    );
    return response;
  }

  // Login
  Future<Response> login({
    required String email,
    required String password,
  }) async {
    final Response response = await _dio.post(
      Urls.baseUrl + Urls.login,
      data: {"email": email, "password": password},
    );
    return response;
  }
}
