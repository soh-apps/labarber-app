import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_barber/core/di/di.dart';
import 'package:la_barber/core/ui/barbershop_icons.dart';
import 'package:la_barber/core/ui/constants.dart';
import 'package:la_barber/features/admin/barber/presentation/cubit/barber_cubit.dart';
import 'package:la_barber/features/admin/barber/presentation/widgets/barber_header_widget.dart';
import 'package:la_barber/features/admin/barber/presentation/widgets/barber_tile.dart';
import 'package:la_barber/features/admin/widgets/drawer_admin_widget.dart';
import 'package:la_barber/features/common/auth/model/user_model.dart';

class BarberListPage extends StatefulWidget {
  final BarberCubit barberCubit;
  const BarberListPage({
    super.key,
    required this.barberCubit,
  });

  @override
  State<BarberListPage> createState() => _BarberListPageState();
}

class _BarberListPageState extends State<BarberListPage> {
  // late BarbershopModel barberShop;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (getIt<UserModel>().userType == UserType.admin) {
      // barberShop = ModalRoute.of(context)!.settings.arguments as BarbershopModel;
    } else {
      // barberShop = widget.barberCubit.barbershop ?? Mocks.companies[0];
    }

    // widget.barberCubit.getAllBarbers(barberShop.id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.barberCubit.getAllBarbers(0);
    if (getIt<UserModel>().userType == UserType.manager) {
      // Api que traz os dados da barbearia
    }
  }

  @override
  Widget build(BuildContext context) {
    // log(barberShop.name);
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawer: const DrawerAdminWidget(),
        body: SizedBox(
          child: Column(
            children: [
              BarberHeaderWidget(
                // title: barberShop.name,
                title: 'NomeBarbearia',
                scaffoldKey: scaffoldKey,
              ),
              BlocBuilder<BarberCubit, BarberState>(
                bloc: widget.barberCubit,
                builder: (context, state) {
                  if (state is BarberLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is BarberSuccess) {
                    if (widget.barberCubit.barbers.isEmpty) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          widget.barberCubit.getAllBarbers(0);
                        },
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: SizedBox(
                            height: MediaQuery.sizeOf(context).height / 2,
                            child: const Center(
                              child: Text('Nenhum barbeiro cadastrado'),
                            ),
                          ),
                        ),
                      );
                    } else {}
                    return Expanded(
                      child: ListView.builder(
                        itemCount: widget.barberCubit.barbers.length,
                        itemBuilder: (BuildContext context, int index) {
                          return BarberTile(barber: widget.barberCubit.barbers[index]);
                        },
                      ),
                    );
                  } else {
                    return RefreshIndicator(
                      onRefresh: () async {
                        widget.barberCubit.getAllBarbers(0);
                      },
                      child: SingleChildScrollView(
                        physics:
                            const AlwaysScrollableScrollPhysics(), // Isso garante que o RefreshIndicator funcione mesmo que não haja scroll.
                        child: SizedBox(
                          height:
                              MediaQuery.sizeOf(context).height / 2, // Isso garante que o Container ocupe a tela toda.
                          child: const Center(
                            child: Text('Error'),
                          ),
                        ),
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: ColorConstants.colorBrown,
          onPressed: () {
            // context.pushNamed(Routes.adminRegisterBarber, arguments: barberShop);
          },
          child: const CircleAvatar(
            backgroundColor: Colors.white,
            maxRadius: 12,
            child: Icon(
              BarbershopIcons.addEmplyeee,
              color: ColorConstants.colorBrown,
            ),
          ),
        ),
      ),
    );
  }
}
