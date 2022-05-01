import 'package:shared_preferences/shared_preferences.dart';

const String prefLoginAccess = 'previousLoginAccess';
const String prefLoginRefresh = 'previousLoginRefersh';

void saveLoginTokens(_response) async {
  if (_response!) {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(prefLoginAccess, _response.access!);
    prefs.setString(prefLoginAccess, _response.refresh!);
  }
}

// void getLoginTokens() async {
//   final prefs = await SharedPreferences.getInstance();

//   final String? accessToken = prefs.getString(prefLoginAccess);
//   final String? refreshToken = prefs.getString(prefLoginRefresh);
// }

void getNewAccess() async {
  final prefs = await SharedPreferences.getInstance();
  final String? refreshToken = prefs.getString(prefLoginRefresh);
}

Future<Map<String?, String?>> getLoginTokens() async {
  final prefs = await SharedPreferences.getInstance();

  final String? accessToken = prefs.getString(prefLoginAccess);
  final String? refreshToken = prefs.getString(prefLoginRefresh);

  return {
    "access": accessToken,
    "refresh": refreshToken,
  };
}

Future<String?> getAccessToken() async {
  final prefs = await SharedPreferences.getInstance();
  final String? accessToken = prefs.getString(prefLoginAccess);
  return accessToken;
}
