import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/password_complexity_entity.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class GetPasswordComplexity implements UseCase<PasswordComplexityEntity, NoParams> {
  final AuthRepository repository;

  GetPasswordComplexity(this.repository);

  @override
  Future<Either<Failure, PasswordComplexityEntity>> call(NoParams params) async {
    return await repository.getPasswordComplexity();
  }
}
