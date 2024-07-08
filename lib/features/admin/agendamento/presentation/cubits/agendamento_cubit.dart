import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:la_barber/features/admin/agendamento/repository/agendamento_repository.dart';
import 'package:la_barber/features/admin/agendamento/repository/model/agendamento_model.dart';
import 'package:la_barber/features/admin/barber/repository/barber_repository.dart';
import 'package:la_barber/features/admin/barber/repository/models/barber_model.dart';
import 'package:la_barber/features/admin/servicos/repository/models/servico_model.dart';
import 'package:la_barber/features/admin/servicos/repository/servicos_repository.dart';

import 'package:la_barber/utils/mocks.dart';

part 'agendamento_state.dart';

class AgendamentoCubit extends Cubit<AgendamentoState> {
  final AgendamentoRepository agendamentoRepository;
  final BarberRepository barberRepository;
  final ServicosRepository servicosRepository;
  AgendamentoCubit(
    this.agendamentoRepository,
    this.barberRepository,
    this.servicosRepository,
  ) : super(AgendamentoInitial());

  String mensagem = '';
  List<AgendamentoModel> agendamentos = [];
  List<ServicoModel> servicos = [];
  List<BarberModel> barbeiros = [];

  Future<void> getAllBarbers(int companyId) async {
    emit(AgendamentoLoading());
    // final result = await barberRepository.getAllBarbers(companyId);

    // switch (result) {
    //   case Success():
    //     barbeiros = result.value;
    //     emit(AgendamentoSuccess());
    //   case Failure():
    // }

    barbeiros = Mocks.barberList;
    emit(AgendamentoSuccess());
  }

  Future<void> getAllServicos(int companyId) async {
    emit(AgendamentoLoading());
    //   final result = await servicosRepository.getAllServicos(companyId);

    //   switch (result) {
    //     case Success():
    //       servicos = result.value;
    //       emit(ServicoSuccess());
    //     case Failure():
    //   }
    // }

    servicos = Mocks.servicosList;
    emit(AgendamentoSuccess());
  }

  // Future<void> registerAgendamento(AgendamentoModel servicos) async {
  //   final result = await servicosRepository.cadastrarAgendamento(servicos);

  //   switch (result) {
  //     case Success():
  //       mensagem = result.value;
  //       emit(AgendamentoSuccess());
  //     case Failure():
  //       mensagem = result.exception.message;
  //       emit(AgendamentoFailure(errorMessage: mensagem));
  //   }
  // }

  // Future<void> editarAgendamento(AgendamentoModel servicos) async {
  //   final result = await servicosRepository.editarAgendamento(servicos);

  //   switch (result) {
  //     case Success():
  //       mensagem = result.value;
  //       emit(AgendamentoSuccess());
  //     case Failure():
  //       mensagem = result.exception.message;
  //       emit(AgendamentoFailure(errorMessage: mensagem));
  //   }
  // }

  Future<void> getAllAgendamentos(int companyId) async {
    emit(AgendamentoLoading());
    //   final result = await servicosRepository.getAllAgendamentos(companyId);

    //   switch (result) {
    //     case Success():
    //       servicos = result.value;
    //       emit(AgendamentoSuccess());
    //     case Failure():
    //   }
    // }

    agendamentos = Mocks.agendamentosList;
    emit(AgendamentoSuccess());
  }
}
