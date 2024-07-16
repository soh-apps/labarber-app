import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:la_barber/core/exceptions/repository_exception.dart';
import 'package:la_barber/features/admin/barbershop/repository/models/barbershop_model.dart';
import 'package:la_barber/core/exceptions/auth_exception.dart';
import 'package:la_barber/core/restClient/either.dart';
import 'package:la_barber/core/restClient/rest_client.dart';
import 'package:la_barber/features/admin/barbershop/repository/models/via_cep_model.dart';

class BarbershopRepository {
  final RestClient _restClient;
  BarbershopRepository({required RestClient restClient}) : _restClient = restClient;

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

  Future<Either<AuthException, BarbershopModel>> getBarberShopData(int companyId) async {
    try {
      final Response response = await _restClient.auth.get(
        '/api/BarberUnit/$companyId',
      );
      var barberShop = BarbershopModel.fromMap(response.data);
      return Success(barberShop);
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response response = e.response!;
        if (response.statusCode == 400) {
          log('Erro ao busca dados da Barbearia', error: e, stackTrace: s);
          return Failure(AuthUnauthorizedException());
        }
      }
      log('Erro ao buscar Barbeiros', error: e, stackTrace: s);
      return Failure(AuthError(message: 'Erro ao buscar dados da Barbearia'));
    }
  }

  Future<Either<AuthException, List<BarbershopModel>>> getAllCompanies() async {
    try {
      final Response response = await _restClient.auth.get(
        '/api/BarberUnit/GetBarberUnitsByCompany',
      );
      var user = BarbershopModel.fromList(response.data);
      return Success(user);
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response response = e.response!;
        if (response.statusCode == 400) {
          log('Erro ao buscar Unidades', error: e, stackTrace: s);
          return Failure(AuthUnauthorizedException());
        }
      }
      log('Erro ao buscar Unidades', error: e, stackTrace: s);
      return Failure(AuthError(message: 'Erro ao realizar login'));
    }
  }

  Future<Either<RepositoryException, String>> cadastrarBarbearia(BarbershopModel barberShop) async {
    try {
      final Response response = await _restClient.auth.post(
        '/api/BarberUnit/Create',
        data: barberShop.toMapv0(),
      );
      if (response.statusCode == 201) {
        return Success(response.data);
      } else {
        return Failure(RepositoryError(message: 'Erro ao Cadastrar Unidade'));
      }
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response response = e.response!;
        if (response.statusCode == 400) {
          log('Erro ao Cadastrar Unidade - ${e.message}', error: e, stackTrace: s);
          return Failure(RepositoryException(message: 'Erro ao Cadastrar Unidade - ${e.message}'));
        }
      }
      log('Erro ao Cadastrar Unidade', error: e, stackTrace: s);
      return Failure(RepositoryError(message: 'Erro ao Cadastrar Unidade - ${e.message}'));
    }
  }

  Future<Either<RepositoryException, String>> editarBarbearia(BarbershopModel barberShop) async {
    try {
      final Response response = await _restClient.auth.post(
        '/api/BarberUnit/Update',
        data: barberShop.toMapv0(),
      );
      if (response.statusCode == 201) {
        return Success(response.data);
      } else {
        return Failure(RepositoryError(message: 'Erro ao Editar Unidade'));
      }
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response response = e.response!;
        if (response.statusCode == 400) {
          log('Erro ao Editar Unidade - ${e.message}', error: e, stackTrace: s);
          return Failure(RepositoryException(message: 'Erro ao Editar Unidade - ${e.message}'));
        }
      }
      log('Erro ao Editar Unidade', error: e, stackTrace: s);
      return Failure(RepositoryError(message: 'Erro ao Editar Unidade - ${e.message}'));
    }
  }
}
