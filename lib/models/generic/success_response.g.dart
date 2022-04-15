// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'success_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Success _$SuccessFromJson(Map<String, dynamic> json) => Success(
      status: json['status'] as int?,
      success: json['success'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$SuccessToJson(Success instance) => <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
    };
