import 'package:shared_preferences/shared_preferences.dart';

/// Class containing 'SharedPreferences' instance, all data will be
/// stored/read using this class
class MySharedPref {
  static const accessToken = "access_token";
  static const userRole = "role";

  final SharedPreferences _pref;

  MySharedPref(this._pref);

  void saveAccessToken(String token) {
    _pref.setString(accessToken, token);
  }

  String? getAccessToken() {
    return _pref.getString(accessToken);
  }

  void logout() {
    _pref.remove(accessToken);
    _pref.remove(userRole);
  }

  String? getUserRole() {
    return _pref.getString(userRole);
  }

  Future<void> setUserRole(String role) async {
    await _pref.setString(userRole, role);
    return;
  }
}
