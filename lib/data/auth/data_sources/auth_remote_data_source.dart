import 'package:library_app/data.dart';
import 'package:library_app/domain/auth/entities/login_credentials.dart';
import 'package:library_app/domain/auth/entities/sign_up_credentials.dart';

class AuthRemoteDataSource implements AuthDataSource {
  @override
  Future<UserDto> logIn(LoginCredentials credentials) {
    throw UnimplementedError();
  }

  @override
  Future<UserDto> signUp(SignUpCredentials credentials) {
    throw UnimplementedError();
  }
  
  @override
  Future<UserDto?> fetchAuthenticatedUser() {
    throw UnimplementedError();
  }
  
  @override
  Future<void> logOut() {
    throw UnimplementedError();
  }
}
