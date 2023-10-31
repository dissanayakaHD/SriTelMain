import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sri_tel/models/model.dart';

class AppState extends ChangeNotifier {
  final dio = Dio(
    BaseOptions(
      baseUrl: kIsWeb ? "http://localhost:8080" : "http://10.0.2.2:8080",
    ),
  );

  User? user;

  String? error;

  Future<bool> login(String email, String password) async {
    error = null;
    try {
      var response = await dio.post('/auth/login', data: {"email": email, "password": password});
      user = User.fromJson(response.data);
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      if (e is DioException) {
        error = e.response?.data['message'];
      }
      return false;
    }
  }

  void logout() {
    error = null;
    user = null;
    notifyListeners();
  }

  Future<bool> pwdReset(String email) async {
    error = null;
    try {
      await dio.post('/auth/password-reset', data: {"email": email});
      return true;
    } catch (e) {
      if (e is DioException) {
        error = e.response?.data['message'];
      }
      return false;
    }
  }
}
