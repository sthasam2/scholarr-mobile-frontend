import '../../urls.dart' show URL;

class ScheduleUrls {
  String scheduleURL() => URL + '/schedule';
  String idScheduleURL(String schedule_id) =>
      scheduleURL() + "/id=$schedule_id";
  String selfListScheduleURL() => scheduleURL() + '/self/list';

  String createClassroomScheduleURL(String classroom_id) =>
      scheduleURL() + '/classroom/id=$classroom_id';
  String listClassroomScheduleURL(String classroom_id) =>
      scheduleURL() + '/classroom/id=$classroom_id';

  String detailScheduleURL(String schedule_id) =>
      idScheduleURL(schedule_id) + '/detail';
  String updateScheduleURL(String schedule_id) =>
      idScheduleURL(schedule_id) + '/update';
  String deleteScheduleURL(String schedule_id) =>
      idScheduleURL(schedule_id) + '/delete';
}
