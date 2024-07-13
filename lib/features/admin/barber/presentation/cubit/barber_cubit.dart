import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:la_barber/core/restClient/either.dart';
import 'package:la_barber/features/admin/barber/repository/barber_repository.dart';
import 'package:la_barber/features/admin/barber/repository/models/barber_model.dart';
import 'package:la_barber/features/admin/barbershop/repository/models/via_cep_model.dart';

part 'barber_state.dart';

class BarberCubit extends Cubit<BarberState> {
  final BarberRepository barberRepository;
  BarberCubit(
    this.barberRepository,
  ) : super(BarberInitial());

  String mensagem = '';
  List<BarberModel> barbers = [];
  ViaCEPModel? cepModel;

  Future<void> registerBarber(BarberModel barber) async {
    final result = await barberRepository.cadastrarColaborador(barber);

    // final dto = (
    //   name: name,
    //   email: email,
    //   openingDays: openingDays,
    //   openingHours: openingHours
    // );

    switch (result) {
      case Success():
        mensagem = result.value;
        emit(BarberSuccess());
      case Failure():
        mensagem = result.exception.message;
        emit(BarberFailure(errorMessage: mensagem));
    }
  }

  Future<void> getAllBarbers(int companyId) async {
    emit(BarberLoading());
    final result = await barberRepository.getAllBarbers(companyId);

    switch (result) {
      case Success():
        barbers = result.value;
        emit(BarberSuccess());
      case Failure():
        emit(const BarberFailure(errorMessage: 'Erro ao buscar barbeiros'));
    }
  }

  Future<void> getByCEP(String cep) async {
    emit(BarberLoading());

    final result = await barberRepository.getByCEP(cep);

    switch (result) {
      case Success():
        cepModel = result.value;
        emit(BarberCepSuccess());
      case Failure():
        emit(BarberCepFailure(errorMessage: mensagem));
    }
  }
}
