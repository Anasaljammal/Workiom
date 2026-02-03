import 'package:equatable/equatable.dart';

class AuthTokenEntity extends Equatable {
  final String accessToken;
  final String encryptedAccessToken;
  final int expireInSeconds;

  const AuthTokenEntity({
    required this.accessToken,
    required this.encryptedAccessToken,
    required this.expireInSeconds,
  });

  @override
  List<Object?> get props => [accessToken, encryptedAccessToken, expireInSeconds];
}
