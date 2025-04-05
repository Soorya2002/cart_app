import 'dart:developer';
import 'package:cart_app/features/cart/models/cart_model.dart';
import 'package:cart_app/features/cart/models/product_model.dart';
import 'package:cart_app/features/cart/services/product_services.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];
  List<ProductModel> get product => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Fetch counters from API
  Future<void> fetchProducts() async {
    _isLoading = true;
    // notifyListeners();

    try {
      Response response = await ProductServices().getProducts();
      if (response.statusCode == 200) {
        log('Api response: ${response.data.toString()}');
        final List<dynamic> data = response.data as List<dynamic>;
        _products =
            data.map((product) => ProductModel.fromJson(product)).toList();
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // View cart

  List<Cart> _cart = [];
  List<Cart> get cart => _cart;

  Future<void> viewCart() async {
    _isLoading = true;
    // notifyListeners();

    try {
      Response response = await ProductServices().viewCart();
      if (response.statusCode == 200) {
        log('Api response: ${response.data.toString()}');
        final Map<String, dynamic> data = response.data as Map<String, dynamic>;
        _cart = [Cart.fromJson(data)];
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add to cart
  Future<void> addCart({required String productId}) async {
    try {
      Response response = await ProductServices().addCart(productId: productId);

      if (response.statusCode == 200) {
        log('Add to cart response: ${response.data}');

        final Map<String, dynamic> data = response.data as Map<String, dynamic>;
        _cart = [Cart.fromJson(data)];

        // Refresh cart to ensure latest state from server
        await viewCart();
      } else {
        log("Add to cart failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      log("Error adding to cart: $e");
    }
  }

  // remove from cart
  Future<void> removeCartItem({required String productId}) async {
    try {
      Response response = await ProductServices().removeCartItem(
        productId: productId,
      );

      if (response.statusCode == 200) {
        log("Item removed successfully: ${response.data}");
        await viewCart();
      } else {
        log("Failed to remove item: ${response.statusCode}");
      }
    } catch (e) {
      log("Error removing item from cart: $e");
    }
  }
}
