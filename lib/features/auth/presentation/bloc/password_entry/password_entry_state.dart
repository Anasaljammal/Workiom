import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/theme/app_colors.dart';

class PasswordEntryState extends Equatable {
  final String email;
  final String password;
  final bool isPasswordVisible;
  final bool isEmailValid;
  final double passwordStrength;
  final bool hasMinLength;
  final bool hasDigit;
  final bool hasLowercase;
  final bool hasUppercase;
  final bool hasSpecial;
  final int requiredLength;
  final bool requireDigitRule;
  final bool requireLowercaseRule;
  final bool requireUppercaseRule;
  final bool requireSpecialRule;
  final bool isSubmitting;

  const PasswordEntryState({
    this.email = '',
    this.password = '',
    this.isPasswordVisible = false,
    this.isEmailValid = false,
    this.passwordStrength = 0.0,
    this.hasMinLength = false,
    this.hasDigit = false,
    this.hasLowercase = false,
    this.hasUppercase = false,
    this.hasSpecial = false,
    this.requiredLength = 7,
    this.requireDigitRule = true,
    this.requireLowercaseRule = true,
    this.requireUppercaseRule = true,
    this.requireSpecialRule = false,
    this.isSubmitting = false,
  });

  bool get isValid =>
      isEmailValid &&
      hasMinLength &&
      (!requireDigitRule || hasDigit) &&
      (!requireLowercaseRule || hasLowercase) &&
      (!requireUppercaseRule || hasUppercase) &&
      (!requireSpecialRule || hasSpecial);

  bool get showEmailClear => email.isNotEmpty;

  bool get showPasswordValidation => password.isNotEmpty;

  Color get strengthColor {
    if (passwordStrength >= 1.0) return AppColors.success;
    return AppColors.warning;
  }

  PasswordEntryState copyWith({
    String? email,
    String? password,
    bool? isPasswordVisible,
    bool? isEmailValid,
    double? passwordStrength,
    bool? hasMinLength,
    bool? hasDigit,
    bool? hasLowercase,
    bool? hasUppercase,
    bool? hasSpecial,
    int? requiredLength,
    bool? requireDigitRule,
    bool? requireLowercaseRule,
    bool? requireUppercaseRule,
    bool? requireSpecialRule,
    bool? isSubmitting,
  }) {
    return PasswordEntryState(
      email: email ?? this.email,
      password: password ?? this.password,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      passwordStrength: passwordStrength ?? this.passwordStrength,
      hasMinLength: hasMinLength ?? this.hasMinLength,
      hasDigit: hasDigit ?? this.hasDigit,
      hasLowercase: hasLowercase ?? this.hasLowercase,
      hasUppercase: hasUppercase ?? this.hasUppercase,
      hasSpecial: hasSpecial ?? this.hasSpecial,
      requiredLength: requiredLength ?? this.requiredLength,
      requireDigitRule: requireDigitRule ?? this.requireDigitRule,
      requireLowercaseRule: requireLowercaseRule ?? this.requireLowercaseRule,
      requireUppercaseRule: requireUppercaseRule ?? this.requireUppercaseRule,
      requireSpecialRule: requireSpecialRule ?? this.requireSpecialRule,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    isPasswordVisible,
    isEmailValid,
    passwordStrength,
    hasMinLength,
    hasDigit,
    hasLowercase,
    hasUppercase,
    hasSpecial,
    requiredLength,
    requireDigitRule,
    requireLowercaseRule,
    requireUppercaseRule,
    requireSpecialRule,
    isSubmitting,
  ];
}
