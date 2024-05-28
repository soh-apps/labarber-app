part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthStateInitial extends AuthState {}

final class AuthStateLoaging extends AuthState {}

final class AuthStateSuccess extends AuthState {}

final class AuthStateError extends AuthState {}
