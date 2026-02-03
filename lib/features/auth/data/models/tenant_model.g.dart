// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TenantModel _$TenantModelFromJson(Map<String, dynamic> json) => TenantModel(
  id: ((json['id'] ?? json['Id']) as num?)?.toInt() ?? 0,
  tenancyName: (json['tenancyName'] ?? json['TenancyName']) as String? ?? '',
  name: (json['name'] ?? json['Name']) as String? ?? '',
  isActive: (json['isActive'] ?? json['IsActive']) as bool? ?? true,
);

Map<String, dynamic> _$TenantModelToJson(TenantModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tenancyName': instance.tenancyName,
      'name': instance.name,
      'isActive': instance.isActive,
    };
