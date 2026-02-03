import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth_token_entity.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class AuthenticateUser implements UseCase<AuthTokenEntity, AuthenticateParams> {
  final AuthRepository repository;

  AuthenticateUser(this.repository);

  @override
  Future<Either<Failure, AuthTokenEntity>> call(AuthenticateParams params) async {
    return await repository.authenticate(
      email: params.email,
      password: params.password,
      tenantName: params.tenantName,
      timezone: params.timezone,
    );
  }
}

class AuthenticateParams extends Equatable {
  final String email;
  final String password;
  final String tenantName;
  final String timezone;

  const AuthenticateParams({
    required this.email,
    required this.password,
    required this.tenantName,
    required this.timezone,
  });

  @override
  List<Object?> get props => [email, password, tenantName, timezone];
}
