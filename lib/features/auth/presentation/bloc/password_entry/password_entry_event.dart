import 'package:equatable/equatable.dart';

abstract class PasswordEntryEvent extends Equatable {
  const PasswordEntryEvent();

  @override
  List<Object?> get props => [];
}

class EmailChangedEvent extends PasswordEntryEvent {
  final String email;

  const EmailChangedEvent(this.email);

  @override
  List<Object?> get props => [email];
}

class PasswordChangedEvent extends PasswordEntryEvent {
  final String password;

  const PasswordChangedEvent(this.password);

  @override
  List<Object?> get props => [password];
}

class TogglePasswordVisibilityEvent extends PasswordEntryEvent {
  const TogglePasswordVisibilityEvent();
}

class ClearEmailEvent extends PasswordEntryEvent {
  const ClearEmailEvent();
}

class SubmitPasswordEvent extends PasswordEntryEvent {
  const SubmitPasswordEvent();
}

class ResetSubmissionEvent extends PasswordEntryEvent {
  const ResetSubmissionEvent();
}

class SetPasswordComplexityEvent extends PasswordEntryEvent {
  final int requiredLength;
  final bool requireDigit;
  final bool requireLowercase;
  final bool requireUppercase;
  final bool requireNonAlphanumeric;

  const SetPasswordComplexityEvent({
    required this.requiredLength,
    required this.requireDigit,
    required this.requireLowercase,
    required this.requireUppercase,
    required this.requireNonAlphanumeric,
  });

  @override
  List<Object?> get props => [
    requiredLength,
    requireDigit,
    requireLowercase,
    requireUppercase,
    requireNonAlphanumeric,
  ];
}
