import 'dart:convert';
import 'package:project_bloc/core/services/api/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  late SharedPreferences preferences;

  PrefHelper._internal(this.preferences);

  factory PrefHelper(SharedPreferences preferences) {
    return PrefHelper._internal(preferences);
  }

  Future<SharedPreferences> get _initializePrefs async {
    return preferences;
  }

  /// Clears all preferences.
  Future<void> removePreference() async {
    var pref = await _initializePrefs;
    pref.clear();
  }

  /// Logs out the user by clearing preferences and resetting base URL.
  Future<void> logOutPref() async {
    var pref = await _initializePrefs;
    String tempAPI = pref.getString(_kBaseUrl) ?? APIConstants.defaultAPI;
    await removePreference();
    await setBaseUrl(tempAPI);
  }

  /// Dark theme preference.
  final String _kIsDarkTheme = "ShowDarkTheme";
  Future<void> setIsDarkTheme(bool value) async {
    var pref = await _initializePrefs;
    pref.setBool(_kIsDarkTheme, value);
  }

  Future<bool> getIsDarkTheme() async {
    var pref = await _initializePrefs;
    return pref.getBool(_kIsDarkTheme) ?? false;
  }

  /// Base URL preference.
  final String _kBaseUrl = "BaseURLAPI";
  Future<void> setBaseUrl(String value) async {
    var pref = await _initializePrefs;
    pref.setString(_kBaseUrl, value);
  }

  Future<String> getBaseUrl() async {
    return 'http://192.168.1.67:3000/';
  }

  /// Login status preference.
  final String _kIsLogin = "IsLogin";
  Future<void> setIsLogin(bool value) async {
    var pref = await _initializePrefs;
    pref.setBool(_kIsLogin, value);
  }

  Future<bool> getIsLogin() async {
    var pref = await _initializePrefs;
    return pref.getBool(_kIsLogin) ?? false;
  }

  /// User code preference.
  final String _kUserCode = "UserCode";
  Future<void> setUserName(String value) async {
    var pref = await _initializePrefs;
    pref.setString(_kUserCode, value);
  }

  Future<String> getUserName() async {
    var pref = await _initializePrefs;
    return pref.getString(_kUserCode) ?? "";
  }

  /// Login data preference.
  // final String _kLoginData = "LoginData";
  // Future<void> setLoginData(CompanyModel value) async {
  //   var pref = await _initializePrefs;
  //   pref.setString(
  //     _kLoginData,
  //     jsonEncode(value.toJson()),
  //   );
  // }

  // Future<CompanyModel> getLoginData() async {
  //   // var pref = await _initializePrefs;
  //   // // final jsonString = pref.getString(_kLoginData);
  //   // // final jsonMap =
  //   // //     jsonString != null ? jsonDecode(jsonString) : CompanyModel.fromJson({});
  //   // // return CompanyModel.fromJson(jsonMap);
  //   // String value = pref.getString(_kLoginData) ?? "";
  //   // if (value != "-") {
  //   //   Map<String, dynamic> userAuthData = jsonDecode(value);
  //   //   return CompanyModel.fromJson(userAuthData);
  //   // } else {
  //   //   return CompanyModel.fromJson({});
  //   // }
  // }

  // Future<CompanyModel> getLoginData() async {
  //   var pref = await _initializePrefs;
  //   final jsonString = pref.getString(_kLoginData);
  //   final jsonMap =
  //       jsonString != null ? jsonDecode(jsonString) : <String, dynamic>{};
  //   return CompanyModel.fromJson(jsonMap.cast<String, dynamic>());
  // }



}
