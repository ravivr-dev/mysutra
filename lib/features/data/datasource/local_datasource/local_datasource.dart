import 'package:my_sutra/core/config/my_shared_pref.dart';

abstract class LocalDataSource {
  String? getAccessToken();

  setAccessToken(String token);

  String? getUserRole();

  setUserRole(String role);

  String? getCurrentAcademy();

  setCurrentAcademy(String id);

  String getUsername();

  setUserName(String name);

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
  String? getUserRole() {
    return mySharedPref.getUserRole();
  }

  @override
  setUserRole(String role) {
    return mySharedPref.setUserRole(role);
  }

  @override
  String? getCurrentAcademy() {
    return mySharedPref.getCurrentAcademy();
  }

  @override
  setCurrentAcademy(String id) {
    return mySharedPref.setCurrentAcademy(id);
  }

  @override
  String getUsername() {
    return mySharedPref.getUserName();
  }

  @override
  setUserName(String name) {
    return mySharedPref.setUserName(name);
  }
}
