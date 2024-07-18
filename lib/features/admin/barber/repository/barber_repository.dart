import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:la_barber/core/exceptions/repository_exception.dart';
import 'package:la_barber/features/admin/barber/repository/models/barber_model.dart';
import 'package:la_barber/core/exceptions/auth_exception.dart';
import 'package:la_barber/core/restClient/either.dart';
import 'package:la_barber/core/restClient/rest_client.dart';
import 'package:la_barber/features/admin/barbershop/repository/models/via_cep_model.dart';

class BarberRepository {
  final RestClient _restClient;
  BarberRepository({required RestClient restClient}) : _restClient = restClient;

  Future<Either<AuthException, List<BarberModel>>> getAllBarbers(int companyId) async {
    try {
      final Response response = await _restClient.auth.get(
        '/api/Barber/GetAllBarbers?barberUnitId=$companyId',
      );
      var user = BarberModel.fromList(response.data);
      return Success(user);
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response response = e.response!;
        if (response.statusCode == 400) {
          log('Erro ao buscar Barbeiros', error: e, stackTrace: s);
          return Failure(AuthUnauthorizedException());
        }
      }
      log('Erro ao buscar Barbeiros', error: e, stackTrace: s);
      return Failure(AuthError(message: 'Erro ao buscar Barbeiros'));
    }
  }

  Future<Either<AuthException, String>> cadastrarColaborador(BarberModel barber) async {
    try {
      final Response response = await _restClient.auth.post(
        '/api/Barber/Create',
        data: barber.toMap(),
      );
      if (response.statusCode == 201) {
        return Success(response.data);
      } else {
        return Failure(AuthError(message: 'Erro ao Cadastrar colaborador'));
      }
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response response = e.response!;
        if (response.statusCode == 400) {
          log('Erro ao Cadastrar colaborador - ${e.message}', error: e, stackTrace: s);
          return Failure(AuthUnauthorizedException());
        }
      }
      log('Erro ao Cadastrar colaborador', error: e, stackTrace: s);
      return Failure(AuthError(message: 'Erro ao Cadastrar colaborador - ${e.message}'));
    }
  }

  Future<Either<AuthException, String>> editarColaborador(BarberModel barber) async {
    try {
      final Response response = await _restClient.auth.put(
        '/api/Barber/Update',
        data: barber.toMapUpdate(),
      );
      if (response.statusCode == 204) {
        return Success(response.data);
      } else {
        return Failure(AuthError(message: 'Erro ao Editar colaborador'));
      }
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response response = e.response!;
        if (response.statusCode == 400) {
          log('Erro ao Editar colaborador - ${e.message}', error: e, stackTrace: s);
          return Failure(AuthUnauthorizedException());
        }
      }
      log('Erro ao Editar colaborador', error: e, stackTrace: s);
      return Failure(AuthError(message: 'Erro ao Editar colaborador - ${e.message}'));
    }
  }

  Future<Either<RepositoryException, ViaCEPModel>> getByCEP(String cep) async {
    String viacepBaseUrl = 'https://viacep.com.br/ws';
    try {
      final Response response = await _restClient.unAuth.get("$viacepBaseUrl/$cep/json");

      if (response.statusCode == 200) {
        var responseCep = ViaCEPModel.fromJson(response.data);
        return Success(responseCep);
      } else {
        return Failure(RepositoryError(message: 'Erro ao Cadastrar Unidade'));
      }
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response response = e.response!;
        if (response.statusCode == 400) {
          log('Erro ao buscar CEP', error: e, stackTrace: s);
          return Failure(RepositoryException(message: 'Erro ao buscar CEP - ${e.message}'));
        }
      }
      return Failure(RepositoryException(message: 'Erro ao tentar buscar CEP - ${e.message}'));
    }
  }
}
