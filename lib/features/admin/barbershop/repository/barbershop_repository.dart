import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:la_barber/features/admin/barbershop/repository/models/barbershop_model.dart';
import 'package:la_barber/features/common/auth/model/user_model.dart';
import 'package:la_barber/core/exceptions/auth_exception.dart';
import 'package:la_barber/core/restClient/either.dart';
import 'package:la_barber/core/restClient/rest_client.dart';

class BarbershopRepository {
  final RestClient _restClient;
  BarbershopRepository({required RestClient restClient}) : _restClient = restClient;

  Future<Either<AuthException, UserModel>> login(String email, String password) async {
    try {
      final Response response = await _restClient.unAuth.post(
        '/Login',
        data: {
          'username': email,
          'password': password,
        },
      );
      var user = UserModel.fromMap(response.data);
      return Success(user);
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response response = e.response!;
        if (response.statusCode == 400) {
          log('Login ou senha inválidos', error: e, stackTrace: s);
          return Failure(AuthUnauthorizedException());
        }
      }
      log('Erro ao realizar login', error: e, stackTrace: s);
      return Failure(AuthError(message: 'Erro ao realizar login'));
    }
  }

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
}
