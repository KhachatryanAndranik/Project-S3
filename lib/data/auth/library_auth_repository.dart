import 'package:library_app/data.dart';
import 'package:library_app/domain.dart';

class LibraryAuthRepository implements AuthRepository {
  const LibraryAuthRepository({required AuthDataSource authLocalDataSource})
    : _authLocalDataSource = authLocalDataSource;

  final AuthDataSource _authLocalDataSource;

  @override
  Future<User> logIn(LoginCredentials credentials) async {
    final response = await _authLocalDataSource.logIn(credentials);

    return User.fromDto(response);
  }

  @override
  Future<User> signUp(SignUpCredentials credentials) async {
    final response = await _authLocalDataSource.signUp(credentials);

    return User.fromDto(response);
  }

  @override
  Future<User?> fetchAuthenticatedUser() async {
    final response = await _authLocalDataSource.fetchAuthenticatedUser();

    return response != null ? User.fromDto(response) : null;
  }

  @override
  Future<void> logOut() {
    return _authLocalDataSource.logOut();
  }
}
