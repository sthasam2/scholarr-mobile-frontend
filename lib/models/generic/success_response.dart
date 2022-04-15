import 'package:json_annotation/json_annotation.dart';

part 'success_response.g.dart';

@JsonSerializable()
class Success {
  int? status;
  Map<String, dynamic>? success;

  Success({
    this.status,
    this.success,
  });

  factory Success.fromJson(Map<String, dynamic> json) =>
      _$SuccessFromJson(json);

  Map<String, dynamic> toJson() => _$SuccessToJson(this);
}
