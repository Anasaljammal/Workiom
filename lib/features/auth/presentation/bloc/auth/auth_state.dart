import 'package:equatable/equatable.dart';
import '../../../domain/entities/edition_entity.dart';
import '../../../domain/entities/login_info_entity.dart';
import '../../../domain/entities/password_complexity_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthAuthenticated extends AuthState {
  final LoginInfoEntity loginInfo;

  const AuthAuthenticated(this.loginInfo);

  @override
  List<Object?> get props => [loginInfo];
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class EditionsLoaded extends AuthState {
  final List<EditionEntity> editions;

  const EditionsLoaded(this.editions);

  @override
  List<Object?> get props => [editions];
}

class PasswordComplexityLoaded extends AuthState {
  final PasswordComplexityEntity passwordComplexity;

  const PasswordComplexityLoaded(this.passwordComplexity);

  @override
  List<Object?> get props => [passwordComplexity];
}

class TenantAvailabilityChecked extends AuthState {
  final bool isAvailable;

  const TenantAvailabilityChecked(this.isAvailable);

  @override
  List<Object?> get props => [isAvailable];
}

class TenantRegistrationSuccess extends AuthState {
  const TenantRegistrationSuccess();
}

class LoginSuccess extends AuthState {
  final LoginInfoEntity loginInfo;

  const LoginSuccess(this.loginInfo);

  @override
  List<Object?> get props => [loginInfo];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
