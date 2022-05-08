import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:scholarr_mobile_frontend/models/models.dart';
import 'urls.dart';

class AuthClient {
  static final urls = AuthUrls();

  Future<dynamic> registerUser(
      String username, String email, String password) async {
    try {
      final url = Uri.parse(urls.registerURL());
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "email": email,
          "username": username,
          "password": password,
        }),
      );

      if (response.statusCode < 400) {
        return Success.fromJson(jsonDecode(response.body));
      } else {
        return Error.fromJson(jsonDecode(response.body));
        // throw Exception("Failed to register user");
      }
    } on SocketException {
      final jsonResponse = json.encode({
        'status': 400,
        'error': {
          'message': "Connection Error",
          'verbose': "Could not connect to the server. Please try again",
        }
      });
      return Error.fromJson(jsonDecode(jsonResponse));
    } on FormatException {
      final jsonResponse = json.encode({
        'status': 400,
        'error': {
          'message': "Empty fields",
          'verbose': "Input fields must not be empty",
        }
      });
      return Error.fromJson(jsonDecode(jsonResponse));
    } on HttpException {
      final jsonResponse = json.encode({
        'status': 400,
        'error': {
          'message': "Empty ",
          'verbose': "Input fields must not be empty",
        }
      });
      return Error.fromJson(jsonDecode(jsonResponse));
    }
  }

  Future<dynamic> loginUser(String username, String password) async {
    try {
      if (username == "" || password == "") {
        throw const FormatException("Input fields must not be empty");
      }

      final url = Uri.parse(urls.loginURL());
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "username": username,
          "password": password,
        }),
      );

      if (response.statusCode < 400) {
        return LoginSuccess.fromJson(jsonDecode(response.body));
      } else {
        // throw Exception("Failed to register user");
        return Error.fromJson(jsonDecode(response.body));
      }
    } on SocketException {
      final jsonResponse = json.encode({
        'status': 400,
        'error': {
          'message': "Connection Error",
          'verbose': "Could not connect to the server. Please try again",
        }
      });
      return Error.fromJson(jsonDecode(jsonResponse));
    } on FormatException {
      final jsonResponse = json.encode({
        'status': 400,
        'error': {
          'message': "Empty fields",
          'verbose': "Input fields must not be empty",
        }
      });
      return Error.fromJson(jsonDecode(jsonResponse));
    } on HttpException {
      final jsonResponse = json.encode({
        'status': 400,
        'error': {
          'message': "Empty ",
          'verbose': "Input fields must not be empty",
        }
      });
      return Error.fromJson(jsonDecode(jsonResponse));
    }
  }

  Future<dynamic> loginRefresh(String refresh) async {
    try {
      final url = Uri.parse(urls.loginRefreshURL());
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "refresh": refresh,
        }),
      );

      if (response.statusCode < 400) {
        return LoginSuccess.fromJson(jsonDecode(response.body));
      } else {
        // throw Exception("Failed to register user");
        return Error.fromJson(jsonDecode(response.body));
      }
    } on SocketException {
      final jsonResponse = json.encode({
        'status': 400,
        'error': {
          'message': "Connection Error",
          'verbose': "Could not connect to the server. Please try again",
        }
      });
      return Error.fromJson(jsonDecode(jsonResponse));
    } on FormatException {
      final jsonResponse = json.encode({
        'status': 400,
        'error': {
          'message': "Empty fields",
          'verbose': "Input fields must not be empty",
        }
      });
      return Error.fromJson(jsonDecode(jsonResponse));
    } on HttpException {
      final jsonResponse = json.encode({
        'status': 400,
        'error': {
          'message': "Empty ",
          'verbose': "Input fields must not be empty",
        }
      });
      return Error.fromJson(jsonDecode(jsonResponse));
    }
  }
}
