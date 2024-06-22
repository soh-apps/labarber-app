// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:la_barber/core/constants/local_secure_storage_key.dart';
import 'package:la_barber/core/constants/local_storage_key.dart';
import 'package:la_barber/core/exceptions/auth_exception.dart';
import 'package:la_barber/core/formatters.dart';
import 'package:la_barber/core/local_secure_storage/local_secure_storage.dart';
import 'package:la_barber/core/restClient/either.dart';
import 'package:la_barber/features/common/auth/model/user_model.dart';
import 'package:la_barber/features/common/auth/repository/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      await localSecureStorage.write(
          key: LocalSecureStorageKey.user, value: user.toJson());

      if (GetIt.instance.isRegistered<UserModel>()) {
        GetIt.instance.unregister<UserModel>();
      }

      GetIt.instance.registerSingleton(UserModel(
        name: user.name,
        userType: user.userType,
        token: user.token,
        refreshToken: user.refreshToken,
        credentialId: user.credentialId,
      ));
    } catch (e) {
      log(e.toString());
      localSecureStorage.clear();
    }
  }

  Future<UserModel?> fetchLocalUser() async {
    try {
      final user = await localSecureStorage.read(LocalSecureStorageKey.user);
      if (user != null && user.isNotEmpty) {
        UserModel userModel = UserModel.fromMap(
            json.decode(Formatters.parseString(user)) as Map<String, dynamic>);
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
        // final sp = await SharedPreferences.getInstance();
        // sp.setString(LocalStorageKey.accessToken, loginResult.value.token);
        // sp.setString(LocalStorageKey.refreshToken, loginResult.value.refreshToken);
        // sp.setInt(LocalStorageKey.refreshToken, loginResult.value.credentialId);

        saveLocalUser(loginResult.value);

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

  Future<void> logout() async {
    emit(AuthStateLoaging());
    await Future.delayed(const Duration(seconds: 4));
    try {
      final sp = await SharedPreferences.getInstance();
      sp.clear();

      if (GetIt.instance.isRegistered<UserModel>()) {
        GetIt.instance.unregister<UserModel>();
      }
      emit(AuthStateInitial());
    } on Exception catch (e) {
      // Implementar Error
      log('Erro ao deslogar: $e');
      emit(AuthStateInitial());
    }
  }
}
