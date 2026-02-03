import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/edition_entity.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class GetEditions implements UseCase<List<EditionEntity>, NoParams> {
  final AuthRepository repository;

  GetEditions(this.repository);

  @override
  Future<Either<Failure, List<EditionEntity>>> call(NoParams params) async {
    return await repository.getEditions();
  }
}
