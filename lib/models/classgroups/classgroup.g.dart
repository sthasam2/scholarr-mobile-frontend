// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classgroup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassgroupCreate _$ClassgroupCreateFromJson(Map<String, dynamic> json) =>
    ClassgroupCreate(
      name: json['name'] as String,
      faculty: json['faculty'] as String,
      batch: json['batch'] as String,
      organisation: json['organisation'] as String,
    );

Map<String, dynamic> _$ClassgroupCreateToJson(ClassgroupCreate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'faculty': instance.faculty,
      'batch': instance.batch,
      'organisation': instance.organisation,
    };

ClassGroupItem _$ClassGroupItemFromJson(Map<String, dynamic> json) =>
    ClassGroupItem(
      id: json['id'] as int,
      created_date: json['_created_date'] as String,
      active: json['active'] as bool,
      name: json['name'] as String,
      faculty: json['faculty'] as String,
      batch: json['batch'] as String,
      organisation: json['organisation'] as String,
    );

Map<String, dynamic> _$ClassGroupItemToJson(ClassGroupItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'active': instance.active,
      'name': instance.name,
      'faculty': instance.faculty,
      'batch': instance.batch,
      'organisation': instance.organisation,
      '_created_date': instance.created_date,
    };

ClassGroupItemList _$ClassGroupItemListFromJson(Map<String, dynamic> json) =>
    ClassGroupItemList(
      student_classgroups: json['student_classgroups'] as List<dynamic>,
      created_classgroups: json['created_classgroups'] as List<dynamic>,
    );

Map<String, dynamic> _$ClassGroupItemListToJson(ClassGroupItemList instance) =>
    <String, dynamic>{
      'student_classgroups': instance.student_classgroups,
      'created_classgroups': instance.created_classgroups,
    };

ClassGroupItemDetail _$ClassGroupItemDetailFromJson(
        Map<String, dynamic> json) =>
    ClassGroupItemDetail(
      id: json['id'] as int,
      created_by: json['_created_by'] as Map<String, dynamic>,
      created_date: json['_created_date'] as String,
      modified_date: json['_modified_date'] as String,
      classgroup_code: json['classgroup_code'] as String,
      active: json['active'] as bool,
      name: json['name'] as String,
      faculty: json['faculty'] as String,
      batch: json['batch'] as String,
      organisation: json['organisation'] as String,
    );

Map<String, dynamic> _$ClassGroupItemDetailToJson(
        ClassGroupItemDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'active': instance.active,
      'classgroup_code': instance.classgroup_code,
      'name': instance.name,
      'faculty': instance.faculty,
      'batch': instance.batch,
      'organisation': instance.organisation,
      '_created_date': instance.created_date,
      '_modified_date': instance.modified_date,
      '_created_by': instance.created_by,
    };

ClassGroupMemberList _$ClassGroupMemberListFromJson(
        Map<String, dynamic> json) =>
    ClassGroupMemberList(
      members: json['members'] as List<dynamic>?,
    );

Map<String, dynamic> _$ClassGroupMemberListToJson(
        ClassGroupMemberList instance) =>
    <String, dynamic>{
      'members': instance.members,
    };
