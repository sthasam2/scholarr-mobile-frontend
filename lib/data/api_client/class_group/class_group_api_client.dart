import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:scholarr_mobile_frontend/models/models.dart';
import 'package:scholarr_mobile_frontend/cache/utils.dart';
import 'urls.dart';

class ClassGroupClient {
  static final urls = ClassGroupUrls();

  Future<dynamic> getClassgroupDetail(int classgroup_id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('previousLoginAccess');

      final classgroupURL = Uri.parse(urls.detailClassgroupURL(classgroup_id));
      final classgroupMemberURL =
          Uri.parse(urls.listMemberClassgroupURL(classgroup_id));

      final classgroupResponse = await http.get(
        classgroupURL,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
      );

      final classgroupMemberResponse = await http.get(
        classgroupMemberURL,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
      );

      if (classgroupResponse.statusCode < 400 &&
          classgroupMemberResponse.statusCode < 400) {
        // debugPrint(response.body);
        final ClassGroupItemDetail classgroup =
            ClassGroupItemDetail.fromJson(jsonDecode(classgroupResponse.body));

        final ClassGroupMemberList members = ClassGroupMemberList.fromJson(
            jsonDecode(classgroupMemberResponse.body));

        return {"classgroup": classgroup, "members": members};
      } else {
        return Error.fromJson(jsonDecode(classgroupResponse.body));
        // throw Exception("Failed to register user");
      }
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
          'message': "Empty ",
          'verbose': "Input fields must not be empty",
        }
      });
      return Error.fromJson(jsonDecode(jsonResponse));
    }
  }

  Future<dynamic> getClassgroupList() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('previousLoginAccess');

      final url = Uri.parse(urls.selfListClassgroupURL());

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
        final ClassGroupItemList response_body =
            ClassGroupItemList.fromJson(jsonDecode(response.body));

        final created = response_body.created_classgroups
            .map((classgroup) => ClassGroupItem(
                  id: classgroup["id"],
                  created_date: classgroup["_created_date"],
                  active: classgroup["active"],
                  name: classgroup["name"],
                  faculty: classgroup["faculty"],
                  batch: classgroup["batch"],
                  organisation: classgroup["organisation"],
                ))
            .toList();
        final student = response_body.student_classgroups
            .map((classgroup) => ClassGroupItem(
                  id: classgroup["id"],
                  created_date: classgroup["_created_date"],
                  active: classgroup["active"],
                  name: classgroup["name"],
                  faculty: classgroup["faculty"],
                  batch: classgroup["batch"],
                  organisation: classgroup["organisation"],
                ))
            .toList();
        return {"created": created, "student": student};
      } else {
        return Error.fromJson(jsonDecode(response.body));
        // throw Exception("Failed to register user");
      }
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
          'message': "Empty ",
          'verbose': "Input fields must not be empty",
        }
      });
      return Error.fromJson(jsonDecode(jsonResponse));
    }
  }

  Future<dynamic> createClassgroup(
      String name, String faculty, String batch, String organisation) async {
    try {
      if (name == "" || faculty == "" || batch == "" || organisation == "") {
        throw const FormatException("Input fields must not be empty");
      }

      final prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('previousLoginAccess');

      final url = Uri.parse(urls.createClassgroupURL());

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
        body: jsonEncode({
          "name": name,
          "faculty": faculty,
          "batch": batch,
          "organisation": organisation,
        }),
      );

      if (response.statusCode < 400) {
        return Success.fromJson(jsonDecode(response.body));
      } else {
        return Error.fromJson(jsonDecode(response.body));
        // throw Exception("Failed to register user");
      }
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
          'message': "Empty ",
          'verbose': "Input fields must not be empty",
        }
      });
      return Error.fromJson(jsonDecode(jsonResponse));
    }
  }

  Future<dynamic> updateClassgroup(
    int id,
    String name,
    String faculty,
    String batch,
    String organisation,
  ) async {
    try {
      if (name == "" || faculty == "" || batch == "" || organisation == "") {
        throw const FormatException("Input fields must not be empty");
      }

      final prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString(prefLoginAccess);

      final url = Uri.parse(urls.updateClassgroupURL(id));
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authentication': 'Bearer $accessToken'
        },
        body: jsonEncode({
          "name": name,
          "faculty": faculty,
          "batch": batch,
          "organisaion": organisation,
        }),
      );

      if (response.statusCode < 400) {
        return Success.fromJson(jsonDecode(response.body));
      } else {
        return Error.fromJson(jsonDecode(response.body));
        // throw Exception("Failed to register user");
      }
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
