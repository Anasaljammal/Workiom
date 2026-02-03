import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

@lazySingleton
class SharedPrefsService {
  final SharedPreferences _prefs;

  SharedPrefsService(this._prefs);

  Future<void> saveLanguage(String languageCode) async {
    await _prefs.setString(AppConstants.keyLanguage, languageCode);
  }

  String? getLanguage() {
    return _prefs.getString(AppConstants.keyLanguage);
  }

  Future<void> setLoggedIn(bool isLoggedIn) async {
    await _prefs.setBool(AppConstants.keyIsLoggedIn, isLoggedIn);
  }

  bool isLoggedIn() {
    return _prefs.getBool(AppConstants.keyIsLoggedIn) ?? false;
  }

  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
