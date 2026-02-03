import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/edition_entity.dart';

part 'edition_model.g.dart';

@JsonSerializable()
class EditionModel extends EditionEntity {
  const EditionModel({
    required super.id,
    required super.displayName,
    required super.isRegistrable,
    super.annualPrice,
    super.monthlyPrice,
    required super.hasTrial,
    required super.isMostPopular,
    required super.features,
  });

  factory EditionModel.fromJson(Map<String, dynamic> json) =>
      _$EditionModelFromJson(json);

  Map<String, dynamic> toJson() => _$EditionModelToJson(this);
}

@JsonSerializable()
class FeatureModel extends FeatureEntity {
  const FeatureModel({
    required super.name,
    super.value,
  });

  factory FeatureModel.fromJson(Map<String, dynamic> json) =>
      _$FeatureModelFromJson(json);

  Map<String, dynamic> toJson() => _$FeatureModelToJson(this);
}
