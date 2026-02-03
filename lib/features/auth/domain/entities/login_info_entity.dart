import 'package:equatable/equatable.dart';
import 'user_entity.dart';
import 'tenant_entity.dart';

class LoginInfoEntity extends Equatable {
  final UserEntity? user;
  final TenantEntity? tenant;

  const LoginInfoEntity({
    this.user,
    this.tenant,
  });

  @override
  List<Object?> get props => [user, tenant];
}
