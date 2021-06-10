import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../models/user.dart';
import 'dio.dart';
import 'package:dio/dio.dart' as Dio;

class Auth extends ChangeNotifier {
  bool _isLoggedIn = false;
  late User _user;
  late String _token;

  bool get authenticated => _isLoggedIn;

  User get user => _user;

  final storage = new FlutterSecureStorage();

  Future<void> login({required Map credentials}) async {
    print(credentials);
    try {
      Dio.Response response =
          await dio().post('/sanctum/token', data: credentials);
      String token = response.data.toString();
      tryToken(token: token);
    } catch (e) {
      print(e);
    }
  }

  Future<void> tryToken({required String token}) async {
    try {
      Dio.Response response = await dio().get('/user',
          options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
      this._isLoggedIn = true;
      this._user = User.fromJson(response.data);
      this._token = token;
      this.storeToken(token: token);
      notifyListeners();
      print(_user);
    } catch (e) {
      print(e);
    }
  }

  void storeToken({required String token}) {
    this.storage.write(key: 'token', value: token);
  }

  Future<void> logout() async {
    try {
      Dio.Response response = await dio().get('/user/revoke',
          options: Dio.Options(headers: {'Authorization': 'Bearer $_token'}));
      deleteToken();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void deleteToken() async {
    this._isLoggedIn = false;
    await storage.delete(key: 'token');
  }
}
