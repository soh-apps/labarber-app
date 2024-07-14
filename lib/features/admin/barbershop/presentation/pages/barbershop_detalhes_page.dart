import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:la_barber/core/ui/styles/app_color.dart';
import 'package:la_barber/core/ui/widgets/custom_button.dart';
import 'package:la_barber/features/admin/barbershop/presentation/cubit/barbershop_cubit.dart';
import 'package:la_barber/features/admin/barbershop/repository/models/barbershop_model.dart';
import 'package:la_barber/features/admin/servicos/presentation/widgets/dias_funcionamento_widget.dart';
import 'package:la_barber/features/admin/servicos/presentation/widgets/services_detail_tile.dart';

class BarbershopDetalhesPage extends StatefulWidget {
  final BarbershopCubit barbershopCubit;
  const BarbershopDetalhesPage({
    super.key,
    required this.barbershopCubit,
  });

  @override
  State<BarbershopDetalhesPage> createState() => _BarbershopDetalhesPageState();
}

class _BarbershopDetalhesPageState extends State<BarbershopDetalhesPage> {
  late BarbershopModel barbershop;
  @override
  void didChangeDependencies() {
    barbershop = ModalRoute.of(context)!.settings.arguments as BarbershopModel;
    widget.barbershopCubit.getBarbershopDetail(barbershop.id);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg100,
      appBar: AppBar(
        title: Text(barbershop.name.toUpperCase()),
        backgroundColor: AppColor.bg100,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigator.pushNamed(context, Routes.servicoEditPage, arguments: servico);
            },
          ),
        ],
      ),
      body: BlocBuilder<BarbershopCubit, BarbershopState>(
        bloc: widget.barbershopCubit,
        builder: (context, state) {
          if (state is BarbershopLoading) {
            return const Expanded(child: Center(child: CircularProgressIndicator()));
          } else if (state is BarbershopActualSuccess) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CachedNetworkImage(
                        imageUrl: barbershop.logo,
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Image.asset('assets/images/logo.png'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ServicesDetailTile(
                      title: 'Endereco',
                      content:
                          'Rua: ${state.barbershop.street}, ${state.barbershop.number}, ${state.barbershop.city} - ${state.barbershop.state}',
                      fontSize: 16,
                    ),
                    ServicesDetailTile(
                      title: 'Telefone',
                      content: state.barbershop.phone,
                      fontSize: 16,
                    ),

                    GroupedWorkingHoursWidget(
                      workingHours: state.barbershop.workingHours ?? [],
                    ),
                    // ServicesDetailTile(title: 'Tempo de Serviço', content: '${servico.tempoServico} minutos'),
                    // ServicesDetailTile(title: 'Valor do Serviço', content: 'R\$ ${servico.valor.toStringAsFixed(2)}'),
                    // ServicesDetailTile(title: 'Valor da Comissão', content: 'R\$ ${servico.comissao.toStringAsFixed(2)}'),
                    // ServicesDetailTile(title: 'Porcentagem Comissão', content: '${servico.porcentagemComissao}%'),
                    // ServicesDetailTile(title: 'Descrição do Serviço', content: servico.descricao ?? ''),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            );
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                await widget.barbershopCubit.getBarbershopDetail(barbershop.id);
              },
              child: SingleChildScrollView(
                physics:
                    const AlwaysScrollableScrollPhysics(), // Isso garante que o RefreshIndicator funcione mesmo que não haja scroll.
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height / 2, // Isso garante que o Container ocupe a tela toda.
                  child: const Center(
                    child: Text('Error'),
                  ),
                ),
              ),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: CustomButton(
            paddingHorizontal: 12,
            text: 'Editar',
            onPressed: () {
              // Navigator.pushNamed(context, Routes.servicoEditPage, arguments: servico);
            },
          ),
        ),
      ),
    );
  }
}
