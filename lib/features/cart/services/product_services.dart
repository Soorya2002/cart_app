import 'package:cart_app/core/services/api_services.dart';
import 'package:cart_app/core/utils/urls.dart';
import 'package:dio/dio.dart';

class ProductServices {
  // final Dio _dio = Dio();

  // Fetch products
  Future<Response> getProducts() async {
    try {
      final Response response = await ApiService().getRequest(Urls.home);
      return response;
    } catch (e) {
      throw Exception('failed to fetch counters: $e');
    }
  }
}
