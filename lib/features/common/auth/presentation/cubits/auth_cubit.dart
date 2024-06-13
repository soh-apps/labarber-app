// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:la_barber/core/constants/local_secure_storage_key.dart';
import 'package:la_barber/core/formatters.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:la_barber/core/constants/local_storage_key.dart';
import 'package:la_barber/core/exceptions/auth_exception.dart';
import 'package:la_barber/core/local_secure_storage/local_secure_storage.dart';
import 'package:la_barber/core/restClient/either.dart';
import 'package:la_barber/features/common/auth/model/user_model.dart';
import 'package:la_barber/features/common/auth/repository/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  final LocalSecureStorage localSecureStorage;
  AuthCubit(
    this.authRepository,
    this.localSecureStorage,
  ) : super(AuthStateInitial());

  Future<void> saveLocalUser(UserModel user) async {
    try {
      await localSecureStorage.write(key: LocalSecureStorageKey.user, value: user.toJson());
    } catch (e) {
      log(e.toString());
    }
  }

  Future<UserModel?> fetchLocalUser() async {
    try {
      final user = await localSecureStorage.read(LocalSecureStorageKey.user);
      if (user != null && user.isNotEmpty) {
        UserModel userModel = UserModel.fromMap(json.decode(Formatters.parseString(user)) as Map<String, dynamic>);
        return userModel;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<void> verifyLocalUser() async {
    emit(AuthStateLoaging());
    final user = await fetchLocalUser();
    if (user != null) {
      GetIt.instance.registerSingleton(user);
      emit(AuthStateSuccess(userType: user.userType!));
    } else {
      emit(AuthStateInitial());
    }
  }

  Future<void> login(String email, String password) async {
    emit(AuthStateLoaging());
    final loginResult = await authRepository.login(email, password);

    switch (loginResult) {
      case Success():
        final sp = await SharedPreferences.getInstance();
        sp.setString(LocalStorageKey.accessToken, loginResult.value.token);
        sp.setString(LocalStorageKey.refreshToken, loginResult.value.refreshToken);
        sp.setInt(LocalStorageKey.refreshToken, loginResult.value.credentialId);

        GetIt.instance.registerSingleton(UserModel(
          name: loginResult.value.name,
          userType: loginResult.value.userType,
          token: loginResult.value.token,
          refreshToken: loginResult.value.refreshToken,
          credentialId: loginResult.value.credentialId,
        ));
        emit(AuthStateSuccess(userType: loginResult.value.userType!));

      // Status Sucesso
      case Failure():
        final exception = loginResult.exception;
        if (exception is AuthUnauthorizedException) {
          // Failure(ServiceException(message: 'Login ou Senha Inválidos'));
          emit(const AuthStateError(errorMessage: 'Login ou Senha Inválidos'));
        } else {
          () {
            // Failure(ServiceException(message: 'Erro ao realizar login'));
            emit(const AuthStateError(errorMessage: 'Erro ao realizar login'));
          };
        }
    }
  }

  Future<void> verifyIsLogged() async {
    emit(AuthStateLoaging());
    final sp = await SharedPreferences.getInstance();
    final String? accessToken = sp.getString(LocalStorageKey.accessToken);
    if (accessToken != null) {
      emit(const AuthStateSuccess(userType: UserType.admin));
    } else {
      emit(AuthStateInitial());
    }
  }
}
