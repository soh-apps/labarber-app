// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:la_barber/auth/repository/auth_repository.dart';
import 'package:la_barber/core/constants/local_storage_key.dart';
import 'package:la_barber/core/exceptions/auth_exception.dart';
import 'package:la_barber/core/exceptions/service_exception.dart';
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
      case Success(value: final accessToken):
        final sp = await SharedPreferences.getInstance();
        sp.setString(LocalStorageKey.accessToken, accessToken);
      // Status Sucesso
      case Failure(:final exception):
        if (exception == AuthUnauthorizedException) {
          Failure(ServiceException(message: 'Login ou Senha Inválidos'));
        } else {
          () {
            Failure(ServiceException(message: 'Erorr ao realizar login'));
          };
        }
    }
  }
}
