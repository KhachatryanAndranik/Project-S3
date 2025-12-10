part of 'auth_cubit.dart';

abstract class AuthState {
  const AuthState({this.errorMessage});

  final String? errorMessage;

  factory AuthState.unauthenticated({String? errorMessage}) = AuthUnauthenticatedState;
  factory AuthState.authenticating({String? errorMessage}) = AuthAuthenticatingState;
  factory AuthState.authenticated({required UserViewModel user, String? errorMessage}) =
      AuthAuthenticatedState;

  AuthState copyWith({String? errorMessage}) {
    if (this is AuthUnauthenticatedState) {
      return AuthUnauthenticatedState(errorMessage: errorMessage ?? this.errorMessage);
    } else if (this is AuthAuthenticatingState) {
      return AuthAuthenticatingState(errorMessage: errorMessage ?? this.errorMessage);
    } else {
      return AuthAuthenticatedState(
        user: (this as AuthAuthenticatedState).user,
        errorMessage: errorMessage ?? this.errorMessage,
      );
    }
  }
}

class AuthUnauthenticatedState extends AuthState {
  const AuthUnauthenticatedState({super.errorMessage});
}

class AuthAuthenticatingState extends AuthState {
  const AuthAuthenticatingState({super.errorMessage});
}

class AuthAuthenticatedState extends AuthState {
  const AuthAuthenticatedState({required this.user, super.errorMessage});
  final UserViewModel user;
}
