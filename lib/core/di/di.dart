import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:la_barber/auth/presentation/cubits/auth_cubit.dart';
import 'package:la_barber/auth/repository/auth_repository.dart';
import 'package:la_barber/core/restClient/rest_client.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureInjection() async {
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // Auth
  getIt.registerLazySingleton<RestClient>(() => RestClient());
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepository(restClient: getIt<RestClient>()));
  getIt.registerLazySingleton<AuthCubit>(
      () => AuthCubit(getIt<AuthRepository>()));
  await getIt.allReady();

  log("FINALIZOU INJEÇÃO DE DEPENDÊNCIA");
}
