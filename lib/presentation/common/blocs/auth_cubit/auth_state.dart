part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState({this.errorMessage});

  final String? errorMessage;

  const factory AuthState.unauthenticated({String? errorMessage}) =
      UnauthenticatedState;
  const factory AuthState.authenticating({String? errorMessage}) =
      AuthenticatingState;
  const factory AuthState.unauthenticating({String? errorMessage}) =
      UnauthenticatingState;
  const factory AuthState.authenticated({
    required UserViewModel user,
    String? errorMessage,
  }) = AuthenticatedState;

  AuthState copyWith({String? errorMessage}) {
    if (this is UnauthenticatedState) {
      return UnauthenticatedState(
        errorMessage: errorMessage ?? this.errorMessage,
      );
    } else if (this is AuthenticatingState) {
      return AuthenticatingState(
        errorMessage: errorMessage ?? this.errorMessage,
      );
    } else if (this is UnauthenticatingState) {
      return UnauthenticatingState(
        errorMessage: errorMessage ?? this.errorMessage,
      );
    } else {
      return AuthenticatedState(
        user: (this as AuthenticatedState).user,
        errorMessage: errorMessage ?? this.errorMessage,
      );
    }
  }

  @override
  List<Object?> get props => [errorMessage];
}

class UnauthenticatedState extends AuthState {
  const UnauthenticatedState({super.errorMessage});
}

class AuthenticatingState extends AuthState {
  const AuthenticatingState({super.errorMessage});
}

class UnauthenticatingState extends AuthState {
  const UnauthenticatingState({super.errorMessage});
}

class AuthenticatedState extends AuthState {
  const AuthenticatedState({required this.user, super.errorMessage});
  final UserViewModel user;

  @override
  List<Object?> get props => [user, errorMessage];
}
