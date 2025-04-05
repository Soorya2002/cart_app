import 'dart:developer';
import 'package:cart_app/core/utils/storage_services.dart';
import 'package:cart_app/core/utils/urls.dart';
import 'package:cart_app/features/authentication/data/models/user_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  ApiService() {
    _dio.options.baseUrl = Urls.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          UserModel? user = await StorageServices().getUserData();
          String? token = user?.token;
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          options.headers['Content-Type'] = 'application/json';
          log('🔹 Request: ${options.method} ${options.path}');
          handler.next(options);
        },
        onResponse: (response, handler) {
          log('✅ Response: ${response.statusCode} - ${response.data}');
          handler.next(response);
        },
        onError: (DioException e, handler) {
          log('❌ Error: ${e.response?.statusCode} - ${e.response?.data}');
          handler.next(e);
        },
      ),
    );
  }

  Future<Response> postRequest(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    return await _dio.post(endpoint, data: data);
  }

  Future<Response> getRequest(String endpoint) async {
    return await _dio.get(endpoint);
  }

  Future<Response> deleteRequest(String endpoint) async {
    return await _dio.delete(endpoint);
  }
}
