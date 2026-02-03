import 'package:equatable/equatable.dart';

class TenantEntity extends Equatable {
  final int id;
  final String tenancyName;
  final String name;
  final bool isActive;

  const TenantEntity({
    required this.id,
    required this.tenancyName,
    required this.name,
    required this.isActive,
  });

  @override
  List<Object?> get props => [id, tenancyName, name, isActive];
}
