// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classroom.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassroomCreate _$ClassroomCreateFromJson(Map<String, dynamic> json) =>
    ClassroomCreate(
      name: json['name'] as String,
      subject: json['subject'] as String,
    );

Map<String, dynamic> _$ClassroomCreateToJson(ClassroomCreate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'subject': instance.subject,
    };

ClassroomItemDetail _$ClassroomItemDetailFromJson(Map<String, dynamic> json) =>
    ClassroomItemDetail(
      id: json['id'] as int,
      name: json['name'] as String,
      subject: json['subject'] as String,
      classroom_code: json['classroom_code'] as String,
      archive: json['archive'] as bool,
      teacher: json['teacher'] as Map<String, dynamic>,
      created_date: json['_created_date'] as String,
      modified_date: json['_modified_date'] as String?,
      created_by: json['_created_by'] as int?,
    );

Map<String, dynamic> _$ClassroomItemDetailToJson(
        ClassroomItemDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'subject': instance.subject,
      'classroom_code': instance.classroom_code,
      'archive': instance.archive,
      'teacher': instance.teacher,
      '_created_date': instance.created_date,
      '_modified_date': instance.modified_date,
      '_created_by': instance.created_by,
    };

ClassroomItemList _$ClassroomItemListFromJson(Map<String, dynamic> json) =>
    ClassroomItemList(
      studying_classrooms: json['studying_classrooms'] as List<dynamic>,
      teaching_classrooms: json['teaching_classrooms'] as List<dynamic>,
    );

Map<String, dynamic> _$ClassroomItemListToJson(ClassroomItemList instance) =>
    <String, dynamic>{
      'studying_classrooms': instance.studying_classrooms,
      'teaching_classrooms': instance.teaching_classrooms,
    };

ClassroomItem _$ClassroomItemFromJson(Map<String, dynamic> json) =>
    ClassroomItem(
      id: json['id'] as int,
      name: json['name'] as String,
      subject: json['subject'] as String,
      classroom_code: json['classroom_code'] as String,
      archive: json['archive'] as bool,
      teacher: json['teacher'] as Map<String, dynamic>,
      created_date: json['_created_date'] as String,
    );

Map<String, dynamic> _$ClassroomItemToJson(ClassroomItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'subject': instance.subject,
      'classroom_code': instance.classroom_code,
      'archive': instance.archive,
      'teacher': instance.teacher,
      '_created_date': instance.created_date,
    };

ClassroomMemberList _$ClassroomMemberListFromJson(Map<String, dynamic> json) =>
    ClassroomMemberList(
      student: json['student'] as List<dynamic>?,
      teacher: json['teacher'] as List<dynamic>?,
    );

Map<String, dynamic> _$ClassroomMemberListToJson(
        ClassroomMemberList instance) =>
    <String, dynamic>{
      'student': instance.student,
      'teacher': instance.teacher,
    };
