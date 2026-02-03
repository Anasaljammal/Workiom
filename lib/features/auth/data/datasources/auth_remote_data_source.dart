import 'package:injectable/injectable.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../models/login_info_model.dart';
import '../models/edition_model.dart';
import '../models/password_complexity_model.dart';
import '../models/auth_token_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginInfoModel> getCurrentLoginInfo();
  Future<List<EditionModel>> getEditions();
  Future<PasswordComplexityModel> getPasswordComplexity();
  Future<bool> checkTenantAvailability(String tenantName);
  Future<void> registerTenant({
    required String email,
    required String firstName,
    required String lastName,
    required String password,
    required String tenantName,
    required int editionId,
    required String timezone,
  });
  Future<AuthTokenModel> authenticate({
    required String email,
    required String password,
    required String tenantName,
    required String timezone,
  });
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient _dioClient;

  AuthRemoteDataSourceImpl(this._dioClient);

  @override
  Future<LoginInfoModel> getCurrentLoginInfo() async {
    try {
      final response = await _dioClient.get(ApiConstants.getCurrentLoginInfo);

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>?;
        final result = data?['result'] ?? data?['Result'];
        if (result == null || result is! Map<String, dynamic>) {
          return LoginInfoModel(user: null, tenant: null);
        }
        return LoginInfoModel.fromJson(result);
      } else {
        throw ServerException(
          message: 'Failed to get login info',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<EditionModel>> getEditions() async {
    try {
      final response = await _dioClient.get(ApiConstants.getEditions);

      if (response.statusCode == 200) {
        final editionsData =
            response.data['result']['editionsWithFeatures'] as List;
        return editionsData.map((item) {
          final json = item is Map<String, dynamic>
              ? (item['edition'] ?? item['Edition'] ?? item)
                    as Map<String, dynamic>
              : item as Map<String, dynamic>;
          return EditionModel.fromJson(json);
        }).toList();
      } else {
        throw ServerException(
          message: 'Failed to get editions',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<PasswordComplexityModel> getPasswordComplexity() async {
    try {
      final response = await _dioClient.get(ApiConstants.getPasswordComplexity);

      if (response.statusCode == 200) {
        return PasswordComplexityModel.fromJson(response.data['result']);
      } else {
        throw ServerException(
          message: 'Failed to get password complexity',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<bool> checkTenantAvailability(String tenantName) async {
    try {
      final response = await _dioClient.post(
        ApiConstants.checkTenantAvailability,
        data: {'tenancyName': tenantName},
      );

      if (response.statusCode == 200) {
        final tenantId = response.data['result']['tenantId'];
        return tenantId == null;
      } else {
        throw ServerException(
          message: 'Failed to check tenant availability',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> registerTenant({
    required String email,
    required String firstName,
    required String lastName,
    required String password,
    required String tenantName,
    required int editionId,
    required String timezone,
  }) async {
    try {
      final response = await _dioClient.post(
        ApiConstants.registerTenant,
        queryParameters: {'timeZone': timezone},
        data: {
          'adminEmailAddress': email,
          'adminFirstName': firstName,
          'adminLastName': lastName,
          'adminPassword': password,
          'captchaResponse': null,
          'editionId': editionId,
          'name': tenantName,
          'tenancyName': tenantName,
        },
      );

      if (response.statusCode != 200) {
        throw ServerException(
          message: 'Failed to register tenant',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<AuthTokenModel> authenticate({
    required String email,
    required String password,
    required String tenantName,
    required String timezone,
  }) async {
    try {
      final response = await _dioClient.post(
        ApiConstants.authenticate,
        data: {
          'ianaTimeZone': timezone,
          'password': password,
          'rememberClient': false,
          'returnUrl': null,
          'singleSignIn': false,
          'tenantName': tenantName,
          'userNameOrEmailAddress': email,
        },
      );

      if (response.statusCode == 200) {
        return AuthTokenModel.fromJson(response.data['result']);
      } else {
        throw ServerException(
          message: 'Failed to authenticate',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
