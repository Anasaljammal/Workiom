// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: ((json['id'] ?? json['Id']) as num?)?.toInt() ?? 0,
  name: (json['name'] ?? json['Name']) as String? ?? '',
  surname: (json['surname'] ?? json['Surname']) as String? ?? '',
  userName: (json['userName'] ?? json['UserName']) as String? ?? '',
  emailAddress: (json['emailAddress'] ?? json['EmailAddress']) as String? ?? '',
  isActive: (json['isActive'] ?? json['IsActive']) as bool? ?? true,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'surname': instance.surname,
  'userName': instance.userName,
  'emailAddress': instance.emailAddress,
  'isActive': instance.isActive,
};
