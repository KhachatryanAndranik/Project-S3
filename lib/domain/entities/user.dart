import 'package:library_app/data.dart';
import 'package:library_app/presentation/common.dart';

class User {
  const User({
    required this.id,
    required this.username,
    required this.name,
    required this.surname,
    required this.email,
  });

  final int id;
  final String username;
  final String name;
  final String surname;
  final String email;

  factory User.fromDto(UserDto dto) {
    return User(
      id: dto.id,
      username: dto.username,
      name: dto.name,
      surname: dto.surname,
      email: dto.email,
    );
  }

  UserDto toDto() {
    return UserDto(
      id: id,
      username: username,
      name: name,
      surname: surname,
      email: email,
    );
  }

  UserViewModel toViewModel() {
    return UserViewModel(
      id: id,
      username: username,
      name: name,
      surname: surname,
      email: email,
    );
  }
}
