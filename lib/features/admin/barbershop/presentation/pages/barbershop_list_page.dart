import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_barber/core/constants/routes.dart';
import 'package:la_barber/core/ui/barbershop_icons.dart';
import 'package:la_barber/core/ui/constants.dart';
import 'package:la_barber/core/ui/helpers/context_extension.dart';
import 'package:la_barber/features/admin/barbershop/presentation/cubit/barbershop_cubit.dart';
import 'package:la_barber/features/admin/barbershop/presentation/widgets/barbershop_header_widget.dart';
import 'package:la_barber/features/admin/barbershop/presentation/widgets/barbershop_tile.dart';
import 'package:la_barber/features/admin/widgets/drawer_admin_widget.dart';

class BarbershopListPage extends StatefulWidget {
  final BarbershopCubit barbershopCubit;

  const BarbershopListPage({
    super.key,
    required this.barbershopCubit,
  });

  @override
  State<BarbershopListPage> createState() => _BarbershopListPageState();
}

class _BarbershopListPageState extends State<BarbershopListPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    widget.barbershopCubit.getAllCompanies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawer: const DrawerAdminWidget(),
        body: SizedBox(
          child: Column(
            children: [
              BarbershopHeaderWidget(scaffoldKey: scaffoldKey),
              BlocBuilder<BarbershopCubit, BarbershopState>(
                bloc: widget.barbershopCubit,
                builder: (context, state) {
                  if (state is BarbershopLoading) {
                    return const Expanded(child: Center(child: CircularProgressIndicator()));
                  } else if (state is BarbershopSuccess) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: widget.barbershopCubit.barberUnits.length,
                        itemBuilder: (BuildContext context, int index) {
                          return BarbershopHomeTile(barberShop: widget.barbershopCubit.barberUnits[index]);
                        },
                      ),
                    );
                  } else {
                    return RefreshIndicator(
                      onRefresh: widget.barbershopCubit.getAllCompanies,
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
            context.pushNamed(Routes.adminRegisterBarbershop);
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
