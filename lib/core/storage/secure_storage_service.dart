import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import '../constants/app_constants.dart';

@lazySingleton
class SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService(this._storage);

  Future<void> saveToken(String token) async {
    await _storage.write(key: AppConstants.keyToken, value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: AppConstants.keyToken);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: AppConstants.keyToken);
  }

  Future<void> saveUserId(String userId) async {
    await _storage.write(key: AppConstants.keyUserId, value: userId);
  }

  Future<String?> getUserId() async {
    return await _storage.read(key: AppConstants.keyUserId);
  }

  Future<void> saveTenantId(String tenantId) async {
    await _storage.write(key: AppConstants.keyTenantId, value: tenantId);
  }

  Future<String?> getTenantId() async {
    return await _storage.read(key: AppConstants.keyTenantId);
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
