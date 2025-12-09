part of 'auth_cubit.dart';

abstract class AuthState {
  const AuthState();

  factory AuthState.unauthenticated() = AuthUnauthenticatedState;
  factory AuthState.authenticating() = AuthAuthenticatingState;
  factory AuthState.authenticated({required UserViewModel user}) = AuthAuthenticatedState;
}

class AuthUnauthenticatedState extends AuthState {
  const AuthUnauthenticatedState();
}

class AuthAuthenticatingState extends AuthState {
  const AuthAuthenticatingState();
}

class AuthAuthenticatedState extends AuthState {
  const AuthAuthenticatedState({required this.user});

  final UserViewModel user;
}
