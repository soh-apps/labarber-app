import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:la_barber/core/restClient/either.dart';

import 'package:la_barber/features/admin/barbershop/repository/barbershop_repository.dart';

part 'barbershop_state.dart';

class BarbershopCubit extends Cubit<BarbershopState> {
  final BarbershopRepository barbershopRepository;
  BarbershopCubit(
    this.barbershopRepository,
  ) : super(BarbershopInitial());

  Future<void> getAllCompanies() async {
    emit(BarbershopLoading());
    final result = await barbershopRepository.getAllCompanies();

    switch (result) {
      case Success():

        // GetIt.instance.registerSingleton(UserModel(
        //   name: loginResult.value.name,
        //   userType: loginResult.value.userType,
        //   token: loginResult.value.token,
        //   refreshToken: loginResult.value.refreshToken,
        //   credentialId: loginResult.value.credentialId,
        // ));
        emit(BarbershopSuccess());

      // Status Sucesso
      case Failure():
      // final exception = loginResult.exception;
      // if (exception is AuthUnauthorizedException) {
      //   // Failure(ServiceException(message: 'Login ou Senha Inválidos'));
      //   emit(const AuthStateError(errorMessage: 'Login ou Senha Inválidos'));
      // } else {
      //   () {
      //     // Failure(ServiceException(message: 'Erro ao realizar login'));
      //     emit(const AuthStateError(errorMessage: 'Erro ao realizar login'));
      //   };
      // }
    }
  }
}
