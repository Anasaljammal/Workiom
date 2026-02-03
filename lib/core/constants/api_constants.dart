class ApiConstants {
  static const String baseUrl = 'https://api.workiom.club';
  static const String apiPrefix = '/api';
  
  static const String getCurrentLoginInfo = '$apiPrefix/services/app/Session/GetCurrentLoginInformations';
  static const String getEditions = '$apiPrefix/services/app/TenantRegistration/GetEditionsForSelect';
  static const String getPasswordComplexity = '$apiPrefix/services/app/Profile/GetPasswordComplexitySetting';
  static const String checkTenantAvailability = '$apiPrefix/services/app/Account/IsTenantAvailable';
  static const String registerTenant = '$apiPrefix/services/app/TenantRegistration/RegisterTenant';
  static const String authenticate = '$apiPrefix/TokenAuth/Authenticate';
  
  static const String authorization = 'Authorization';
  static const String contentType = 'Content-Type';
  static const String applicationJson = 'application/json';
  
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
}
