// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i7;

import '../../features/auth/data/datasources/auth_remote_data_source.dart'
    as _i3;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i11;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i10;
import '../../features/auth/domain/usecases/authenticate_user.dart' as _i12;
import '../../features/auth/domain/usecases/check_tenant_availability.dart'
    as _i13;
import '../../features/auth/domain/usecases/get_current_login_info.dart'
    as _i14;
import '../../features/auth/domain/usecases/get_editions.dart' as _i15;
import '../../features/auth/domain/usecases/get_password_complexity.dart'
    as _i16;
import '../../features/auth/domain/usecases/logout_user.dart' as _i17;
import '../../features/auth/domain/usecases/register_tenant.dart' as _i18;
import '../../features/auth/presentation/bloc/auth/auth_bloc.dart' as _i19;
import '../../features/auth/presentation/bloc/password_entry/password_entry_bloc.dart'
    as _i20;
import '../network/dio_client.dart' as _i6;
import '../network/network_info.dart' as _i8;
import '../storage/secure_storage_service.dart' as _i5;
import '../storage/shared_prefs_service.dart' as _i9;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i3.AuthRemoteDataSource>(
      () => _i3.AuthRemoteDataSourceImpl(gh<_i6.DioClient>()),
    );
    gh.lazySingleton<_i5.SecureStorageService>(
      () => _i5.SecureStorageService(gh<_i4.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i6.DioClient>(
      () => _i6.DioClient(gh<_i5.SecureStorageService>()),
    );
    gh.lazySingleton<_i9.SharedPrefsService>(
      () => _i9.SharedPrefsService(gh<_i7.SharedPreferences>()),
    );
    gh.lazySingleton<_i8.NetworkInfo>(() => _i8.NetworkInfoImpl());
    gh.lazySingleton<_i10.AuthRepository>(
      () => _i11.AuthRepositoryImpl(
        remoteDataSource: gh<_i3.AuthRemoteDataSource>(),
        networkInfo: gh<_i8.NetworkInfo>(),
        secureStorage: gh<_i5.SecureStorageService>(),
        sharedPrefs: gh<_i9.SharedPrefsService>(),
      ),
    );
    gh.lazySingleton<_i12.AuthenticateUser>(
      () => _i12.AuthenticateUser(gh<_i10.AuthRepository>()),
    );
    gh.lazySingleton<_i13.CheckTenantAvailability>(
      () => _i13.CheckTenantAvailability(gh<_i10.AuthRepository>()),
    );
    gh.lazySingleton<_i14.GetCurrentLoginInfo>(
      () => _i14.GetCurrentLoginInfo(gh<_i10.AuthRepository>()),
    );
    gh.lazySingleton<_i15.GetEditions>(
      () => _i15.GetEditions(gh<_i10.AuthRepository>()),
    );
    gh.lazySingleton<_i16.GetPasswordComplexity>(
      () => _i16.GetPasswordComplexity(gh<_i10.AuthRepository>()),
    );
    gh.lazySingleton<_i17.LogoutUser>(
      () => _i17.LogoutUser(gh<_i10.AuthRepository>()),
    );
    gh.lazySingleton<_i18.RegisterTenant>(
      () => _i18.RegisterTenant(gh<_i10.AuthRepository>()),
    );
    gh.factory<_i19.AuthBloc>(
      () => _i19.AuthBloc(
        getCurrentLoginInfo: gh<_i14.GetCurrentLoginInfo>(),
        getEditions: gh<_i15.GetEditions>(),
        getPasswordComplexity: gh<_i16.GetPasswordComplexity>(),
        checkTenantAvailability: gh<_i13.CheckTenantAvailability>(),
        registerTenant: gh<_i18.RegisterTenant>(),
        authenticateUser: gh<_i12.AuthenticateUser>(),
        logoutUser: gh<_i17.LogoutUser>(),
      ),
    );
    gh.factory<_i20.PasswordEntryBloc>(() => _i20.PasswordEntryBloc());
    return this;
  }
}
