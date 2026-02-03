// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginInfoModel _$LoginInfoModelFromJson(Map<String, dynamic> json) {
  final userJson = json['user'] ?? json['User'];
  final tenantJson = json['tenant'] ?? json['Tenant'];
  return LoginInfoModel(
    user: userJson == null
        ? null
        : UserModel.fromJson(userJson as Map<String, dynamic>),
    tenant: tenantJson == null
        ? null
        : TenantModel.fromJson(tenantJson as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LoginInfoModelToJson(LoginInfoModel instance) =>
    <String, dynamic>{'user': instance.user, 'tenant': instance.tenant};
