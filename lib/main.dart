import 'package:flutter/material.dart';
import 'package:la_barber/features/common/auth/model/user_model.dart';
import 'package:la_barber/features/admin/home/home_adm_page.dart';
import 'package:la_barber/features/common/auth/presentation/pages/cadastro_page.dart';
import 'package:la_barber/features/common/auth/presentation/pages/login_page.dart';
import 'package:la_barber/core/di/di.dart';
import 'package:la_barber/core/ui/barbershop_nav_global_key.dart';
import 'package:la_barber/core/ui/barbershop_theme.dart';

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: BarbershopTheme.themeData,
      initialRoute: '/home/adm',
      navigatorKey: BarbershopNavGlobalKey.instance.navKey,
      routes: {
        '/cadastro': (context) => const CadastroPage(),
        '/login': (context) => LoginPage(authCubit: getIt()),

        '/home/adm': (_) => const HomeAdmPage(),
        //     '/home/employee': (_) => const HomeEmployeePage(),
      },
      home: const Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
