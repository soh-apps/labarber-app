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

  // late BarbershopModel barbershopModel;

  // void addOrRemoveOpenDay(int weekDay) {
  //   if (barbershopModel.workingDays == null) {
  //     barbershopModel.workingDays = [];
  //   }
  //   barbershopModel.workingDays = [weekDay];
  //   barbershopModel.workingDays.add(weekDay);
  //   if (barbershopModel.workingDays.contains(weekDay)) {
  //     openingDays.remove(weekDay);
  //   } else {
  //     openingDays.add(weekDay);
  //   }

  //   state = state.copyWith(openingDays: openingDays);
  // }

  // void addOrRemoveOpenHour(int hour) {
  //   final openingHours = state.openingHours;
  //   if(openingHours.contains(hour)) {
  //     openingHours.remove(hour);
  //   } else {
  //     openingHours.add(hour);
  //   }

  //   state = state.copyWith(openingHours: openingHours);
  // }

//  Future<void> register({required String name, required String email}) async {
//     final repository = ref.watch(barbershopRepositoryProvider);

//     final BarbershopRegisterState(:openingDays, :openingHours) = state;

//     final dto = (
//       name: name,
//       email: email,
//       openingDays: openingDays,
//       openingHours: openingHours
//     );

//     final registerResult = await repository.save(dto);

//     switch(registerResult) {
//       case Success():
//         ref.invalidate(getMyBarbershopProvider);
//         state = state.copyWith(status: BarbershopRegisterStateStatus.success);
//       case Failure():
//         state = state.copyWith(status: BarbershopRegisterStateStatus.error);
//     }
//   }

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
