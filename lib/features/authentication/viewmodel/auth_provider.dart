import 'dart:developer';
import 'package:cart_app/core/utils/storage_services.dart';
import 'package:cart_app/features/authentication/data/models/user_model.dart';
import 'package:cart_app/features/authentication/data/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _user;
  UserModel? get user => _user;

  bool _isloading = false;
  bool get isloading => _isloading;
  // Register
  Future<void> register(
    BuildContext context, {
    required String username,
    required String email,
    required String password,
  }) async {
    _isloading = true;
    notifyListeners();
    try {
      final response = await AuthServices().register(
        username: username,
        email: email,
        password: password,
      );
      if (response.statusCode == 201) {
        _user = UserModel.fromJson(response.data);
        // store user data locally
        await StorageServices().saveUserData(user: _user!);
        log('Registered successfully.');
        // ignore: use_build_context_synchronously
        context.goNamed('home');
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }

  // Login
  Future<void> login(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    _isloading = true;
    notifyListeners();
    try {
      final response = await AuthServices().login(
        email: email,
        password: password,
      );
      if (response.statusCode == 200) {
        log('Logged in successfully.');

        _user = UserModel.fromJson(response.data);

        //store user data locally
        await StorageServices().saveUserData(user: _user!);

        // retrieve stored user data to verify it is saved
        UserModel? storedUser = await StorageServices().getUserData();
        // ignore: use_build_context_synchronously
        context.goNamed('home');

        if (storedUser != null) {
          log(" Stored user data retrieved:");
          log(" Username: ${storedUser.user?.username ?? ""}");
          log(" Email: ${storedUser.user?.email ?? ""}");
          log(" Token: ${storedUser.token}");
        } else {
          log(" No user data found in storage!");
        }
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }
}
