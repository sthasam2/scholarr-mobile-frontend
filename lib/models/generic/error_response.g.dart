// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Error _$ErrorFromJson(Map<String, dynamic> json) => Error(
      status: json['status'] as int?,
      error: json['error'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ErrorToJson(Error instance) => <String, dynamic>{
      'status': instance.status,
      'error': instance.error,
    };
