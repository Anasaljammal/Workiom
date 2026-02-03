import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class CheckTenantAvailability implements UseCase<bool, CheckTenantParams> {
  final AuthRepository repository;

  CheckTenantAvailability(this.repository);

  @override
  Future<Either<Failure, bool>> call(CheckTenantParams params) async {
    return await repository.checkTenantAvailability(params.tenantName);
  }
}

class CheckTenantParams extends Equatable {
  final String tenantName;

  const CheckTenantParams({required this.tenantName});

  @override
  List<Object?> get props => [tenantName];
}
