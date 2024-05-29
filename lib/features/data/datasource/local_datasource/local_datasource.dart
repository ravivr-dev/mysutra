import 'package:my_sutra/core/config/my_shared_pref.dart';
import 'package:my_sutra/core/utils/constants.dart';

abstract class LocalDataSource {
  String? getAccessToken();

    setAccessToken(String token);

  setUserProfilePic(String url);

  String? getUserProfilePic();

  String getUserRole();

  setUserRole(String role);

  void setIsDoctorVerified(bool isVerified);

  bool get getIsDoctorVerified;

  void setTotalUserAccounts(int totalAccount);

  int? get getTotalUserAccounts;

  void setIsAccountSelected(bool isSelected);

  bool? get getIsAccountSelected;

  logout();
}

class LocalDataSourceImpl extends LocalDataSource {
  final MySharedPref mySharedPref;

  LocalDataSourceImpl(this.mySharedPref);

  @override
  String? getAccessToken() {
    return mySharedPref.getAccessToken();
  }

  @override
  setAccessToken(String token) {
    return mySharedPref.saveAccessToken(token);
  }

  @override
  logout() {
    return mySharedPref.logout();
  }

  @override
  String getUserRole() {
    return mySharedPref.getUserRole() ?? ROLE_PATIENT;
  }

  @override
  setUserRole(String role) {
    return mySharedPref.setUserRole(role);
  }

  @override
  bool get getIsDoctorVerified => mySharedPref.getIsDoctorVerified ?? true;

  @override
  void setIsDoctorVerified(bool isVerified) {
    return mySharedPref.setIsDoctorVerified(isVerified);
  }

  @override
  int? get getTotalUserAccounts => mySharedPref.getTotalUserAccounts;

  @override
  void setTotalUserAccounts(int totalAccount) {
    mySharedPref.setTotalUserAccounts(totalAccount);
  }

  @override
  bool? get getIsAccountSelected => mySharedPref.getIsAccountSelected;

  @override
  void setIsAccountSelected(bool isSelected) {
    return mySharedPref.setIsAccountSelected(isSelected);
  }

  @override
  String? getUserProfilePic() {
    return mySharedPref.getUserProfilePic();
  }

  @override
  setUserProfilePic(String url) {
    return mySharedPref.setUserProfilePic(url);
  }
}
