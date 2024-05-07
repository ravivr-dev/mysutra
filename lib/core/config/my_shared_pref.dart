import 'package:shared_preferences/shared_preferences.dart';

/// Class containing 'SharedPreferences' instance, all data will be
/// stored/read using this class
class MySharedPref {
  static const accessToken = "access_token";
  static const userRole = "role";
  static const isDoctorVerified = 'is_doctor_verified';
  static const _totalAccount = 'total_account';
  static const _isAccountSelected = 'is_account_selected';
  static const _userProfilePic = 'user_profile_pic';

  final SharedPreferences _pref;

  MySharedPref(this._pref);

  void saveAccessToken(String token) {
    _pref.setString(accessToken, token);
  }

  String? getAccessToken() {
    return _pref.getString(accessToken);
  }

  void setUserProfilePic(String url) {
    _pref.setString(_userProfilePic, url);
  }

  String? getUserProfilePic() {
    return _pref.getString(_userProfilePic);
  }

  void setIsDoctorVerified(bool isVerified) {
    _pref.setBool(isDoctorVerified, isVerified);
  }

  bool? get getIsDoctorVerified {
    return _pref.getBool(isDoctorVerified);
  }

  void setTotalUserAccounts(int totalAccount) {
    _pref.setInt(_totalAccount, totalAccount);
  }

  int? get getTotalUserAccounts {
    return _pref.getInt(_totalAccount);
  }

  void setIsAccountSelected(bool isSelected) {
    _pref.setBool(_isAccountSelected, isSelected);
  }

  bool? get getIsAccountSelected {
    return _pref.getBool(_isAccountSelected);
  }

  void logout() {
    _pref.remove(accessToken);
    _pref.remove(userRole);
    _pref.remove(isDoctorVerified);
    _pref.remove(_totalAccount);
    _pref.remove(_isAccountSelected);
  }

  String? getUserRole() {
    return _pref.getString(userRole);
  }

  Future<void> setUserRole(String role) async {
    await _pref.setString(userRole, role);
    return;
  }
}
