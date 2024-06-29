import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_barber/core/constants/routes.dart';
import 'package:la_barber/core/ui/barbershop_icons.dart';
import 'package:la_barber/core/ui/constants.dart';
import 'package:la_barber/core/ui/helpers/context_extension.dart';
import 'package:la_barber/features/admin/barber/presentation/cubit/barber_cubit.dart';
import 'package:la_barber/features/admin/barber/presentation/widgets/barber_header_widget.dart';
import 'package:la_barber/features/admin/barber/presentation/widgets/barber_tile.dart';
import 'package:la_barber/features/admin/barbershop/repository/models/barbershop_model.dart';

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
              BarberHeaderWidget(title: barberShop.name),
              BlocBuilder<BarberCubit, BarberState>(
                bloc: widget.barberCubit,
                builder: (context, state) {
                  if (state is BarberLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is BarberSuccess) {
                    if (widget.barberCubit.barbers.isEmpty) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          widget.barberCubit.getAllBarbers(barberShop.id);
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
                        widget.barberCubit.getAllBarbers(barberShop.id);
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
