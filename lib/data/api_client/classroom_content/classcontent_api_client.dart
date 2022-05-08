import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:scholarr_mobile_frontend/models/models.dart';
import 'urls.dart';

class ClasscontentClient {
  static final urls = ClasscontentUrls();

  // Future<dynamic> getSubmissionDetail(int submission_id) async {
  //   try {
  //     final sharedPreferences = await SharedPreferences.getInstance();
  //     final String? accessToken =
  //         sharedPreferences.getString('previousLoginAccess');

  //     //
  //     final url1 = Uri.parse(urls.detailSubmissionURL(submission_id));
  //     final response1 = await http.get(
  //       url1,
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer $accessToken'
  //       },
  //     );

  //     final url2 = Uri.parse(urls.detailSubmissionURL(submission_id));
  //     final response2 = await http.get(
  //       url2,
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer $accessToken'
  //       },
  //     );

  //     if (response1.statusCode < 400) {
  //       final SubmissionItemDetail response_body1 =
  //           SubmissionItemDetail.fromJson(jsonDecode(response1.body));

  //       final classwork =
  //           ClassroomContentListItem.fromJson(response_body.classwork);

  //       final attachments = (response_body.attachments!.isEmpty)
  //           ? []
  //           : response_body.attachments!
  //               .map((attachment) => AttachmentItem.fromJson(attachment))
  //               .toList();

  //       return {"classwork": classwork, "attachments": attachments};
  //     } else {
  //       return Error.fromJson(jsonDecode(response.body));
  //     }
  //     //

  //   } on SocketException {
  //     final jsonResponse = json.encode({
  //       'status': 400,
  //       'error': {
  //         'message': "Connection Error",
  //         'verbose': "Could not connect to the server. Please try again",
  //       }
  //     });
  //     return Error.fromJson(jsonDecode(jsonResponse));
  //   } on FormatException {
  //     final jsonResponse = json.encode({
  //       'status': 400,
  //       'error': {
  //         'message': "Empty fields",
  //         'verbose': "Input fields must not be empty",
  //       }
  //     });
  //     return Error.fromJson(jsonDecode(jsonResponse));
  //   } on HttpException catch (error) {
  //     final jsonResponse = json.encode({
  //       'status': 400,
  //       'error': {
  //         'message': "Http error ",
  //         'verbose': "Something Went Wrong",
  //       }
  //     });
  //     return Error.fromJson(jsonDecode(jsonResponse));
  //   }
  // }

  Future<dynamic> getClasscontentDetail(
      int classcontent_id, String type) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final String? accessToken =
          sharedPreferences.getString('previousLoginAccess');

