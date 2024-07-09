import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:la_barber/core/restClient/either.dart';
import 'package:la_barber/features/admin/barbershop/repository/barbershop_repository.dart';
import 'package:la_barber/features/admin/barbershop/repository/models/barbershop_model.dart';
import 'package:la_barber/features/admin/barbershop/repository/models/via_cep_model.dart';

part 'barbershop_state.dart';

class BarbershopCubit extends Cubit<BarbershopState> {
  final BarbershopRepository barbershopRepository;
  BarbershopCubit(
    this.barbershopRepository,
  ) : super(BarbershopInitial());

  List<BarbershopModel> barberUnits = [];
  String mensagem = '';
  ViaCEPModel? cepModel;

  Future<void> registerBarberShop(BarbershopModel barberShop) async {
    final result = await barbershopRepository.cadastrarBarbearia(barberShop);

    // final dto = (
    //   name: name,
    //   email: email,
    //   openingDays: openingDays,
    //   openingHours: openingHours
    // );

    switch (result) {
      case Success():
        mensagem = result.value;
        emit(BarbershopSuccess());
      case Failure():
        mensagem = result.exception.message;
        emit(BarbershopFailure(errorMessage: mensagem));
    }
  }

  Future<void> getAllCompanies() async {
    emit(BarbershopLoading());

    final result = await barbershopRepository.getAllCompanies();

    switch (result) {
      case Success():
        barberUnits = result.value;
        emit(BarbershopSuccess());
      case Failure():
        emit(BarbershopFailure(errorMessage: mensagem));
    }
  }

  Future<void> getByCEP(String cep) async {
    emit(BarbershopLoading());

    final result = await barbershopRepository.getByCEP(cep);

    switch (result) {
      case Success():
        cepModel = result.value;
        // barberUnits = result.value;
        emit(BarbershopCepSuccess());
      case Failure():
        emit(BarbershopCepFail(errorMessage: mensagem));
    }
  }
}
