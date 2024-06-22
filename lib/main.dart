import 'package:flutter/material.dart';
import 'package:la_barber/core/di/di.dart';
import 'package:la_barber/core/ui/barbershop_nav_global_key.dart';
import 'package:la_barber/core/ui/barbershop_theme.dart';
import 'package:la_barber/features/admin/barbershop/presentation/pages/barbershop_list_page.dart';
import 'package:la_barber/features/admin/barbershop/presentation/pages/barbershop_register_page.dart';
import 'package:la_barber/features/admin/home/home_adm_page.dart';
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
    // authCubit.verifyIsLogged();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: BarbershopTheme.themeData,
      initialRoute: '/auth/login',
      navigatorKey: BarbershopNavGlobalKey.instance.navKey,
      routes: {
        '/auth/login': (context) => LoginPage(authCubit: authCubit),
        '/home/adm': (_) => HomeAdmPage(barbershopCubit: getIt()),
        '/home/barbershop': (_) => BarbershopListPage(barbershopCubit: getIt()),
        '/register/barbershop': (_) => BarbershopRegisterPage(
              barbershopCubit: getIt(),
            ),
      },
      home: const Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
