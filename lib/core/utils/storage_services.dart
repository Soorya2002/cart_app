import 'dart:convert';
import 'package:cart_app/features/authentication/data/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageServices {
  static const _storage = FlutterSecureStorage();
  static const _userKey = "user_data";

  // save user data
  Future<void> saveUserData({required UserModel user}) async {
    UserModel userData = UserModel(
      message: user.message,
      user: user.user,
      token: user.token,
    );
    await _storage.write(key: _userKey, value: jsonEncode(userData));
  }

  // get user data
  Future<UserModel?> getUserData() async {
    String? userDataString = await _storage.read(key: _userKey);
    if (userDataString != null) {
      return UserModel.fromJson(jsonDecode(userDataString));
    }
    return null;
  }

  // Logout function (Clear user data)
  Future<void> logout() async {
    await _storage.delete(key: _userKey);
  }
}
