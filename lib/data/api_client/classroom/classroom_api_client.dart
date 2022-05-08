import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:scholarr_mobile_frontend/cache/utils.dart';
import 'package:scholarr_mobile_frontend/models/models.dart';
import 'urls.dart';

class ClassroomClient {
  static final urls = ClassroomUrls();

  Future<dynamic> getClassroomDetail(int classroom_id) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final String? accessToken =
          sharedPreferences.getString('previousLoginAccess');

      final classroomURL = Uri.parse(urls.detailClassroomURL(classroom_id));
      final classroomMemberURL =
          Uri.parse(urls.listMemberClassroomURL(classroom_id));

      final classroomResponse = await http.get(
        classroomURL,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
      );

      final classroomMemberResponse = await http.get(
        classroomMemberURL,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
      );

      if (classroomResponse.statusCode < 400 &&
          classroomMemberResponse.statusCode < 400) {
        // debugPrint(response.body);
        final ClassroomItemDetail classroom =
            ClassroomItemDetail.fromJson(jsonDecode(classroomResponse.body));

        final ClassroomMemberList members = ClassroomMemberList.fromJson(
            jsonDecode(classroomMemberResponse.body));

        return {"classroom": classroom, "members": members};
      } else {
        return Error.fromJson(jsonDecode(classroomResponse.body));
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
    } on HttpException catch (error) {
      final jsonResponse = json.encode({
        'status': 400,
        'error': {
          'message': "Http error ",
          'verbose': "Something Went Wrong",
        }
      });
      return Error.fromJson(jsonDecode(jsonResponse));
    }
  }

  Future<dynamic> getClassroomList() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final String? accessToken =
          sharedPreferences.getString('previousLoginAccess');

      final url = Uri.parse(urls.selfListClassroomURL());

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
      );

      if (response.statusCode < 400) {
        debugPrint(response.body);
        final ClassroomItemList response_body =
            ClassroomItemList.fromJson(jsonDecode(response.body));

        final teaching_classrooms = response_body.teaching_classrooms
            .map((classroom) => ClassroomItem(
                  id: classroom["id"],
                  created_date: classroom["_created_date"],
                  archive: classroom["archive"],
                  name: classroom["name"],
                  subject: classroom["subject"],
                  classroom_code: classroom["classroom_code"],
                  teacher: classroom["teacher"],
                ))
            .toList();

        final studying_classrooms = response_body.studying_classrooms
            .map((classroom) => ClassroomItem(
                  id: classroom["id"],
                  created_date: classroom["_created_date"],
                  archive: classroom["archive"],
                  name: classroom["name"],
                  subject: classroom["subject"],
                  classroom_code: classroom["classroom_code"],
                  teacher: classroom["teacher"],
                ))
            .toList();

        return {
          "teaching_classrooms": teaching_classrooms,
          "studying_classrooms": studying_classrooms
        };
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
    } on HttpException catch (error) {
      final jsonResponse = json.encode({
        'status': 400,
        'error': {
          'message': "Http error ",
          'verbose': "Something Went Wrong",
        }
      });
      return Error.fromJson(jsonDecode(jsonResponse));
    }
  }

  Future<dynamic> createClassroom(String name, String subject) async {
    try {
      if (name == "" || subject == "") {
        throw const FormatException("Input fields must not be empty");
      }

      final sharedPreferences = await SharedPreferences.getInstance();
      final String? accessToken =
          sharedPreferences.getString('previousLoginAccess');

      final url = Uri.parse(urls.createClassroomURL());

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
        body: jsonEncode({
          "name": name,
          "subject": subject,
        }),
      );

      if (response.statusCode < 400) {
        return Success.fromJson(jsonDecode(response.body));
      } else {
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
    } on HttpException catch (error) {
      final jsonResponse = json.encode({
        'status': 400,
        'error': {
          'message': "Http error ",
          'verbose': "Something Went Wrong",
        }
      });
      return Error.fromJson(jsonDecode(jsonResponse));
    }
  }

  Future<dynamic> updateClassroom(
    int id,
    String name,
    String subject,
  ) async {
    try {
      if (name == "" || subject == "") {
        throw const FormatException("Input fields must not be empty");
      }

      final sharedPreferences = await SharedPreferences.getInstance();
      final String? accessToken = sharedPreferences.getString(prefLoginAccess);

      final url = Uri.parse(urls.updateClassroomURL(id));
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authentication': 'Bearer $accessToken'
        },
        body: jsonEncode({
          "name": name,
          "subject": subject,
          // "classroom_code": classroom_code,
          // "organisaion": teacher,
        }),
      );

      if (response.statusCode < 400) {
        return Success.fromJson(jsonDecode(response.body));
      } else {
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
