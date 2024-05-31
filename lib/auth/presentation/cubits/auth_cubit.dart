// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:la_barber/auth/model/user_model.dart';
import 'package:la_barber/auth/repository/auth_repository.dart';
import 'package:la_barber/core/constants/local_storage_key.dart';
import 'package:la_barber/core/exceptions/auth_exception.dart';
import 'package:la_barber/core/restClient/either.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  AuthCubit(
    this.authRepository,
  ) : super(AuthStateInitial());

  Future<void> login(String email, String password) async {
    final loginResult = await authRepository.login(email, password);

    switch (loginResult) {
      case Success():
        final sp = await SharedPreferences.getInstance();
        sp.setString(LocalStorageKey.accessToken, loginResult.value.token!);
        sp.setString(LocalStorageKey.refreshToken, loginResult.value.refreshToken!);

        GetIt.instance.registerSingleton(UserModel(
          name: loginResult.value.name!,
          userType: loginResult.value.userType!,
          token: loginResult.value.token!,
          refreshToken: loginResult.value.refreshToken!,
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
}
