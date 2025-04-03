import 'dart:developer';
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
}
