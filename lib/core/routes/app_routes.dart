import 'package:flutter/widgets.dart';
import 'package:la_barber/core/constants/routes.dart';
import 'package:la_barber/core/di/di.dart';
import 'package:la_barber/features/admin/barber/repository/models/barber_model.dart';
import 'package:la_barber/features/admin/barbershop/presentation/pages/barbershop_list_page.dart';
import 'package:la_barber/features/common/auth/presentation/pages/login_page.dart';
import 'package:la_barber/features/admin/agendamento/presentation/pages/agendamento_rapido_page.dart';
import 'package:la_barber/features/admin/barber/presentation/pages/barber_detail_page.dart';
import 'package:la_barber/features/admin/barber/presentation/pages/barber_edit_page.dart';
import 'package:la_barber/features/admin/barber/presentation/pages/barber_list_page.dart';
import 'package:la_barber/features/admin/barber/presentation/pages/barber_register_page.dart';
import 'package:la_barber/features/admin/barbershop/presentation/pages/barbershop_detalhes_page.dart';
import 'package:la_barber/features/admin/barbershop/presentation/pages/barbershop_edit_page.dart';
import 'package:la_barber/features/admin/barbershop/presentation/pages/barbershop_register_page.dart';
import 'package:la_barber/features/admin/servicos/presentation/pages/servico_detalhes_page.dart';
import 'package:la_barber/features/admin/servicos/presentation/pages/servico_edit_page.dart';
import 'package:la_barber/features/admin/servicos/presentation/pages/servico_register_page.dart';
import 'package:la_barber/features/admin/servicos/presentation/pages/servicos_list_page.dart';

class AppRoutes {
  static Object? routeArguments(BuildContext context) {
    return ModalRoute.of(context)?.settings.arguments;
  }

  static Map<String, Widget Function(BuildContext)> routes = {
    for (_AppRouteItem routeItem in _allRoutesList) routeItem.routeName: routeItem.pageBuilder
  };

  static final List<_AppRouteItem> _allRoutesList = [
    // Auth
    _AppRouteItem(Routes.login, (context) => LoginPage(authCubit: getIt())),

    // BarberShop
    _AppRouteItem(Routes.barbershopList, (context) => BarbershopListPage(barbershopCubit: getIt())),
    _AppRouteItem(Routes.barbershopRegister, (context) => BarbershopRegisterPage(barbershopCubit: getIt())),
    _AppRouteItem(Routes.barbershopEdit, (context) => BarbershopEditPage(barbershopCubit: getIt())),
    _AppRouteItem(Routes.barbershopDetail, (context) => BarbershopDetalhesPage(barbershopCubit: getIt())),

    // Barber
    _AppRouteItem(Routes.barberRegister, (context) => BarberRegisterPage(barberCubit: getIt())),
    _AppRouteItem(Routes.barberEdit, (context) => BarberEditPage(barberCubit: getIt())),
    _AppRouteItem(Routes.barberListPage, (context) => BarberListPage(barberCubit: getIt())),
    _AppRouteItem(
        Routes.barberDetailPage,
        (context) => BarberDetailPage(
              barber: routeArguments(context) as BarberModel,
            )),

    // Servicos
    _AppRouteItem(Routes.servicoListPage, (context) => ServicosListPage(servicoCubit: getIt())),
    _AppRouteItem(Routes.servicoRegisterPage, (context) => ServicoRegisterPage(servicoCubit: getIt())),
    _AppRouteItem(Routes.servicoDetailPage, (context) => const ServicoDetalhesPage()),
    _AppRouteItem(Routes.servicoEditPage, (context) => ServicoEditPage(servicoCubit: getIt())),

    // Agendamento
    _AppRouteItem(Routes.agendamentoRapidoPage, (context) => AgendamentoRapidoPage(agendamentoCubit: getIt())),
  ];
}

class _AppRouteItem {
  final String routeName;
  final Widget Function(BuildContext) pageBuilder;

  _AppRouteItem(this.routeName, this.pageBuilder);
}
