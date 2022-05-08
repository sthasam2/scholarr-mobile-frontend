// ignore_for_file: non_constant_identifier_names

class Schedule {
  int id;
  int created_by;
  int day;
  String time_start;
  String time_end;
  String room;
  String link;
  String note;

  Schedule({
    required this.id,
    required this.created_by,
    required this.day,
    required this.time_start,
    required this.time_end,
    required this.room,
    required this.link,
    required this.note,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
        id: json["id"] as int,
        created_by: json["_created_by"] as int,
        day: json["day"] as int,
        time_start: json["time_start"] as String,
        time_end: json["time_end"] as String,
        room: json["room"] as String,
        link: json["link"] as String,
        note: json["note"] as String);
  }
}
