import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_barber/core/constants/routes.dart';
import 'package:la_barber/core/ui/barbershop_icons.dart';
import 'package:la_barber/core/ui/constants.dart';
import 'package:la_barber/core/ui/helpers/context_extension.dart';
import 'package:la_barber/features/admin/barber/presentation/cubit/barber_cubit.dart';
import 'package:la_barber/features/admin/barber/presentation/widgets/barber_tile.dart';
import 'package:la_barber/features/admin/barbershop/presentation/cubit/barbershop_cubit.dart';
import 'package:la_barber/features/admin/barbershop/presentation/widgets/barbershop_header_widget.dart';
import 'package:la_barber/features/admin/barbershop/repository/models/barbershop_model.dart';
import 'package:la_barber/utils/mocks.dart';

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
  late BarbershopModel barberShop;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    barberShop = ModalRoute.of(context)!.settings.arguments as BarbershopModel;
    widget.barberCubit.getAllBarbers(barberShop.id);
  }

  @override
  Widget build(BuildContext context) {
    log(barberShop.name);
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          child: Column(
            children: [
              const BarbershopHeaderWidget(),
              BlocBuilder<BarberCubit, BarberState>(
                bloc: widget.barberCubit,
                builder: (context, state) {
                  if (state is BarbershopLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is BarbershopSuccess) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: widget.barberCubit.barbers.length,
                        itemBuilder: (BuildContext context, int index) {
                          return BarberTile(barber: widget.barberCubit.barbers[index]);
                        },
                      ),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: Mocks.barberList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return BarberTile(barber: Mocks.barberList[index]);
                        },
                      ),
                    );
                    // return const Center(child: Text('Error'));
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
            context.pushNamed(Routes.adminRegisterBarber, arguments: barberShop);
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
