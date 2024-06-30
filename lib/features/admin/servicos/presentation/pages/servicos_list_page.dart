import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_barber/core/constants/routes.dart';
import 'package:la_barber/core/ui/barbershop_icons.dart';
import 'package:la_barber/core/ui/constants.dart';
import 'package:la_barber/core/ui/helpers/context_extension.dart';
import 'package:la_barber/features/admin/barbershop/repository/models/barbershop_model.dart';
import 'package:la_barber/features/admin/servicos/presentation/cubit/servico_cubit.dart';
import 'package:la_barber/features/admin/servicos/presentation/widgets/servico_header_widget.dart';
import 'package:la_barber/features/admin/servicos/presentation/widgets/servico_tile.dart';
import 'package:la_barber/features/admin/widgets/drawer_admin_widget.dart';

class ServicosListPage extends StatefulWidget {
  final ServicoCubit servicoCubit;
  const ServicosListPage({
    super.key,
    required this.servicoCubit,
  });

  @override
  State<ServicosListPage> createState() => _ServicosListPageState();
}

class _ServicosListPageState extends State<ServicosListPage> {
  late BarbershopModel barberShop;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // barberShop = ModalRoute.of(context)!.settings.arguments as BarbershopModel;
    barberShop = BarbershopModel(
      id: 2,
      name: 'Barbearia do Zé',
      address: 'Rua do Zé, 123',
      phone: '123456789',
      email: '',
      logo: '',
      website: '',
      description: '',
    );
    widget.servicoCubit.getAllServicos(barberShop.id);
  }

  @override
  Widget build(BuildContext context) {
    log(barberShop.name);
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawer: const DrawerAdminWidget(),
        body: SizedBox(
          child: Column(
            children: [
              ServicoHeaderWidget(
                title: barberShop.name,
              ),
              BlocBuilder<ServicoCubit, ServicoState>(
                bloc: widget.servicoCubit,
                builder: (context, state) {
                  if (state is ServicoLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ServicoSuccess) {
                    if (widget.servicoCubit.servicos.isEmpty) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          widget.servicoCubit.getAllServicos(barberShop.id);
                        },
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: SizedBox(
                            height: MediaQuery.sizeOf(context).height / 2,
                            child: const Center(
                              child: Text('Nenhum serviço cadastrado!'),
                            ),
                          ),
                        ),
                      );
                    } else {}
                    return Expanded(
                      child: ListView.builder(
                        itemCount: widget.servicoCubit.servicos.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ServicoTile(servico: widget.servicoCubit.servicos[index]);
                        },
                      ),
                    );
                  } else {
                    return RefreshIndicator(
                      onRefresh: () async {
                        widget.servicoCubit.getAllServicos(barberShop.id);
                      },
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: SizedBox(
                          height: MediaQuery.sizeOf(context).height / 2,
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
            context.pushNamed(Routes.servicoRegisterPage, arguments: barberShop);
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
