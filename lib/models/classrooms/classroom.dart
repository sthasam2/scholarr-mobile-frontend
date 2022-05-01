// import 'package:json_annotation/json_annotation.dart';

// part 'classroom.g.dart';

// @JsonSerializable()
// class ClassroomCreate {
//   // String name;
//   // String faculty;
//   // String batch;
//   // String organisation;

//   // ClassroomCreate({
//   //   required this.name,
//   //   required this.faculty,
//   //   required this.batch,
//   //   required this.organisation,
//   // });

//   factory ClassroomCreate.fromJson(Map<String, dynamic> json) =>
//       _$ClassroomCreateFromJson(json);

//   Map<String, dynamic> toJson() => _$ClassroomCreateToJson(this);
// }

// @JsonSerializable()
// class ClassroomItem {
//   // int id;
//   // bool active;
//   // String name;
//   // String faculty;
//   // String batch;
//   // String organisation;

//   // @JsonKey(name: "_created_date")
//   // String created_date;

//   // ClassroomItem({
//   //   required this.id,
//   //   required this.created_date,
//   //   required this.active,
//   //   required this.name,
//   //   required this.faculty,
//   //   required this.batch,
//   //   required this.organisation,
//   // });

//   factory ClassroomItem.fromJson(Map<String, dynamic> json) =>
//       _$ClassroomItemFromJson(json);

//   Map<String, dynamic> toJson() => _$ClassroomItemToJson(this);
// }

// @JsonSerializable()
// class ClassroomItemList {
//   // List student_classrooms;
//   // List created_classrooms;

//   // ClassroomItemList({
//   //   required this.student_classrooms,
//   //   required this.created_classrooms,
//   //   // required this.count,
//   // });

//   factory ClassroomItemList.fromJson(Map<String, dynamic> json) =>
//       _$ClassroomItemListFromJson(json);

//   Map<String, dynamic> toJson() => _$ClassroomItemListToJson(this);
// }

// @JsonSerializable()
// class ClassroomItemDetail {
//   // int id;
//   // bool active;
//   // String classroom_code;
//   // String name;
//   // String faculty;
//   // String batch;
//   // String organisation;

//   // @JsonKey(name: "_created_date")
//   // String created_date;

//   // @JsonKey(name: "_modified_date")
//   // String modified_date;

//   // @JsonKey(name: "_created_by")
//   // Map<String, dynamic> created_by;

//   // ClassroomItemDetail({
//   //   required this.id,
//   //   required this.created_by,
//   //   required this.created_date,
//   //   required this.modified_date,
//   //   required this.classroom_code,
//   //   required this.active,
//   //   required this.name,
//   //   required this.faculty,
//   //   required this.batch,
//   //   required this.organisation,
//   // });

//   factory ClassroomItemDetail.fromJson(Map<String, dynamic> json) =>
//       _$ClassroomItemDetailFromJson(json);

//   Map<String, dynamic> toJson() => _$ClassroomItemDetailToJson(this);
// }

// @JsonSerializable()
// class ClassroomMemberList {
//   // List? members;

//   // ClassroomMemberList({
//   //   required this.members,
//   // });

//   factory ClassroomMemberList.fromJson(Map<String, dynamic> json) =>
//       _$ClassroomMemberListFromJson(json);

//   Map<String, dynamic> toJson() => _$ClassroomMemberListToJson(this);
// }
