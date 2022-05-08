import 'package:json_annotation/json_annotation.dart';

part 'classroom_content.g.dart';

@JsonSerializable()
class ClassworkCreate {
  String title;
  String description;
  String content_type;
  String? deadline;
  int weightage;

  ClassworkCreate({
    required this.title,
    required this.description,
    required this.content_type,
    required this.deadline,
    required this.weightage,
  });

  factory ClassworkCreate.fromJson(Map<String, dynamic> json) =>
      _$ClassworkCreateFromJson(json);

  Map<String, dynamic> toJson() => _$ClassworkCreateToJson(this);
}

@JsonSerializable()
class ResourceCreate {
  String title;
  String description;
  String content_type;

  ResourceCreate({
    required this.title,
    required this.description,
    required this.content_type,
  });

  factory ResourceCreate.fromJson(Map<String, dynamic> json) =>
      _$ResourceCreateFromJson(json);

  Map<String, dynamic> toJson() => _$ResourceCreateToJson(this);
}

@JsonSerializable()
class SubmissionCreate {
  String answer;

  SubmissionCreate({
    required this.answer,
  });

  factory SubmissionCreate.fromJson(Map<String, dynamic> json) =>
      _$SubmissionCreateFromJson(json);

  Map<String, dynamic> toJson() => _$SubmissionCreateToJson(this);
}

@JsonSerializable()
class ClassroomContentList {
  List? classworks;
  List? resources;

  ClassroomContentList({
    required this.classworks,
    required this.resources,
  });

  factory ClassroomContentList.fromJson(Map<String, dynamic> json) =>
      _$ClassroomContentListFromJson(json);

  Map<String, dynamic> toJson() => _$ClassroomContentListToJson(this);
}

@JsonSerializable()
class ClassworkSubmissionList {
  Map<String, dynamic>? classwork;
  List? submissions;

  ClassworkSubmissionList({
    required this.classwork,
    required this.submissions,
  });

  factory ClassworkSubmissionList.fromJson(Map<String, dynamic> json) =>
      _$ClassworkSubmissionListFromJson(json);

  Map<String, dynamic> toJson() => _$ClassworkSubmissionListToJson(this);
}

@JsonSerializable()
class ClassroomContentListItem {
  int? id;

  @JsonKey(name: "_created_date")
  String? created_date;

  @JsonKey(name: "_modified_date")
  String? modified_date;

  String? title;
  String? description;
  bool? modified;
  String? content_type;
  int? weightage;
  String? deadline;
  bool? attachments;

  @JsonKey(name: "_created_by")
  int? created_by;

  ClassroomContentListItem(
      {required this.id,
      required this.created_date,
      required this.modified_date,
      required this.title,
      required this.description,
      required this.modified,
      required this.content_type,
      required this.weightage,
      required this.deadline,
      required this.attachments,
      required this.created_by});

  factory ClassroomContentListItem.fromJson(Map<String, dynamic> json) =>
      _$ClassroomContentListItemFromJson(json);

  Map<String, dynamic> toJson() => _$ClassroomContentListItemToJson(this);
}

@JsonSerializable()
class SubmissionListItem {
  int? id;

  @JsonKey(name: "_created_date")
  String? created_date;

  @JsonKey(name: "_modified_date")
  String? modified_date;

  String? answer;
  int? grade;
  String? remarks;
  bool? modified;
  bool? graded;
  bool? attachments;

  @JsonKey(name: "_created_by")
  Map? created_by;

  SubmissionListItem(
      {required this.id,
      required this.created_date,
      required this.modified_date,
      required this.answer,
      required this.grade,
      required this.modified,
      required this.graded,
      required this.attachments,
      required this.created_by});

  factory SubmissionListItem.fromJson(Map<String, dynamic> json) =>
      _$SubmissionListItemFromJson(json);

  Map<String, dynamic> toJson() => _$SubmissionListItemToJson(this);
}

@JsonSerializable()
class ClassworkItemDetail {
  Map<String, dynamic> classwork;
  List? attachments;

  ClassworkItemDetail({
    required this.classwork,
    required this.attachments,
  });

  factory ClassworkItemDetail.fromJson(Map<String, dynamic> json) =>
      _$ClassworkItemDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ClassworkItemDetailToJson(this);
}

@JsonSerializable()
class ResourceItemDetail {
  Map<String, dynamic> resource;
  List? attachments;

  ResourceItemDetail({
    required this.resource,
    required this.attachments,
  });

  factory ResourceItemDetail.fromJson(Map<String, dynamic> json) =>
      _$ResourceItemDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ResourceItemDetailToJson(this);
}

@JsonSerializable()
class SubmissionItemDetail {
  Map<String, dynamic> submission;
  List? attachments;

  SubmissionItemDetail({
    required this.submission,
    required this.attachments,
  });

  factory SubmissionItemDetail.fromJson(Map<String, dynamic> json) =>
      _$SubmissionItemDetailFromJson(json);

  Map<String, dynamic> toJson() => _$SubmissionItemDetailToJson(this);
}

@JsonSerializable()
class PlagiarismList {
  List? plagiarism;

  PlagiarismList({
    required this.plagiarism,
  });

  factory PlagiarismList.fromJson(Map<String, dynamic> json) =>
      _$PlagiarismListFromJson(json);

  Map<String, dynamic> toJson() => _$PlagiarismListToJson(this);
}

@JsonSerializable()
class AttachmentItemDetail {
  List? attachments;

  AttachmentItemDetail({
    required this.attachments,
  });

  factory AttachmentItemDetail.fromJson(Map<String, dynamic> json) =>
      _$AttachmentItemDetailFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentItemDetailToJson(this);
}

@JsonSerializable()
class AttachmentItem {
  String attachment;
  String mime_type;

  AttachmentItem({
    required this.attachment,
    required this.mime_type,
  });

  factory AttachmentItem.fromJson(Map<String, dynamic> json) =>
      _$AttachmentItemFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentItemToJson(this);
}
