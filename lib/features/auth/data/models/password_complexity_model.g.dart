// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_complexity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PasswordComplexityModel _$PasswordComplexityModelFromJson(
  Map<String, dynamic> json,
) => PasswordComplexityModel(
  requireDigit: json['requireDigit'] as bool? ?? false,
  requireLowercase: json['requireLowercase'] as bool? ?? false,
  requireUppercase: json['requireUppercase'] as bool? ?? false,
  requireNonAlphanumeric: json['requireNonAlphanumeric'] as bool? ?? false,
  requiredLength: (json['requiredLength'] as num?)?.toInt() ?? 7,
);

Map<String, dynamic> _$PasswordComplexityModelToJson(
  PasswordComplexityModel instance,
) => <String, dynamic>{
  'requireDigit': instance.requireDigit,
  'requireLowercase': instance.requireLowercase,
  'requireUppercase': instance.requireUppercase,
  'requireNonAlphanumeric': instance.requireNonAlphanumeric,
  'requiredLength': instance.requiredLength,
};
