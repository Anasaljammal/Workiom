import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/login_info_entity.dart';
import '../entities/edition_entity.dart';
import '../entities/password_complexity_entity.dart';
import '../entities/auth_token_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginInfoEntity>> getCurrentLoginInfo();
  
  Future<Either<Failure, List<EditionEntity>>> getEditions();
  
  Future<Either<Failure, PasswordComplexityEntity>> getPasswordComplexity();
  
  Future<Either<Failure, bool>> checkTenantAvailability(String tenantName);
  
  Future<Either<Failure, void>> registerTenant({
    required String email,
    required String firstName,
    required String lastName,
    required String password,
    required String tenantName,
    required int editionId,
    required String timezone,
  });
  
  Future<Either<Failure, AuthTokenEntity>> authenticate({
    required String email,
    required String password,
    required String tenantName,
    required String timezone,
  });
  
  Future<Either<Failure, void>> logout();
}
