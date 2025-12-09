import 'package:library_app/data.dart';
import 'package:library_app/domain/auth/entities/login_credentials.dart';
import 'package:library_app/domain/auth/entities/sign_up_credentials.dart';
import 'package:library_app/core/cache.dart';

class AuthLocalDataSource implements AuthDataSource {
  const AuthLocalDataSource({required CacheDatabase cacheDatabase})
    : _cacheDatabase = cacheDatabase;

  final CacheDatabase _cacheDatabase;

  @override
  Future<UserDto> logIn(LoginCredentials credentials) async {
    final result = await _cacheDatabase.query(
      'SELECT * FROM ${DatabaseConstants.users} '
      'WHERE ${DatabaseConstants.username} = ? '
      'AND ${DatabaseConstants.password} = ? '
      'LIMIT 1',
      arguments: [credentials.username, credentials.password],
    );

    if (result.isEmpty) {
      throw Exception('Invalid credentials');
    }

    return UserDto.fromJson(result.first);
  }

  @override
  Future<UserDto> signUp(SignUpCredentials credentials) async {
    await _cacheDatabase.query(
      'INSERT INTO ${DatabaseConstants.users} ('
      '${DatabaseConstants.username}, ${DatabaseConstants.password}, '
      '${DatabaseConstants.email}, ${DatabaseConstants.name}, ${DatabaseConstants.surname}'
      ') VALUES (?, ?, ?, ?, ?)',
      arguments: [
        credentials.username,
        credentials.password,
        credentials.email,
        credentials.name,
        credentials.surname,
      ],
    );

    final rows = await _cacheDatabase.query(
      'SELECT * FROM ${DatabaseConstants.users} '
      'WHERE ${DatabaseConstants.username} = ? '
      'LIMIT 1',
      arguments: [credentials.username],
    );

    if (rows.isEmpty) {
      throw Exception('Failed to create user');
    }

    return UserDto.fromJson(rows.first);
  }
}
