part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthStateInitial extends AuthState {}

final class AuthStateLoaging extends AuthState {}

final class AuthStateSuccess extends AuthState {
  const AuthStateSuccess({
    required this.userType,
  });

  final UserType userType;

  @override
  List<Object> get props => [userType];
}

final class AuthStateError extends AuthState {
  const AuthStateError({
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
