// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'classroom.g.dart';

@JsonSerializable()
class ClassroomCreate {
  String name;
  String subject;

  ClassroomCreate({
    required this.name,
    required this.subject,
  });

  factory ClassroomCreate.fromJson(Map<String, dynamic> json) =>
      _$ClassroomCreateFromJson(json);

  Map<String, dynamic> toJson() => _$ClassroomCreateToJson(this);
}

@JsonSerializable()
class ClassroomItemDetail {
  int id;
  String name;
  String subject;
  String classroom_code;
  bool archive;
  Map teacher;

  @JsonKey(name: "_created_date")
  String created_date;

  @JsonKey(name: "_modified_date")
  String? modified_date;

  @JsonKey(name: "_created_by")
  int? created_by;

  ClassroomItemDetail({
    required this.id,
    required this.name,
    required this.subject,
    required this.classroom_code,
    required this.archive,
    required this.teacher,
    required this.created_date,
    required this.modified_date,
    required this.created_by,
  });

  factory ClassroomItemDetail.fromJson(Map<String, dynamic> json) =>
      _$ClassroomItemDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ClassroomItemDetailToJson(this);
}

@JsonSerializable()
class ClassroomItemList {
  List studying_classrooms;
  List teaching_classrooms;

  ClassroomItemList({
    required this.studying_classrooms,
    required this.teaching_classrooms,
    // required this.count,
  });

  factory ClassroomItemList.fromJson(Map<String, dynamic> json) =>
      _$ClassroomItemListFromJson(json);

  Map<String, dynamic> toJson() => _$ClassroomItemListToJson(this);
}

@JsonSerializable()
class ClassroomItem {
  int id;
  String name;
  String subject;
  String classroom_code;
  bool archive;
  Map teacher;

  @JsonKey(name: "_created_date")
  String created_date;

  ClassroomItem({
    required this.id,
    required this.name,
    required this.subject,
    required this.classroom_code,
    required this.archive,
    required this.teacher,
    required this.created_date,
  });

  factory ClassroomItem.fromJson(Map<String, dynamic> json) =>
      _$ClassroomItemFromJson(json);

  Map<String, dynamic> toJson() => _$ClassroomItemToJson(this);
}

@JsonSerializable()
class ClassroomMemberList {
  List? student;
  List? teacher;

  ClassroomMemberList({
    required this.student,
    required this.teacher,
  });

  factory ClassroomMemberList.fromJson(Map<String, dynamic> json) =>
      _$ClassroomMemberListFromJson(json);

  Map<String, dynamic> toJson() => _$ClassroomMemberListToJson(this);
}
