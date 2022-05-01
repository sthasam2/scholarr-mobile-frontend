import '../../urls.dart' show URL;

class ClassroomUrls {
  String classroomURL() => URL + '/api/classroom';

  String listClassroomURL() => classroomURL() + '/list';
  String selfListClassroomURL() => classroomURL() + '/self/list';

  String createClassroomURL() => classroomURL() + '/create';
  String idClassroomURL(String classroom_id) =>
      URL + '/api/classroom/id=$classroom_id';
  String detailClassroomURL(String classroom_id) =>
      idClassroomURL(classroom_id) + '/detail';
  String updateClassroomURL(String classroom_id) =>
      idClassroomURL(classroom_id) + '/update';
  String toggleArchiveClassroomURL(String classroom_id) =>
      idClassroomURL(classroom_id) + '/toggle_archive';
  String deleteClassroomURL(String classroom_id) =>
      idClassroomURL(classroom_id) + '/delete';

  String listInviteRequestClassroomURL(String classroom_id) =>
      idClassroomURL(classroom_id) + '/invite_request/list';
  String listMemberClassroomURL(String classroom_id) =>
      idClassroomURL(classroom_id) + '/member/list';
  String selfListInviteRequestClassroomURL() =>
      classroomURL() + '/invite_request/self/list';

  String createInviteClassrooomURL() => classroomURL() + '/invite/create';
  String createRequestClassrooomURL() => classroomURL() + '/request/create';

  String idInviteRequestClassroomURL(String invite_request_id) =>
      classroomURL() + '/id=$invite_request_id';

  String acceptInviteRequestClassroomURL(String invite_request_id) =>
      idInviteRequestClassroomURL(invite_request_id) + '/request/accept';
  String rejectInviteRequestClassroomURL(String invite_request_id) =>
      idInviteRequestClassroomURL(invite_request_id) + '/request/reject';
  String deleteInviteRequestClassroomURL(String invite_request_id) =>
      idInviteRequestClassroomURL(invite_request_id) + '/request/delete';
  String detailInviteRequestClassroomURL(String invite_request_id) =>
      idInviteRequestClassroomURL(invite_request_id) + '/request/detail';
}
