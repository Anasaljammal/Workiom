import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/password_complexity_entity.dart';

part 'password_complexity_model.g.dart';

@JsonSerializable()
class PasswordComplexityModel extends PasswordComplexityEntity {
  const PasswordComplexityModel({
    @JsonKey(defaultValue: false) required super.requireDigit,
    @JsonKey(defaultValue: false) required super.requireLowercase,
    @JsonKey(defaultValue: false) required super.requireUppercase,
    @JsonKey(defaultValue: false) required super.requireNonAlphanumeric,
    @JsonKey(defaultValue: 7) required super.requiredLength,
  });

  factory PasswordComplexityModel.fromJson(Map<String, dynamic> json) =>
      _$PasswordComplexityModelFromJson(json);

  Map<String, dynamic> toJson() => _$PasswordComplexityModelToJson(this);
}
