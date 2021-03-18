import 'dart:convert';

import 'package:apimodule/model/response/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'key.dart';

class Pref {
  static Future<bool> checkIsLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getBool(SharedPrefKey.isLoggedInKey) ?? false);
  }

  static Future<LoginResults> getUserLogin() async {
    final prefs = await SharedPreferences.getInstance();
    var pref = json.decode(prefs.getString(SharedPrefKey.userLogin));
    return LoginResults.fromJson(await pref);
  }

  static setUserLogin(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedPrefKey.userLogin, json.encode(value));
    prefs.setBool(SharedPrefKey.isLoggedInKey, true);
  }

  static setTokenFirebase(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedPrefKey.tokenPushNotif, value);
  }

  static Future<String> getTokenFirebase() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPrefKey.tokenPushNotif);
  }

  static setDeviceId(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedPrefKey.deviceId, value);
  }

  static Future<String> getDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPrefKey.deviceId);
  }

  static Future<bool> remove() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(SharedPrefKey.userLogin);
    prefs.remove(SharedPrefKey.isLoggedInKey);
    return true;
  }
}
