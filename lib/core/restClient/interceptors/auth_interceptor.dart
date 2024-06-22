import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:la_barber/core/constants/routes.dart';
import 'package:la_barber/core/di/di.dart';
import 'package:la_barber/core/ui/barbershop_nav_global_key.dart';
import 'package:la_barber/features/common/auth/model/user_model.dart';

class AuthInterceptor extends Interceptor {
  final authHeaderKey = 'Authorization';
  Future<String> _refreshToken() async {
    try {
      final token = getIt<UserModel>().token;
      final response = await Dio().post(
        'http://192.168.0.99:5270/Login/RefreshToken',
        data: {
          'credentialId': getIt<UserModel>().credentialId,
          'refreshToken': getIt<UserModel>().refreshToken,
        },
        options: Options(
          headers: {authHeaderKey: 'Bearer $token'},
        ),
      );
      final newToken = response.data['token'];
      return newToken;
    } catch (e) {
      // Lida com erros de refresh token, como redirecionar para a tela de login
      Navigator.of(BarbershopNavGlobalKey.instance.navKey.currentContext!)
          .pushNamedAndRemoveUntil(Routes.login, (route) => false);
      return '';
    }
  }

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final headers = options.headers;
    final extra = options.extra;

    headers.remove(authHeaderKey);

    if (extra case {'DIO_AUTH_KEY': true}) {
      final token = getIt<UserModel>().token;

      headers.addAll({authHeaderKey: 'Bearer $token'});
    }

    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final requestOptions = err.requestOptions;
    final response = err.response;

    if (requestOptions.extra case {'DIO_AUTH_KEY': true}) {
      if (response != null && response.statusCode == HttpStatus.unauthorized) {
        try {
          final newToken = await _refreshToken();
          if (newToken.isNotEmpty) {
            // Atualiza o token no UserModel
            getIt<UserModel>().token = newToken;

            // Adiciona o novo token no header da requisição original
            requestOptions.headers['Authorization'] = 'Bearer $newToken';

            // Refaz a requisição original
            final clonedRequest = await Dio().fetch(requestOptions);
            handler.resolve(clonedRequest);
            return;
          }
        } catch (e) {
          // Lida com erros de refresh token, como redirecionar para a tela de login
          Navigator.of(BarbershopNavGlobalKey.instance.navKey.currentContext!)
              .pushNamedAndRemoveUntil(Routes.login, (route) => false);
          return;
        }
      }
    }

    handler.reject(err);
  }
}
