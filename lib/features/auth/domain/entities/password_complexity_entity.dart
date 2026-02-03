import 'package:equatable/equatable.dart';

class PasswordComplexityEntity extends Equatable {
  final bool requireDigit;
  final bool requireLowercase;
  final bool requireUppercase;
  final bool requireNonAlphanumeric;
  final int requiredLength;

  const PasswordComplexityEntity({
    required this.requireDigit,
    required this.requireLowercase,
    required this.requireUppercase,
    required this.requireNonAlphanumeric,
    required this.requiredLength,
  });

  @override
  List<Object?> get props => [
        requireDigit,
        requireLowercase,
        requireUppercase,
        requireNonAlphanumeric,
        requiredLength,
      ];
}
