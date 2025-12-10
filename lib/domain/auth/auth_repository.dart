import 'package:library_app/domain.dart';

abstract class AuthRepository {
  Future<User> signUp(SignUpCredentials credentials);
  Future<User> logIn(LoginCredentials credentials);
  Future<void> logOut();
  Future<User?> fetchAuthenticatedUser();
}
