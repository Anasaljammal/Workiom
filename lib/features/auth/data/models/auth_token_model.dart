import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/auth_token_entity.dart';

part 'auth_token_model.g.dart';

@JsonSerializable()
class AuthTokenModel extends AuthTokenEntity {
  const AuthTokenModel({
    required super.accessToken,
    required super.encryptedAccessToken,
    required super.expireInSeconds,
  });

  factory AuthTokenModel.fromJson(Map<String, dynamic> json) =>
      _$AuthTokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthTokenModelToJson(this);
}
