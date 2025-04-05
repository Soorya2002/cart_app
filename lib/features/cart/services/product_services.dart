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

  // View cart
  Future<Response> viewCart() async {
    try {
      final Response response = await ApiService().getRequest(Urls.cart);
      return response;
    } catch (e) {
      throw Exception('failed to fetch counters: $e');
    }
  }

  // Add to cart
  Future<Response> addCart({required String productId}) async {
    try {
      final response = await ApiService().postRequest(Urls.addcart, {
        "productId": productId,
      });
      return response;
    } catch (e) {
      throw Exception("Failed to create counter: $e");
    }
  }

  // remove from cart
  Future<Response> removeCartItem({required String productId}) async {
    try {
      final response = await ApiService().deleteRequest(Urls.remove(productId));
      return response;
    } catch (e) {
      throw Exception("Failed to remove cart item: $e");
    }
  }
}
