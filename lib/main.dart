import 'package:flutter/material.dart';
import 'package:la_barber/core/constants/routes.dart';
import 'package:la_barber/core/di/di.dart';
import 'package:la_barber/core/ui/barbershop_nav_global_key.dart';
import 'package:la_barber/core/ui/barbershop_theme.dart';
import 'package:la_barber/features/admin/barber/presentation/pages/barber_list_page.dart';
import 'package:la_barber/features/admin/barber/presentation/pages/barber_register_page.dart';
import 'package:la_barber/features/admin/barbershop/presentation/pages/barbershop_list_page.dart';
import 'package:la_barber/features/admin/barbershop/presentation/pages/barbershop_register_page.dart';
import 'package:la_barber/features/admin/servicos/presentation/pages/servico_register_page.dart';
import 'package:la_barber/features/admin/servicos/presentation/pages/servicos_list_page.dart';
import 'package:la_barber/features/common/auth/presentation/cubits/auth_cubit.dart';
import 'package:la_barber/features/common/auth/presentation/pages/login_page.dart';

Future<void> main() async {
  await configureInjection();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final AuthCubit authCubit = getIt();

  @override
  void initState() {
    super.initState();
    authCubit.verifyLocalUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: BarbershopTheme.themeData,
      // initialRoute: Routes.login,
      initialRoute: Routes.servicoListPage,
      navigatorKey: BarbershopNavGlobalKey.instance.navKey,
      routes: {
        Routes.login: (context) => LoginPage(authCubit: authCubit),
        Routes.adminHomeBarberShop: (_) => BarbershopListPage(barbershopCubit: getIt()),
        Routes.adminRegisterBarber: (_) => BarberRegisterPage(barberCubit: getIt()),
        Routes.adminRegisterBarbershop: (_) => BarbershopRegisterPage(barbershopCubit: getIt()),
        Routes.barberListPage: (_) => BarberListPage(barberCubit: getIt()),
        Routes.servicoListPage: (_) => ServicosListPage(servicoCubit: getIt()),
        Routes.servicoRegisterPage: (_) => ServicoRegisterPage(servicoCubit: getIt()),
      },
      home: const Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
