import 'package:equatable/equatable.dart';

class CompanyInfoState extends Equatable {
  final String companyName;
  final String firstName;
  final String lastName;
  final bool isSubmitting;
  final String? errorMessage;
  final bool registrationSuccess;

  const CompanyInfoState({
    this.companyName = '',
    this.firstName = '',
    this.lastName = '',
    this.isSubmitting = false,
    this.errorMessage,
    this.registrationSuccess = false,
  });

  bool get isValid =>
      companyName.trim().isNotEmpty &&
      firstName.trim().isNotEmpty &&
      lastName.trim().isNotEmpty;

  CompanyInfoState copyWith({
    String? companyName,
    String? firstName,
    String? lastName,
    bool? isSubmitting,
    String? errorMessage,
    bool? registrationSuccess,
  }) {
    return CompanyInfoState(
      companyName: companyName ?? this.companyName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
      registrationSuccess: registrationSuccess ?? this.registrationSuccess,
    );
  }

  @override
  List<Object?> get props => [
    companyName,
    firstName,
    lastName,
    isSubmitting,
    errorMessage,
    registrationSuccess,
  ];
}
