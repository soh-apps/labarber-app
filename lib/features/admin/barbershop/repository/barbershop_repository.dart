// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
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

  Future<Either<AuthException, UserModel>> getAllCompanies() async {
    try {
      final Response response = await _restClient.auth.get(
        '/Company/GetAllCompanies',
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

  // Future<UserModel?> entrarUsuario(
  //     {required String email, required String senha}) async {
  //   try {
  //     await _firebaseAuth.signInWithEmailAndPassword(
  //         email: email, password: senha);
  //   return FirebaseReturnModel(message:'OK', status: FirebaseReturnStatus.success ) ;

  //   } on FirebaseAuthException catch (e) {
  //     switch (e.message) {
  //       case 'An unknown error occurred: FirebaseError: Firebase: There is no user record corresponding to this identifier. The user may have been deleted. (auth/user-not-found).':
  //         return   FirebaseReturnModel(message:'O e-mail não está cadastrado', status: FirebaseReturnStatus.error ) ;
  //       case 'The password is invalid or the user does not have a password.':
  //         return  FirebaseReturnModel(message:'Senha incorreta.', status: FirebaseReturnStatus.error ) ;
  //     }
  //     return FirebaseReturnModel(message: e.message ?? '', status: FirebaseReturnStatus.error ) ;
  //   }
  // }
}
