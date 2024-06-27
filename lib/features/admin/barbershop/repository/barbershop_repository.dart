import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:la_barber/features/admin/barbershop/repository/models/barbershop_model.dart';
import 'package:la_barber/core/exceptions/auth_exception.dart';
import 'package:la_barber/core/restClient/either.dart';
import 'package:la_barber/core/restClient/rest_client.dart';

class BarbershopRepository {
  final RestClient _restClient;
  BarbershopRepository({required RestClient restClient}) : _restClient = restClient;

  Future<Either<AuthException, List<BarbershopModel>>> getAllCompanies() async {
    try {
      final Response response = await _restClient.auth.get(
        '/api/BarberUnit/GetBarberUnitsByCompany/1',
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

  Future<Either<AuthException, String>> cadastrarBarbearia(BarbershopModel barberShop) async {
    try {
      final Response response = await _restClient.auth.post(
        '/api/BarberShop/CreateBarberShop',
        data: barberShop.toMap(),
      );
      if (response.statusCode == 200) {
        return Success(response.data);
      } else {
        return Failure(AuthError(message: 'Erro ao Cadastrar Unidade'));
      }
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response response = e.response!;
        if (response.statusCode == 400) {
          log('Erro ao Cadastrar Unidade - ${e.message}', error: e, stackTrace: s);
          return Failure(AuthUnauthorizedException());
        }
      }
      log('Erro ao Cadastrar colaborador', error: e, stackTrace: s);
      return Failure(AuthError(message: 'Erro ao Cadastrar Unidade - ${e.message}'));
    }
  }
}
