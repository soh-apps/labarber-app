import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:la_barber/features/admin/barber/repository/models/barber_model.dart';
import 'package:la_barber/core/exceptions/auth_exception.dart';
import 'package:la_barber/core/restClient/either.dart';
import 'package:la_barber/core/restClient/rest_client.dart';

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
      if (response.statusCode == 200) {
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
}
