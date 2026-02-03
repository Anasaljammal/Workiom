import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class CheckAuthStatusEvent extends AuthEvent {
  const CheckAuthStatusEvent();
}

class GetEditionsEvent extends AuthEvent {
  const GetEditionsEvent();
}

class GetPasswordComplexityEvent extends AuthEvent {
  const GetPasswordComplexityEvent();
}

class CheckTenantAvailabilityEvent extends AuthEvent {
  final String tenantName;

  const CheckTenantAvailabilityEvent(this.tenantName);

  @override
  List<Object?> get props => [tenantName];
}

class RegisterTenantEvent extends AuthEvent {
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final String tenantName;
  final int editionId;

  const RegisterTenantEvent({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.tenantName,
    required this.editionId,
  });

  @override
  List<Object?> get props => [
        email,
        firstName,
        lastName,
        password,
        tenantName,
        editionId,
      ];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  final String tenantName;

  const LoginEvent({
    required this.email,
    required this.password,
    required this.tenantName,
  });

  @override
  List<Object?> get props => [email, password, tenantName];
}

class LogoutEvent extends AuthEvent {
  const LogoutEvent();
}
