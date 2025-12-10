import 'package:equatable/equatable.dart';
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

  Future<bool> checkAuthenticatedUser() async {
    try {
      final user = await _authRepository.fetchAuthenticatedUser();

      if (user != null) {
        safeEmit(AuthState.authenticated(user: user.toViewModel()));

        return true;
      }
    } catch (_) {}

    return false;
  }

  Future<void> logIn(LoginCredentials credentials) async {
    if (credentials.username.isEmpty || credentials.password.isEmpty) {
      safeEmit(
        AuthState.unauthenticated(
          errorMessage: 'Username and password must not be empty.',
        ),
      );
      return;
    }

    safeEmit(AuthState.authenticating());

    try {
      final user = await _authRepository.logIn(credentials);
      safeEmit(AuthState.authenticated(user: user.toViewModel()));
    } catch (error) {
      safeEmit(AuthState.unauthenticated(errorMessage: error.toString()));
    }
  }

  Future<void> signUp(SignUpCredentials credentials) async {
    if (credentials.username.isEmpty ||
        credentials.password.isEmpty ||
        credentials.email.isEmpty ||
        credentials.name.isEmpty ||
        credentials.surname.isEmpty) {
      safeEmit(
        AuthState.unauthenticated(errorMessage: 'All fields must be filled.'),
      );
      return;
    }

    safeEmit(AuthState.authenticating());

    try {
      final user = await _authRepository.signUp(credentials);
      safeEmit(AuthState.authenticated(user: user.toViewModel()));
    } catch (error) {
      safeEmit(AuthState.unauthenticated(errorMessage: error.toString()));
    }
  }

  Future<void> logOut() async {
    if (state is AuthenticatedState) {
      final currentState = state as AuthenticatedState;

      safeEmit(AuthState.unauthenticating());

      try {
        await _authRepository.logOut();

        safeEmit(AuthState.unauthenticated());
      } catch (e) {
        safeEmit(
          AuthState.authenticated(
            user: currentState.user,
            errorMessage: e.toString(),
          ),
        );
      }
    }
  }

  void resetError() {
    safeEmit(state.copyWith(errorMessage: ''));
  }
}
