import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class RegisterTenant implements UseCase<void, RegisterTenantParams> {
  final AuthRepository repository;

  RegisterTenant(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterTenantParams params) async {
    return await repository.registerTenant(
      email: params.email,
      firstName: params.firstName,
      lastName: params.lastName,
      password: params.password,
      tenantName: params.tenantName,
      editionId: params.editionId,
      timezone: params.timezone,
    );
  }
}

class RegisterTenantParams extends Equatable {
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final String tenantName;
  final int editionId;
  final String timezone;

  const RegisterTenantParams({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.tenantName,
    required this.editionId,
    required this.timezone,
  });

  @override
  List<Object?> get props => [
        email,
        firstName,
        lastName,
        password,
        tenantName,
        editionId,
        timezone,
      ];
}
