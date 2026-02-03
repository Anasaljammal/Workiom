import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String name;
  final String surname;
  final String userName;
  final String emailAddress;
  final bool isActive;

  const UserEntity({
    required this.id,
    required this.name,
    required this.surname,
    required this.userName,
    required this.emailAddress,
    required this.isActive,
  });

  @override
  List<Object?> get props => [id, name, surname, userName, emailAddress, isActive];
}
