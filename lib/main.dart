import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_barber/core/ui/helpers/context_extension.dart';
import 'package:la_barber/core/ui/helpers/messages.dart';
import 'package:la_barber/features/admin/barbershop/presentation/barbershop_register_page.dart';
import 'package:la_barber/features/admin/home/home_adm_page.dart';
import 'package:la_barber/features/common/auth/presentation/cubits/auth_cubit.dart';
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
  final AuthCubit authCubit = getIt();

  @override
  void initState() {
    super.initState();
    authCubit.verifyIsLogged();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: BarbershopTheme.themeData,
        initialRoute: '/login',
        navigatorKey: BarbershopNavGlobalKey.instance.navKey,
        routes: {
          '/login': (context) => LoginPage(authCubit: authCubit),
          '/home/adm': (_) => HomeAdmPage(
                barbershopCubit: getIt(),
              ),
          '/register/barbershop': (_) => BarbershopRegisterPage(
                barbershopCubit: getIt(),
              ),
        },
        home: BlocListener<AuthCubit, AuthState>(
          bloc: authCubit,
          listener: (context, state) {
            if (state is AuthStateError) {
              context.showError(state.errorMessage);

              context.hideLoadingDialog(context); // Pop dialog
            } else if (state is AuthStateSuccess) {
              // hideLoadingDialog(context); // Pop dialog
              context.showSuccess('Deu certo o Login');
              Navigator.of(context).pushNamedAndRemoveUntil('/home/adm', (route) => false);
            } else if (state is AuthStateLoaging) {
              context.showLoadingDialog(context, message: "Loading");

              //  BarbershopLoader();
            }
          },
          child: const Scaffold(
            body: Center(
              child: Text('Hello World!'),
            ),
          ),
        ));
  }
}
