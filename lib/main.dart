import 'package:flutter/material.dart';
import 'package:la_barber/auth/presentation/pages/cadastro_page.dart';
import 'package:la_barber/auth/presentation/pages/login_page.dart';
import 'package:la_barber/core/di/di.dart';
import 'package:la_barber/core/ui/barbershop_theme.dart';

Future<void> main() async {
  await configureInjection();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: BarbershopTheme.themeData,
      initialRoute: '/login',
      routes: {
        '/cadastro': (context) => const CadastroPage(),
        '/login': (context) => LoginPage(authCubit: getIt()),
      },
      home: const Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
