// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'dart:io';

// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:scholarr_mobile_frontend/models/models.dart';
// import 'package:scholarr_mobile_frontend/cache/utils.dart';
// import 'urls.dart';

// class ClassroomClient {
//   static final urls = ClassroomUrls();

//   Future<dynamic> getClassroomDetail(int classroom_id) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final String? accessToken = prefs.getString('previousLoginAccess');

//       final classroomURL = Uri.parse(urls.detailClassroomURL(classroom_id));
//       final classroomMemberURL =
//           Uri.parse(urls.listMemberClassroomURL(classroom_id));

//       final classroomResponse = await http.get(
//         classroomURL,
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer $accessToken'
//         },
//       );

//       final classroomMemberResponse = await http.get(
//         classroomMemberURL,
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer $accessToken'
//         },
//       );

//       if (classroomResponse.statusCode < 400 &&
//           classroomMemberResponse.statusCode < 400) {
//         // debugPrint(response.body);
//         final ClassroomItemDetail classroom =
//             ClassroomItemDetail.fromJson(jsonDecode(classroomResponse.body));

//         final ClassroomMemberList members = ClassroomMemberList.fromJson(
//             jsonDecode(classroomMemberResponse.body));

//         return {"classroom": classroom, "members": members};
//       } else {
//         return Error.fromJson(jsonDecode(classroomResponse.body));
//         // throw Exception("Failed to register user");
//       }
//     } on FormatException {
//       final jsonResponse = json.encode({
//         'status': 400,
//         'error': {
//           'message': "Empty fields",
//           'verbose': "Input fields must not be empty",
//         }
//       });
//       return Error.fromJson(jsonDecode(jsonResponse));
//     } on HttpException catch (error) {
//       final jsonResponse = json.encode({
//         'status': 400,
//         'error': {
//           'message': "Empty ",
//           'verbose': "Input fields must not be empty",
//         }
//       });
//       return Error.fromJson(jsonDecode(jsonResponse));
//     }
//   }

//   Future<dynamic> getClassroomList() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final String? accessToken = prefs.getString('previousLoginAccess');

//       final url = Uri.parse(urls.selfListClassroomURL());

//       final response = await http.get(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer $accessToken'
//         },
//       );

//       if (response.statusCode < 400) {
//         debugPrint(response.body);
//         final ClassroomItemList response_body =
//             ClassroomItemList.fromJson(jsonDecode(response.body));

//         final created = response_body.created_classrooms
//             .map((classroom) => ClassroomItem(
//                   id: classroom["id"],
//                   created_date: classroom["_created_date"],
//                   active: classroom["active"],
//                   name: classroom["name"],
//                   faculty: classroom["faculty"],
//                   batch: classroom["batch"],
//                   organisation: classroom["organisation"],
//                 ))
//             .toList();
//         final student = response_body.student_classrooms
//             .map((classroom) => ClassroomItem(
//                   id: classroom["id"],
//                   created_date: classroom["_created_date"],
//                   active: classroom["active"],
//                   name: classroom["name"],
//                   faculty: classroom["faculty"],
//                   batch: classroom["batch"],
//                   organisation: classroom["organisation"],
//                 ))
//             .toList();
//         return {"created": created, "student": student};
//       } else {
//         return Error.fromJson(jsonDecode(response.body));
//         // throw Exception("Failed to register user");
//       }
//     } on FormatException {
//       final jsonResponse = json.encode({
//         'status': 400,
//         'error': {
//           'message': "Empty fields",
//           'verbose': "Input fields must not be empty",
//         }
//       });
//       return Error.fromJson(jsonDecode(jsonResponse));
//     } on HttpException catch (error) {
//       final jsonResponse = json.encode({
//         'status': 400,
//         'error': {
//           'message': "Empty ",
//           'verbose': "Input fields must not be empty",
//         }
//       });
//       return Error.fromJson(jsonDecode(jsonResponse));
//     }
//   }

//   Future<dynamic> createClassroom(
//       String name, String faculty, String batch, String organisation) async {
//     try {
//       if (name == "" || faculty == "" || batch == "" || organisation == "") {
//         throw const FormatException("Input fields must not be empty");
//       }

//       final prefs = await SharedPreferences.getInstance();
//       final String? accessToken = prefs.getString('previousLoginAccess');

//       final url = Uri.parse(urls.createClassroomURL());

//       final response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer $accessToken'
//         },
//         body: jsonEncode({
//           "name": name,
//           "faculty": faculty,
//           "batch": batch,
//           "organisation": organisation,
//         }),
//       );

//       if (response.statusCode < 400) {
//         return Success.fromJson(jsonDecode(response.body));
//       } else {
//         return Error.fromJson(jsonDecode(response.body));
//         // throw Exception("Failed to register user");
//       }
//     } on FormatException {
//       final jsonResponse = json.encode({
//         'status': 400,
//         'error': {
//           'message': "Empty fields",
//           'verbose': "Input fields must not be empty",
//         }
//       });
//       return Error.fromJson(jsonDecode(jsonResponse));
//     } on HttpException catch (error) {
//       final jsonResponse = json.encode({
//         'status': 400,
//         'error': {
//           'message': "Empty ",
//           'verbose': "Input fields must not be empty",
//         }
//       });
//       return Error.fromJson(jsonDecode(jsonResponse));
//     }
//   }

//   Future<dynamic> updateClassroom(
//     int id,
//     String name,
//     String faculty,
//     String batch,
//     String organisation,
//   ) async {
//     try {
//       if (name == "" || faculty == "" || batch == "" || organisation == "") {
//         throw const FormatException("Input fields must not be empty");
//       }

//       final prefs = await SharedPreferences.getInstance();
//       final String? accessToken = prefs.getString(prefLoginAccess);

//       final url = Uri.parse(urls.updateClassroomURL(id));
//       final response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/json; charset=UTF-8',
//           'Authentication': 'Bearer $accessToken'
//         },
//         body: jsonEncode({
//           "name": name,
//           "faculty": faculty,
//           "batch": batch,
//           "organisaion": organisation,
//         }),
//       );

//       if (response.statusCode < 400) {
//         return Success.fromJson(jsonDecode(response.body));
//       } else {
//         return Error.fromJson(jsonDecode(response.body));
//         // throw Exception("Failed to register user");
//       }
//     } on FormatException {
//       final jsonResponse = json.encode({
//         'status': 400,
//         'error': {
//           'message': "Empty fields",
//           'verbose': "Input fields must not be empty",
//         }
//       });
//       return Error.fromJson(jsonDecode(jsonResponse));
//     } on HttpException {
//       final jsonResponse = json.encode({
//         'status': 400,
//         'error': {
//           'message': "Empty ",
//           'verbose': "Input fields must not be empty",
//         }
//       });
//       return Error.fromJson(jsonDecode(jsonResponse));
//     }
//   }
// }
