import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:la_barber/core/local_secure_storage/local_secure_storage.dart';
import 'package:la_barber/features/admin/barber/presentation/cubit/barber_cubit.dart';
import 'package:la_barber/features/admin/barbershop/presentation/cubit/barbershop_cubit.dart';
import 'package:la_barber/features/admin/barbershop/repository/barber_repository.dart';
import 'package:la_barber/features/admin/barbershop/repository/barbershop_repository.dart';
import 'package:la_barber/features/common/auth/presentation/cubits/auth_cubit.dart';
import 'package:la_barber/features/common/auth/repository/auth_repository.dart';
import 'package:la_barber/core/restClient/rest_client.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureInjection() async {
  // Firebase
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // Storages
  getIt.registerLazySingleton<LocalSecureStorage>(() => LocalSecureStorage());

  // RestCLient
  getIt.registerLazySingleton<RestClient>(() => RestClient());

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository(restClient: getIt<RestClient>()));
  getIt.registerLazySingleton<BarbershopRepository>(() => BarbershopRepository(restClient: getIt<RestClient>()));
  getIt.registerLazySingleton<BarberRepository>(() => BarberRepository(restClient: getIt<RestClient>()));

  // Cubits
  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit(getIt<AuthRepository>(), getIt<LocalSecureStorage>()));
  getIt.registerFactory<BarbershopCubit>(() => BarbershopCubit(getIt<BarbershopRepository>()));
  getIt.registerFactory<BarberCubit>(() => BarberCubit(getIt<BarberRepository>()));

  await getIt.allReady();

  log("FINALIZOU INJEÇÃO DE DEPENDÊNCIA");
}
