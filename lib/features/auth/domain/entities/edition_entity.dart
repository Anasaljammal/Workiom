import 'package:equatable/equatable.dart';

class EditionEntity extends Equatable {
  final int id;
  final String displayName;
  final bool isRegistrable;
  final double? annualPrice;
  final double? monthlyPrice;
  final bool hasTrial;
  final bool isMostPopular;
  final List<FeatureEntity> features;

  const EditionEntity({
    required this.id,
    required this.displayName,
    required this.isRegistrable,
    this.annualPrice,
    this.monthlyPrice,
    required this.hasTrial,
    required this.isMostPopular,
    required this.features,
  });

  @override
  List<Object?> get props => [
        id,
        displayName,
        isRegistrable,
        annualPrice,
        monthlyPrice,
        hasTrial,
        isMostPopular,
        features,
      ];
}

class FeatureEntity extends Equatable {
  final String name;
  final String? value;

  const FeatureEntity({
    required this.name,
    this.value,
  });

  @override
  List<Object?> get props => [name, value];
}
