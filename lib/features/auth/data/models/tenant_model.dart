import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/tenant_entity.dart';

part 'tenant_model.g.dart';

@JsonSerializable()
class TenantModel extends TenantEntity {
  const TenantModel({
    required super.id,
    required super.tenancyName,
    required super.name,
    required super.isActive,
  });

  factory TenantModel.fromJson(Map<String, dynamic> json) =>
      _$TenantModelFromJson(json);

  Map<String, dynamic> toJson() => _$TenantModelToJson(this);
}
