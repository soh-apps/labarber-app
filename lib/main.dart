import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:la_barber/core/constants/routes.dart';
import 'package:la_barber/core/di/di.dart';
import 'package:la_barber/core/routes/app_routes.dart';
import 'package:la_barber/core/ui/barbershop_nav_global_key.dart';
import 'package:la_barber/core/ui/barbershop_theme.dart';
import 'package:la_barber/features/common/auth/presentation/cubits/auth_cubit.dart';

Future<void> main() async {
  await configureInjection();
  await initializeDateFormatting();
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
      initialRoute: Routes.login,
      navigatorKey: BarbershopNavGlobalKey.instance.navKey,
      routes: AppRoutes.routes,
      home: const Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