      if (type == "CLASSWORK") {
        //
        final url = Uri.parse(urls.detailClassworkURL(classcontent_id));
        final response = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $accessToken'
          },
        );

        if (response.statusCode < 400) {
          final ClassworkItemDetail response_body =
              ClassworkItemDetail.fromJson(jsonDecode(response.body));

          final classwork =
              ClassroomContentListItem.fromJson(response_body.classwork);

          final attachments = (response_body.attachments!.isEmpty)
              ? []
              : response_body.attachments!
                  .map((attachment) => AttachmentItem.fromJson(attachment))
                  .toList();

          return {"classwork": classwork, "attachments": attachments};
        } else {
          return Error.fromJson(jsonDecode(response.body));
        }
        //
      } else if (type == "RESOURCE") {
        //
        final url = Uri.parse(urls.detailResourceURL(classcontent_id));
        final response = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $accessToken'
          },
        );

        if (response.statusCode < 400) {
          final ResourceItemDetail response_body =
              ResourceItemDetail.fromJson(jsonDecode(response.body));

          final resource =
              ClassroomContentListItem.fromJson(response_body.resource);

          final attachments = (response_body.attachments!.isEmpty)
              ? []
              : response_body.attachments!
                  .map((attachment) => AttachmentItem.fromJson(attachment))
                  .toList();

          return {"resource": resource, "attachments": attachments};
        } else {
          return Error.fromJson(jsonDecode(response.body));
        }
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

  Future<dynamic> getClasscontentList(int classroom_id) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final String? accessToken =
          sharedPreferences.getString('previousLoginAccess');

      final url = Uri.parse(urls.listClasscontentURL(classroom_id));

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
        final ClassroomContentList response_body =
            ClassroomContentList.fromJson(jsonDecode(response.body));

        final classwork_items = (response_body.classworks!.isEmpty)
            ? []
            : response_body.classworks!
                .map((classcontent) =>
                    ClassroomContentListItem.fromJson(classcontent))
                .toList();

        final resource_items = (response_body.resources!.isEmpty)
            ? []
            : response_body.resources!
                .map((classcontent) =>
                    ClassroomContentListItem.fromJson(classcontent))
                .toList();

        return {"classworks": classwork_items, "resources": resource_items};
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

  Future<dynamic> getClassworkSubmissionList(int classwork_id) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final String? accessToken =
          sharedPreferences.getString('previousLoginAccess');

      final url = Uri.parse(urls.listSubmissionURL(classwork_id));
      final selfUrl = Uri.parse(urls.listSelfSubmissionURL(classwork_id));

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
      );

      final selfResponse = await http.get(
        selfUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
      );

      if (response.statusCode < 400 && selfResponse.statusCode < 400) {
        // debugPrint(response.body);
        final ClassworkSubmissionList response_body =
            ClassworkSubmissionList.fromJson(jsonDecode(response.body));
        // final classwork =
        //     ClassroomContentListItem.fromJson(response_body.classwork!);
        final submission_items = (response_body.submissions!.isEmpty)
            ? []
            : response_body.submissions!
                .map((submission) => SubmissionListItem.fromJson(submission))
                .toList();

        final ClassworkSubmissionList self_response_body =
            ClassworkSubmissionList.fromJson(jsonDecode(selfResponse.body));
        // final self_classwork =
        //     ClassroomContentListItem.fromJson(self_response_body.classwork!);
        final self_submission_items = (self_response_body.submissions!.isEmpty)
            ? []
            : self_response_body.submissions!
                .map((submission) => SubmissionListItem.fromJson(submission))
                .toList();

        return {
          "self": self_submission_items,
          "all": submission_items,
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

  Future<dynamic> createClasscontent(
      int classroom_id,
      String title,
      String description,
      String content_type,
      String? deadline,
      int? weightage,
      String? attachment_path,
      String? type) async {
    try {
      final classwork_content_options = {
        "ASSIGNMENT": "C_A",
        "QUESTION": "C_Q",
        "TEST": "C_T",
        "POLL": "C_P",
        "DEFAULT": "C_D",
      };
      final resource_content_options = {
        "NOTES": "R_N",
        "BOOKS": "R_B",
        "LECTURE_PLAN": "R_LP",
        "MEDIA": "R_M",
        "LINKS": "R_L",
        "DEFAULT": "R_D",
      };

      final response;

      if (title == "" || description == "" || content_type == "") {
        throw const FormatException("Input fields must not be empty");
      }

      final sharedPreferences = await SharedPreferences.getInstance();
      final String? accessToken =
          sharedPreferences.getString('previousLoginAccess');

      if (type == "CLASSWORK") {
        //
        final url = Uri.parse(urls.createClassworkURL(classroom_id));
        final request = http.MultipartRequest("POST", url);

        request.headers['Authorization'] = 'Bearer $accessToken';
        request.fields.addAll({
          "title": title,
          "description": description,
          "content_type": classwork_content_options[content_type]!,
          "weightage": weightage!.toString()
        });

        if (attachment_path != null) {
          request.files.add(await http.MultipartFile.fromPath(
              'attachments', attachment_path));
        }

        response = await request.send();
        final responseString = await response.stream.bytesToString();

        if (response.statusCode < 400) {
          return Success.fromJson(jsonDecode(responseString));
        } else {
          return Error.fromJson(jsonDecode(responseString));
        }
      } else if (type == "RESOURCE") {
        final url = Uri.parse(urls.createResourceURL(classroom_id));
        final request = http.MultipartRequest("POST", url);

        request.headers['Authorization'] = 'Bearer $accessToken';
        request.fields.addAll({
          "title": title,
          "description": description,
          "content_type": classwork_content_options[content_type]!,
          "deadline": deadline!.toString()
        });

        if (attachment_path != null) {
          request.files.add(await http.MultipartFile.fromPath(
              'attachments', attachment_path));
        }

        response = await request.send();
        final responseString = await response.stream.bytesToString();

        if (response.statusCode < 400) {
          return Success.fromJson(jsonDecode(responseString));
        } else {
          return Error.fromJson(jsonDecode(responseString));
        }
        //
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

  Future<dynamic> createClassworkSubmission(int classwork_id, String answer,
      String? attachment_path, String? type) async {
    try {
      // final classwork_content_options = {
      //   "ASSIGNMENT": "C_A",
      //   "QUESTION": "C_Q",
      //   "TEST": "C_T",
      //   "POLL": "C_P",
      //   "DEFAULT": "C_D",
      // };
      // final resource_content_options = {
      //   "NOTES": "R_N",
      //   "BOOKS": "R_B",
      //   "LECTURE_PLAN": "R_LP",
      //   "MEDIA": "R_M",
      //   "LINKS": "R_L",
      //   "DEFAULT": "R_D",
      // };

      final response;

      if (answer == "" && attachment_path == null) {
        throw const FormatException("Input fields must not be empty");
      }

      final sharedPreferences = await SharedPreferences.getInstance();
      final String? accessToken =
          sharedPreferences.getString('previousLoginAccess');

      //
      final url = Uri.parse(urls.createSubmissionURL(classwork_id));
      final request = http.MultipartRequest("POST", url);

      request.headers['Authorization'] = 'Bearer $accessToken';
      request.fields["answer"] = answer;

      if (attachment_path != null) {
        request.files.add(
            await http.MultipartFile.fromPath('attachments', attachment_path));
      }

      response = await request.send();
      final responseString = await response.stream.bytesToString();

      if (response.statusCode < 400) {
        return Success.fromJson(jsonDecode(responseString));
      } else {
        return Error.fromJson(jsonDecode(responseString));
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

//   Future<dynamic> updateClasscontent(
//     int id,
//     String name,
//     String subject,
//   ) async {
//     try {
//       if (name == "" || subject == "") {
//         throw const FormatException("Input fields must not be empty");
//       }

//       final sharedPreferences = await SharedPreferences.getInstance();
//       final String? accessToken = sharedPreferences.getString(prefLoginAccess);

//       final url = Uri.parse(urls.updateClasscontentURL(id));
//       final response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/json; charset=UTF-8',
//           'Authentication': 'Bearer $accessToken'
//         },
//         body: jsonEncode({
//           "name": name,
//           "subject": subject,
//           // "classcontent_code": classcontent_code,
//           // "organisaion": teacher,
//         }),
//       );

//       if (response.statusCode < 400) {
//         return Success.fromJson(jsonDecode(response.body));
//       } else {
//         return Error.fromJson(jsonDecode(response.body));
//       }
//     } on SocketException {
//       final jsonResponse = json.encode({
//         'status': 400,
//         'error': {
//           'message': "Connection Error",
//           'verbose': "Could not connect to the server. Please try again",
//         }
//       });
//       return Error.fromJson(jsonDecode(jsonResponse));
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
}
