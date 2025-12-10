import 'package:library_app/data/dtos.dart';
import 'package:library_app/domain.dart';

abstract class AuthDataSource {
  Future<UserDto> signUp(SignUpCredentials credentials);
  Future<UserDto> logIn(LoginCredentials credentials);
  Future<void> logOut();
  Future<UserDto?> fetchAuthenticatedUser();
}