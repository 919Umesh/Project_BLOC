import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static final SecureStorageHelper instance = SecureStorageHelper._internal();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  SecureStorageHelper._internal();

  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }

  Future<void> logOut() async {
    String? tempAPI = await getBaseUrl();
    await clearAll();
    if (tempAPI != null) {
      await setBaseUrl(tempAPI);
    }
  }

  final String _kIsDarkTheme = "ShowDarkTheme";
  Future<void> setIsDarkTheme(bool value) async {
    await _secureStorage.write(key: _kIsDarkTheme, value: value.toString());
  }

  Future<bool> getIsDarkTheme() async {
    String? value = await _secureStorage.read(key: _kIsDarkTheme);
    return value == 'true';
  }

  /// Base URL preference.
  final String _kBaseUrl = "BaseURLAPI";
  Future<void> setBaseUrl(String value) async {
    await _secureStorage.write(key: _kBaseUrl, value: value);
  }

  Future<String?> getBaseUrl() async {
    return await _secureStorage.read(key: _kBaseUrl);
  }

  /// Login status preference.
  final String _kIsLogin = "IsLogin";
  Future<void> setIsLogin(bool value) async {
    await _secureStorage.write(key: _kIsLogin, value: value.toString());
  }

  Future<bool> getIsLogin() async {
    String? value = await _secureStorage.read(key: _kIsLogin);
    return value == 'true';
  }

  /// User code preference.
  final String _kUserCode = "UserCode";
  Future<void> setUserCode(String value) async {
    await _secureStorage.write(key: _kUserCode, value: value);
  }

  Future<String?> getUserCode() async {
    return await _secureStorage.read(key: _kUserCode);
  }
}
