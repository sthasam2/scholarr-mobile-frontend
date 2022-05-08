import 'package:shared_preferences/shared_preferences.dart';

const String prefLoginAccess = 'previousLoginAccess';
const String prefLoginRefresh = 'previousLoginRefresh';

void saveLoginTokens(_response) async {
  if (_response!) {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(prefLoginAccess, _response.access!);
    sharedPreferences.setString(prefLoginAccess, _response.refresh!);
  }
}

// void getLoginTokens() async {
//   final sharedPreferences = await SharedPreferences.getInstance();

//   final String? accessToken = sharedPreferences.getString(prefLoginAccess);
//   final String? refreshToken = sharedPreferences.getString(prefLoginRefresh);
// }

void getNewAccess() async {
  final sharedPreferences = await SharedPreferences.getInstance();
}

Future<Map<String?, String?>> getLoginTokens() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  final String? accessToken = sharedPreferences.getString(prefLoginAccess);
  final String? refreshToken = sharedPreferences.getString(prefLoginRefresh);

  return {
    "access": accessToken,
    "refresh": refreshToken,
  };
}

Future<String?> getAccessToken() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final String? accessToken = sharedPreferences.getString(prefLoginAccess);
  return accessToken;
}
