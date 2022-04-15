import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginSuccess {
  int? status;
  String? refresh;
  String? access;
  // ignore: non_constant_identifier_names
  Map<String, dynamic>? user_details;

  LoginSuccess({
    this.status,
    this.refresh,
    this.access,
    // ignore: non_constant_identifier_names
    this.user_details,
  });

  factory LoginSuccess.fromJson(Map<String, dynamic> json) =>
      _$LoginSuccessFromJson(json);

  Map<String, dynamic> toJson() => _$LoginSuccessToJson(this);
}

@JsonSerializable()
class LoginRefreshSuccess {
  String? access;
  // ignore: non_constant_identifier_names
  Map<String, dynamic>? user_details;

  LoginRefreshSuccess({
    this.access,
  });

  factory LoginRefreshSuccess.fromJson(Map<String, dynamic> json) =>
      _$LoginRefreshSuccessFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRefreshSuccessToJson(this);
}
