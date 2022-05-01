import 'package:json_annotation/json_annotation.dart';

part 'classgroup.g.dart';

@JsonSerializable()
class ClassgroupCreate {
  String name;
  String faculty;
  String batch;
  String organisation;

  ClassgroupCreate({
    required this.name,
    required this.faculty,
    required this.batch,
    required this.organisation,
  });

  factory ClassgroupCreate.fromJson(Map<String, dynamic> json) =>
      _$ClassgroupCreateFromJson(json);

  Map<String, dynamic> toJson() => _$ClassgroupCreateToJson(this);
}

@JsonSerializable()
class ClassGroupItem {
  int id;
  bool active;
  String name;
  String faculty;
  String batch;
  String organisation;

  @JsonKey(name: "_created_date")
  String created_date;

  ClassGroupItem({
    required this.id,
    required this.created_date,
    required this.active,
    required this.name,
    required this.faculty,
    required this.batch,
    required this.organisation,
  });

  factory ClassGroupItem.fromJson(Map<String, dynamic> json) =>
      _$ClassGroupItemFromJson(json);

  Map<String, dynamic> toJson() => _$ClassGroupItemToJson(this);
}

@JsonSerializable()
class ClassGroupItemList {
  // int count;
  List student_classgroups;
  List created_classgroups;

  ClassGroupItemList({
    required this.student_classgroups,
    required this.created_classgroups,
    // required this.count,
  });

  factory ClassGroupItemList.fromJson(Map<String, dynamic> json) =>
      _$ClassGroupItemListFromJson(json);

  Map<String, dynamic> toJson() => _$ClassGroupItemListToJson(this);
}

@JsonSerializable()
class ClassGroupItemDetail {
  int id;
  bool active;
  String classgroup_code;
  String name;
  String faculty;
  String batch;
  String organisation;

  @JsonKey(name: "_created_date")
  String created_date;

  @JsonKey(name: "_modified_date")
  String modified_date;

  @JsonKey(name: "_created_by")
  Map<String, dynamic> created_by;

  ClassGroupItemDetail({
    required this.id,
    required this.created_by,
    required this.created_date,
    required this.modified_date,
    required this.classgroup_code,
    required this.active,
    required this.name,
    required this.faculty,
    required this.batch,
    required this.organisation,
  });

  factory ClassGroupItemDetail.fromJson(Map<String, dynamic> json) =>
      _$ClassGroupItemDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ClassGroupItemDetailToJson(this);
}

@JsonSerializable()
class ClassGroupMemberList {
  List? members;

  ClassGroupMemberList({
    required this.members,
  });

  factory ClassGroupMemberList.fromJson(Map<String, dynamic> json) =>
      _$ClassGroupMemberListFromJson(json);

  Map<String, dynamic> toJson() => _$ClassGroupMemberListToJson(this);
}
