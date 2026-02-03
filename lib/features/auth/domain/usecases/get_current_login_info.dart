import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/login_info_entity.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class GetCurrentLoginInfo implements UseCase<LoginInfoEntity, NoParams> {
  final AuthRepository repository;

  GetCurrentLoginInfo(this.repository);

  @override
  Future<Either<Failure, LoginInfoEntity>> call(NoParams params) async {
    return await repository.getCurrentLoginInfo();
  }
}
