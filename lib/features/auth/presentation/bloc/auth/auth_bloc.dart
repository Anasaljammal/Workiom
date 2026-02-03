import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/utils/timezone_helper.dart';
import '../../../domain/usecases/authenticate_user.dart';
import '../../../domain/usecases/check_tenant_availability.dart';
import '../../../domain/usecases/get_current_login_info.dart';
import '../../../domain/usecases/get_editions.dart';
import '../../../domain/usecases/get_password_complexity.dart';
import '../../../domain/usecases/logout_user.dart';
import '../../../domain/usecases/register_tenant.dart';
import 'auth_event.dart';
import 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetCurrentLoginInfo getCurrentLoginInfo;
  final GetEditions getEditions;
  final GetPasswordComplexity getPasswordComplexity;
  final CheckTenantAvailability checkTenantAvailability;
  final RegisterTenant registerTenant;
  final AuthenticateUser authenticateUser;
  final LogoutUser logoutUser;

  AuthBloc({
    required this.getCurrentLoginInfo,
    required this.getEditions,
    required this.getPasswordComplexity,
    required this.checkTenantAvailability,
    required this.registerTenant,
    required this.authenticateUser,
    required this.logoutUser,
  }) : super(const AuthInitial()) {
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
    on<GetEditionsEvent>(_onGetEditions);
    on<GetPasswordComplexityEvent>(_onGetPasswordComplexity);
    on<CheckTenantAvailabilityEvent>(_onCheckTenantAvailability);
    on<RegisterTenantEvent>(_onRegisterTenant);
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await getCurrentLoginInfo(NoParams());

    result.fold(
      (failure) => emit(const AuthUnauthenticated()),
      (loginInfo) {
        if (loginInfo.user == null) {
          emit(const AuthUnauthenticated());
        } else {
          emit(AuthAuthenticated(loginInfo));
        }
      },
    );
  }

  Future<void> _onGetEditions(
    GetEditionsEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await getEditions(NoParams());

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (editions) => emit(EditionsLoaded(editions)),
    );
  }

  Future<void> _onGetPasswordComplexity(
    GetPasswordComplexityEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await getPasswordComplexity(NoParams());

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (complexity) => emit(PasswordComplexityLoaded(complexity)),
    );
  }

  Future<void> _onCheckTenantAvailability(
    CheckTenantAvailabilityEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await checkTenantAvailability(
      CheckTenantParams(tenantName: event.tenantName),
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (isAvailable) => emit(TenantAvailabilityChecked(isAvailable)),
    );
  }

  Future<void> _onRegisterTenant(
    RegisterTenantEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final timezone = TimezoneHelper.getDefaultTimezone();

    final result = await registerTenant(
      RegisterTenantParams(
        email: event.email,
        firstName: event.firstName,
        lastName: event.lastName,
        password: event.password,
        tenantName: event.tenantName,
        editionId: event.editionId,
        timezone: timezone,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(const TenantRegistrationSuccess()),
    );
  }

  Future<void> _onLogin(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final timezone = TimezoneHelper.getDefaultTimezone();

    final authResult = await authenticateUser(
      AuthenticateParams(
        email: event.email,
        password: event.password,
        tenantName: event.tenantName,
        timezone: timezone,
      ),
    );

    await authResult.fold(
      (failure) async => emit(AuthError(failure.message)),
      (_) async {
        final loginInfoResult = await getCurrentLoginInfo(NoParams());

        loginInfoResult.fold(
          (failure) => emit(AuthError(failure.message)),
          (loginInfo) => emit(LoginSuccess(loginInfo)),
        );
      },
    );
  }

  Future<void> _onLogout(
    LogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await logoutUser(NoParams());

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(const AuthUnauthenticated()),
    );
  }
}
