import 'package:shared_preferences/shared_preferences.dart';

class LoginCredentials {
  static const String prefLoginAccess = 'previousLoginAccess';
  static const String prefLoginRefresh = 'previousLoginRefersh';

  void saveLoginTokens(_response) async {
    if (_response!) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(prefLoginAccess, _response.access!);
      prefs.setString(prefLoginAccess, _response.refresh!);
    }
  }

  void getLoginTokens() async {
    final prefs = await SharedPreferences.getInstance();

    final String? accessToken = prefs.getString(prefLoginAccess);
    final String? accessRefresh = prefs.getString(prefLoginRefresh);
  }

  void getNewAccess() async {
    final prefs = await SharedPreferences.getInstance();
    final String? accessRefresh = prefs.getString(prefLoginRefresh);
  }
}
