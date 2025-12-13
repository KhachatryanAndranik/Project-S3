import 'package:library_app/core.dart';
import 'package:library_app/data.dart';
import 'package:library_app/domain/auth/entities/login_credentials.dart';
import 'package:library_app/domain/auth/entities/sign_up_credentials.dart';

class AuthLocalDataSource implements AuthDataSource {
  const AuthLocalDataSource({
    required CacheDatabase cacheDatabase,
    required KeyValueStorage deviceKeyValueStorage,
  }) : _cacheDatabase = cacheDatabase,
       _deviceKeyValueStorage = deviceKeyValueStorage;

  final CacheDatabase _cacheDatabase;
  final KeyValueStorage _deviceKeyValueStorage;

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

    final userDto = UserDto.fromJson(result.first);

    await _storeAuthenticatedUserId(userDto.id);

    return userDto;
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

    final userDto = UserDto.fromJson(rows.first);

    await _storeAuthenticatedUserId(userDto.id);

    return userDto;
  }

  @override
  Future<UserDto?> fetchAuthenticatedUser() async {
    final userId = await _deviceKeyValueStorage.read<int>(
      'authenticated_user_id',
    );

    if (userId == null) {
      return null;
    }

    return fetchUserById(userId);
  }

  @override
  Future<UserDto?> fetchUserById(int userId) async {
    final result = await _cacheDatabase.query(
      'SELECT * FROM ${DatabaseConstants.users} '
      'WHERE ${DatabaseConstants.id} = ? '
      'LIMIT 1',
      arguments: [userId],
    );

    if (result.isEmpty) {
      return null;
    }

    return UserDto.fromJson(result.first);
  }

  @override
  Future<void> logOut() {
    return _deviceKeyValueStorage.remove('authenticated_user_id');
  }

  Future<void> _storeAuthenticatedUserId(int userId) {
    return _deviceKeyValueStorage.write<int>('authenticated_user_id', userId);
  }
}
