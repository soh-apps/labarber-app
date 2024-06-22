import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:la_barber/core/restClient/either.dart';

import 'package:la_barber/features/admin/barbershop/repository/barber_repository.dart';
import 'package:la_barber/features/admin/barbershop/repository/models/barbershop_model.dart';

part 'barber_state.dart';

class BarberCubit extends Cubit<BarberState> {
  final BarberRepository barberRepository;
  BarberCubit(
    this.barberRepository,
  ) : super(BarberInitial());

  List<BarbershopModel> barberUnits = [];

  Future<void> register({required String name, required String email}) async {
    final result = await barberRepository.getAllCompanies();

    // final dto = (
    //   name: name,
    //   email: email,
    //   openingDays: openingDays,
    //   openingHours: openingHours
    // );

    switch (result) {
      case Success():
        barberUnits = result.value;
        emit(BarberSuccess());
      case Failure():
    }
  }

  Future<void> getAllCompanies() async {
    emit(BarberLoading());
    final result = await barberRepository.getAllCompanies();

    switch (result) {
      case Success():
        barberUnits = result.value;
        emit(BarberSuccess());
      case Failure():
    }
  }
}
