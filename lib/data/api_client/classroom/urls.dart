import '../../urls.dart' show URL;

class ClassroomUrls {
  //
  // CLASSROOM

  String classroomURL() => URL + '/api/classroom';

  String listClassroomURL() => URL + '/api/classroom/list';
  String selfListClassroomURL() => URL + '/api/classroom/self/list';

  String createClassroomURL() => URL + '/api/classroom/create';

  String idClassroomURL(int classroom_id) =>
      URL + '/api/classroom/id=$classroom_id';
  String detailClassroomURL(int classroom_id) =>
      URL + '/api/classroom/id=$classroom_id/detail';
  String updateClassroomURL(int classroom_id) =>
      URL + '/api/classroom/id=$classroom_id/update';
  String toggleArchiveClassroomURL(int classroom_id) =>
      URL + '/api/classroom/id=$classroom_id/toggle_archive';
  String deleteClassroomURL(int classroom_id) =>
      URL + '/api/classroom/id=$classroom_id/delete';

  // CLASSROOM MEMBER
  String listInviteRequestClassroomURL(int classroom_id) =>
      URL + '/api/classroom/id=$classroom_id/invite_request/list';
  String listMemberClassroomURL(int classroom_id) =>
      URL + '/api/classroom/id=$classroom_id/member/list';
  String selfListInviteRequestClassroomURL() =>
      URL + '/api/classroom/invite_request/self/list';

  String createInviteClassrooomURL() => URL + '/api/classroom/invite/create';
  String createRequestClassrooomURL() => URL + '/api/classroom/request/create';

  // String idInviteRequestClassroomURL(String invite_request_id) =>
  //     URL + '/api/classroom/id=$invite_request_id';

  String acceptInviteRequestClassroomURL(int invite_request_id) =>
      URL + '/api/classroom/id=$invite_request_id/request/accept';
  String rejectInviteRequestClassroomURL(int invite_request_id) =>
      URL + '/api/classroom/id=$invite_request_id/request/reject';
  String deleteInviteRequestClassroomURL(int invite_request_id) =>
      URL + '/api/classroom/id=$invite_request_id/request/delete';
  String detailInviteRequestClassroomURL(int invite_request_id) =>
      URL + '/api/classroom/id=$invite_request_id/request/detail';
}
