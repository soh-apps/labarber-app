import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:la_barber/core/restClient/either.dart';

import 'package:la_barber/features/admin/servicos/repository/models/servico_model.dart';
import 'package:la_barber/features/admin/servicos/repository/servicos_repository.dart';
import 'package:la_barber/utils/mocks.dart';

part 'servico_state.dart';

class ServicoCubit extends Cubit<ServicoState> {
  final ServicosRepository servicosRepository;
  ServicoCubit(
    this.servicosRepository,
  ) : super(ServicoInitial());

  String mensagem = '';
  List<ServicoModel> servicos = [];

  Future<void> registerServico(ServicoModel servicos) async {
    final result = await servicosRepository.cadastrarServico(servicos);

    switch (result) {
      case Success():
        mensagem = result.value;
        emit(ServicoSuccess());
      case Failure():
        mensagem = result.exception.message;
        emit(ServicoFailure(errorMessage: mensagem));
    }
  }

  Future<void> getAllServicos(int companyId) async {
    emit(ServicoLoading());
    //   final result = await servicosRepository.getAllServicos(companyId);

    //   switch (result) {
    //     case Success():
    //       servicos = result.value;
    //       emit(ServicoSuccess());
    //     case Failure():
    //   }
    // }

    servicos = Mocks.servicosList;
    emit(ServicoSuccess());
  }
}
