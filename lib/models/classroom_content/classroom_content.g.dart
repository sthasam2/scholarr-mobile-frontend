// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classroom_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassworkCreate _$ClassworkCreateFromJson(Map<String, dynamic> json) =>
    ClassworkCreate(
      title: json['title'] as String,
      description: json['description'] as String,
      content_type: json['content_type'] as String,
      deadline: json['deadline'] as String?,
      weightage: json['weightage'] as int,
    );

Map<String, dynamic> _$ClassworkCreateToJson(ClassworkCreate instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'content_type': instance.content_type,
      'deadline': instance.deadline,
      'weightage': instance.weightage,
    };

ResourceCreate _$ResourceCreateFromJson(Map<String, dynamic> json) =>
    ResourceCreate(
      title: json['title'] as String,
      description: json['description'] as String,
      content_type: json['content_type'] as String,
    );

Map<String, dynamic> _$ResourceCreateToJson(ResourceCreate instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'content_type': instance.content_type,
    };

SubmissionCreate _$SubmissionCreateFromJson(Map<String, dynamic> json) =>
    SubmissionCreate(
      answer: json['answer'] as String,
    );

Map<String, dynamic> _$SubmissionCreateToJson(SubmissionCreate instance) =>
    <String, dynamic>{
      'answer': instance.answer,
    };

ClassroomContentList _$ClassroomContentListFromJson(
        Map<String, dynamic> json) =>
    ClassroomContentList(
      classworks: json['classworks'] as List<dynamic>?,
      resources: json['resources'] as List<dynamic>?,
    );

Map<String, dynamic> _$ClassroomContentListToJson(
        ClassroomContentList instance) =>
    <String, dynamic>{
      'classworks': instance.classworks,
      'resources': instance.resources,
    };

ClassworkSubmissionList _$ClassworkSubmissionListFromJson(
        Map<String, dynamic> json) =>
    ClassworkSubmissionList(
      classwork: json['classwork'] as Map<String, dynamic>?,
      submissions: json['submissions'] as List<dynamic>?,
    );

Map<String, dynamic> _$ClassworkSubmissionListToJson(
        ClassworkSubmissionList instance) =>
    <String, dynamic>{
      'classwork': instance.classwork,
      'submissions': instance.submissions,
    };

ClassroomContentListItem _$ClassroomContentListItemFromJson(
        Map<String, dynamic> json) =>
    ClassroomContentListItem(
      id: json['id'] as int?,
      created_date: json['_created_date'] as String?,
      modified_date: json['_modified_date'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      modified: json['modified'] as bool?,
      content_type: json['content_type'] as String?,
      weightage: json['weightage'] as int?,
      deadline: json['deadline'] as String?,
      attachments: json['attachments'] as bool?,
      created_by: json['_created_by'] as int?,
    );

Map<String, dynamic> _$ClassroomContentListItemToJson(
        ClassroomContentListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      '_created_date': instance.created_date,
      '_modified_date': instance.modified_date,
      'title': instance.title,
      'description': instance.description,
      'modified': instance.modified,
      'content_type': instance.content_type,
      'weightage': instance.weightage,
      'deadline': instance.deadline,
      'attachments': instance.attachments,
      '_created_by': instance.created_by,
    };

SubmissionListItem _$SubmissionListItemFromJson(Map<String, dynamic> json) =>
    SubmissionListItem(
      id: json['id'] as int?,
      created_date: json['_created_date'] as String?,
      modified_date: json['_modified_date'] as String?,
      answer: json['answer'] as String?,
      grade: json['grade'] as int?,
      modified: json['modified'] as bool?,
      graded: json['graded'] as bool?,
      attachments: json['attachments'] as bool?,
      created_by: json['_created_by'] as Map<String, dynamic>?,
    )..remarks = json['remarks'] as String?;

Map<String, dynamic> _$SubmissionListItemToJson(SubmissionListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      '_created_date': instance.created_date,
      '_modified_date': instance.modified_date,
      'answer': instance.answer,
      'grade': instance.grade,
      'remarks': instance.remarks,
      'modified': instance.modified,
      'graded': instance.graded,
      'attachments': instance.attachments,
      '_created_by': instance.created_by,
    };

ClassworkItemDetail _$ClassworkItemDetailFromJson(Map<String, dynamic> json) =>
    ClassworkItemDetail(
      classwork: json['classwork'] as Map<String, dynamic>,
      attachments: json['attachments'] as List<dynamic>?,
    );

Map<String, dynamic> _$ClassworkItemDetailToJson(
        ClassworkItemDetail instance) =>
    <String, dynamic>{
      'classwork': instance.classwork,
      'attachments': instance.attachments,
    };

ResourceItemDetail _$ResourceItemDetailFromJson(Map<String, dynamic> json) =>
    ResourceItemDetail(
      resource: json['resource'] as Map<String, dynamic>,
      attachments: json['attachments'] as List<dynamic>?,
    );

Map<String, dynamic> _$ResourceItemDetailToJson(ResourceItemDetail instance) =>
    <String, dynamic>{
      'resource': instance.resource,
      'attachments': instance.attachments,
    };

SubmissionItemDetail _$SubmissionItemDetailFromJson(
        Map<String, dynamic> json) =>
    SubmissionItemDetail(
      submission: json['submission'] as Map<String, dynamic>,
      attachments: json['attachments'] as List<dynamic>?,
    );

Map<String, dynamic> _$SubmissionItemDetailToJson(
        SubmissionItemDetail instance) =>
    <String, dynamic>{
      'submission': instance.submission,
      'attachments': instance.attachments,
    };

PlagiarismList _$PlagiarismListFromJson(Map<String, dynamic> json) =>
    PlagiarismList(
      plagiarism: json['plagiarism'] as List<dynamic>?,
    );

Map<String, dynamic> _$PlagiarismListToJson(PlagiarismList instance) =>
    <String, dynamic>{
      'plagiarism': instance.plagiarism,
    };

AttachmentItemDetail _$AttachmentItemDetailFromJson(
        Map<String, dynamic> json) =>
    AttachmentItemDetail(
      attachments: json['attachments'] as List<dynamic>?,
    );

Map<String, dynamic> _$AttachmentItemDetailToJson(
        AttachmentItemDetail instance) =>
    <String, dynamic>{
      'attachments': instance.attachments,
    };

AttachmentItem _$AttachmentItemFromJson(Map<String, dynamic> json) =>
    AttachmentItem(
      attachment: json['attachment'] as String,
      mime_type: json['mime_type'] as String,
    );

Map<String, dynamic> _$AttachmentItemToJson(AttachmentItem instance) =>
    <String, dynamic>{
      'attachment': instance.attachment,
      'mime_type': instance.mime_type,
    };
