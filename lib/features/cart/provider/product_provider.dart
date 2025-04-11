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

  List<Cart> _cart = [];
  List<Cart> get cart => _cart;

  // Fetch products
  Future<void> fetchProducts() async {
    _isLoading = true;
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
  Future<void> viewCart() async {
    _isLoading = true;
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

        // Update the product in the list to mark it as already in cart
        final index = _products.indexWhere((p) => p.id == productId);
        if (index != -1) {
          _products[index].alreadyInCart = true;
        }

        notifyListeners();
      } else {
        log("Add to cart failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      log("Error adding to cart: $e");
    }
  }

  // Remove from cart
  Future<void> removeCartItem({required String productId}) async {
    try {
      Response response = await ProductServices().removeCartItem(
        productId: productId,
      );

      if (response.statusCode == 200) {
        log("Item removed successfully: ${response.data}");
        await viewCart();
        await fetchProducts();
      } else {
        log("Failed to remove item: ${response.statusCode}");
      }
    } catch (e) {
      log("Error removing item from cart: $e");
    }
  }
}
