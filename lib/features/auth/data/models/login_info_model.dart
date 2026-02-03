import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/login_info_entity.dart';
import 'user_model.dart';
import 'tenant_model.dart';

part 'login_info_model.g.dart';

@JsonSerializable()
class LoginInfoModel extends LoginInfoEntity {
  const LoginInfoModel({
    super.user,
    super.tenant,
  });

  factory LoginInfoModel.fromJson(Map<String, dynamic> json) =>
      _$LoginInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginInfoModelToJson(this);
}
