// ignore_for_file: unused_field

import 'package:la_barber/core/restClient/rest_client.dart';

class AgendamentoRepository {
  final RestClient _restClient;
  AgendamentoRepository({required RestClient restClient}) : _restClient = restClient;

  // Future<Either<AuthException, List<ServicoModel>>> getAll(int companyId) async {
  //   try {
  //     final Response response = await _restClient.auth.get(
  //       '/api/Service/GetAllServices?barberUnitId=$companyId',
  //     );
  //     var user = ServicoModel.fromList(response.data);
  //     return Success(user);
  //   } on DioException catch (e, s) {
  //     if (e.response != null) {
  //       final Response response = e.response!;
  //       if (response.statusCode == 400) {
  //         log('Erro ao buscar Servicos', error: e, stackTrace: s);
  //         return Failure(AuthUnauthorizedException());
  //       }
  //     }
  //     log('Erro ao buscar Servicos', error: e, stackTrace: s);
  //     return Failure(AuthError(message: 'Erro ao buscar Servicos'));
  //   }
  // }

  // Future<Either<AuthException, String>> cadastrarServico(ServicoModel barber) async {
  //   try {
  //     final Response response = await _restClient.auth.post(
  //       '/api/Service/Create',
  //       data: barber.toMap(),
  //     );
  //     if (response.statusCode == 200) {
  //       return Success(response.data);
  //     } else {
  //       return Failure(AuthError(message: 'Erro ao Cadastrar Servico'));
  //     }
  //   } on DioException catch (e, s) {
  //     if (e.response != null) {
  //       final Response response = e.response!;
  //       if (response.statusCode == 400) {
  //         log('Erro ao Cadastrar Servico - ${e.message}', error: e, stackTrace: s);
  //         return Failure(AuthUnauthorizedException());
  //       }
  //     }
  //     log('Erro ao Cadastrar Servico', error: e, stackTrace: s);
  //     return Failure(AuthError(message: 'Erro ao Cadastrar Servico - ${e.message}'));
  //   }
  // }

  // Future<Either<AuthException, String>> editarServico(ServicoModel barber) async {
  //   try {
  //     final Response response = await _restClient.auth.put(
  //       '/api/Service/Edit',
  //       data: barber.toMap(),
  //     );
  //     if (response.statusCode == 200) {
  //       return Success(response.data);
  //     } else {
  //       return Failure(AuthError(message: 'Erro ao Editar Servico'));
  //     }
  //   } on DioException catch (e, s) {
  //     if (e.response != null) {
  //       final Response response = e.response!;
  //       if (response.statusCode == 400) {
  //         log('Erro ao Editar Servico - ${e.message}', error: e, stackTrace: s);
  //         return Failure(AuthUnauthorizedException());
  //       }
  //     }
  //     log('Erro ao Editar Servico', error: e, stackTrace: s);
  //     return Failure(AuthError(message: 'Erro ao Editar Servico - ${e.message}'));
  //   }
  // }
}
