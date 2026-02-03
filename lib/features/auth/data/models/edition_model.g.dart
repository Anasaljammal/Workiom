// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edition_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

int _editionIdFromJson(Map<String, dynamic> json) {
  final id = json['id'] ?? json['Id'];
  if (id != null) return (id as num).toInt();
  final value = json['value'] ?? json['Value'];
  if (value != null) return (value as num).toInt();
  return 0;
}

EditionModel _$EditionModelFromJson(Map<String, dynamic> json) => EditionModel(
  id: _editionIdFromJson(json),
  displayName:
      (json['displayName'] ??
              json['DisplayName'] ??
              json['displayText'] ??
              json['DisplayText'])
          as String? ??
      '',
  isRegistrable:
      (json['isRegistrable'] ?? json['IsRegistrable']) as bool? ?? false,
  annualPrice: (json['annualPrice'] ?? json['AnnualPrice']) != null
      ? ((json['annualPrice'] ?? json['AnnualPrice']) as num).toDouble()
      : null,
  monthlyPrice: (json['monthlyPrice'] ?? json['MonthlyPrice']) != null
      ? ((json['monthlyPrice'] ?? json['MonthlyPrice']) as num).toDouble()
      : null,
  hasTrial: (json['hasTrial'] ?? json['HasTrial']) as bool? ?? false,
  isMostPopular:
      (json['isMostPopular'] ?? json['IsMostPopular']) as bool? ?? false,
  features:
      (json['features'] as List<dynamic>? ?? json['Features'] as List<dynamic>?)
          ?.map((e) => FeatureModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$EditionModelToJson(EditionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'isRegistrable': instance.isRegistrable,
      'annualPrice': instance.annualPrice,
      'monthlyPrice': instance.monthlyPrice,
      'hasTrial': instance.hasTrial,
      'isMostPopular': instance.isMostPopular,
      'features': instance.features,
    };

FeatureModel _$FeatureModelFromJson(Map<String, dynamic> json) => FeatureModel(
  name: json['name'] as String? ?? '',
  value: json['value'] as String?,
);

Map<String, dynamic> _$FeatureModelToJson(FeatureModel instance) =>
    <String, dynamic>{'name': instance.name, 'value': instance.value};
