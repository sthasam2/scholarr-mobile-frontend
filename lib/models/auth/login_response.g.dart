// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginSuccess _$LoginSuccessFromJson(Map<String, dynamic> json) => LoginSuccess(
      status: json['status'] as int?,
      refresh: json['refresh'] as String?,
      access: json['access'] as String?,
      user_details: json['user_details'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$LoginSuccessToJson(LoginSuccess instance) =>
    <String, dynamic>{
      'status': instance.status,
      'refresh': instance.refresh,
      'access': instance.access,
      'user_details': instance.user_details,
    };

LoginRefreshSuccess _$LoginRefreshSuccessFromJson(Map<String, dynamic> json) =>
    LoginRefreshSuccess(
      access: json['access'] as String?,
    )..user_details = json['user_details'] as Map<String, dynamic>?;

Map<String, dynamic> _$LoginRefreshSuccessToJson(
        LoginRefreshSuccess instance) =>
    <String, dynamic>{
      'access': instance.access,
      'user_details': instance.user_details,
    };
