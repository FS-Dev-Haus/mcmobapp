import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:device_info/device_info.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('https://mcinvalpha.herokuapp.com/api/login'),
      body: {
        'email': email,
        'password': password,
        'device_name': await getDeviceId()
      },
      headers: {
        'Accept': 'application/json'
      }
    );

    if (response.statusCode == 201) {
      String token = json.decode(response.body)['token'];
      await saveToken(token);
      _isAuthenticated = true;
      notifyListeners();
      return true;
    }

    if (response.statusCode == 422) {
      print("422");
      return false;
    }
    print("Others");
    print(response.statusCode);
    print(response.body);
    return false;
  }

  Future<bool> register(String name, String email, String password, String confirmPassword) async {
    print('masuk register');
    final response = await http.post(
      Uri.parse('https://mcinvalpha.herokuapp.com/api/register'),
      body: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': password,
        'device_name': await getDeviceId()
      },
      headers: {
        'Accept': 'application/json'
      }
    );

    if (response.statusCode == 201) {
      String token = json.decode(response.body)['token'];
      await saveToken(token);
      _isAuthenticated = true;
      notifyListeners();
      return true;
    }

    if (response.statusCode == 422) {
      print("422");
      print(response.body);
      return false;
    }
    print("Others");
    print(response.statusCode);
    print(response.body);
    return false;
  }

  getDeviceId() async {
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        return build.androidId;
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        return data.identifierForVendor;
      }
    } on PlatformException {
      print('Failed to get Platform Version');
    }
  }

  saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  checkToken() async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.containsKey('token'));
    if (prefs.containsKey('token')) {
      _isAuthenticated = true;
    }
  }

  logout() async {
    String token = await getToken();
    print(await getToken());
    final response = await http.post(
      Uri.parse('https://mcinvalpha.herokuapp.com/api/logout'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }
    );

    print(response);
    print(response.body);

    if (response.statusCode == 200) {
      _isAuthenticated = false;
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      notifyListeners();
    }
  }
}