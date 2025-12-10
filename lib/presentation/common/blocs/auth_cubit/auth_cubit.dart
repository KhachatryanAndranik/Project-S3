import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/core.dart';
import 'package:library_app/domain.dart';
import 'package:library_app/presentation/common.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(AuthState.unauthenticated());

  final AuthRepository _authRepository;

  Future<void> logIn(LoginCredentials credentials) async {
    safeEmit(AuthState.authenticating());

    try {
      final user = await _authRepository.logIn(credentials);
      safeEmit(AuthState.authenticated(user: user.toViewModel()));
    } catch (error) {
      safeEmit(AuthState.unauthenticated(errorMessage: error.toString()));
    }
  }

  Future<void> signUp(SignUpCredentials credentials) async {
    safeEmit(AuthState.authenticating());

    try {
      final user = await _authRepository.signUp(credentials);
      safeEmit(AuthState.authenticated(user: user.toViewModel()));
    } catch (error) {
      safeEmit(AuthState.unauthenticated(errorMessage: error.toString()));
    }
  }
}
