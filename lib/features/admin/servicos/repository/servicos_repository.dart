import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:la_barber/core/exceptions/auth_exception.dart';
import 'package:la_barber/core/restClient/either.dart';
import 'package:la_barber/core/restClient/rest_client.dart';
import 'package:la_barber/features/admin/servicos/repository/models/servico_model.dart';

class ServicosRepository {
  final RestClient _restClient;
  ServicosRepository({required RestClient restClient}) : _restClient = restClient;

  Future<Either<AuthException, List<ServicoModel>>> getAllServicos(int companyId) async {
    try {
      final Response response = await _restClient.auth.get(
        '/api/Servicos/GetAllServices?barberUnitId=$companyId',
      );
      var user = ServicoModel.fromList(response.data);
      return Success(user);
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response response = e.response!;
        if (response.statusCode == 400) {
          log('Erro ao buscar Servicos', error: e, stackTrace: s);
          return Failure(AuthUnauthorizedException());
        }
      }
      log('Erro ao buscar Servicos', error: e, stackTrace: s);
      return Failure(AuthError(message: 'Erro ao buscar Servicos'));
    }
  }

  Future<Either<AuthException, String>> cadastrarServico(ServicoModel barber) async {
    try {
      final Response response = await _restClient.auth.post(
        '/api/Servicos/Create',
        data: barber.toMap(),
      );
      if (response.statusCode == 200) {
        return Success(response.data);
      } else {
        return Failure(AuthError(message: 'Erro ao Cadastrar Servico'));
      }
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response response = e.response!;
        if (response.statusCode == 400) {
          log('Erro ao Cadastrar Servico - ${e.message}', error: e, stackTrace: s);
          return Failure(AuthUnauthorizedException());
        }
      }
      log('Erro ao Cadastrar colaborador', error: e, stackTrace: s);
      return Failure(AuthError(message: 'Erro ao Cadastrar Servico - ${e.message}'));
    }
  }
}
