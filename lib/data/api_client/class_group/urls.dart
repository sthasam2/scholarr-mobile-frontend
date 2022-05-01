import '../../urls.dart' show URL;

class ClassGroupUrls {
  String classgroupURL() => URL + '/api/class_group';
  String listClassgroupURL() => classgroupURL() + '/list';
  String selfListClassgroupURL() => classgroupURL() + '/self/list';
  String createClassgroupURL() => classgroupURL() + '/create';

  String idClassgroupURL(int class_group_id) =>
      classgroupURL() + '/id=$class_group_id';

  String detailClassgroupURL(int class_group_id) =>
      idClassgroupURL(class_group_id) + '/detail';
  String updateClassgroupURL(int class_group_id) =>
      idClassgroupURL(class_group_id) + '/update';
  String deleteClassgroupURL(int class_group_id) =>
      idClassgroupURL(class_group_id) + '/delete';
  String toggleActiveClassgroupURL(int class_group_id) =>
      idClassgroupURL(class_group_id) + '/toggle_active';
  String listInviteRequestClassgroupURL(int class_group_id) =>
      idClassgroupURL(class_group_id) + '/invite_request/list';
  String listMemberClassgroupURL(int class_group_id) =>
      idClassgroupURL(class_group_id) + '/member/list';
  String listSelfInviteRequestClassgroupURL() => classgroupURL() + '/self/list';

  String inviteRequestClassgroupURL(String invite_request_id) =>
      classgroupURL() + '/invite_request/id=$invite_request_id';
  String acceptInviteRequestClassgroupURL(String invite_request_id) =>
      inviteRequestClassgroupURL(invite_request_id) + '/accept';
  String rejectInviteRequestClassgroupURL(String invite_request_id) =>
      inviteRequestClassgroupURL(invite_request_id) + '/reject';
  String deleteInviteRequestClassgroupURL(String invite_request_id) =>
      inviteRequestClassgroupURL(invite_request_id) + '/delete';

  String createInviteClassgroupURL() => classgroupURL() + '/invite/create';
  String createRequestClassgroupURL() => classgroupURL() + 'request/create';
}
