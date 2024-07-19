import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:la_barber/core/constants/routes.dart';
import 'package:la_barber/core/ui/helpers/context_extension.dart';
import 'package:la_barber/core/ui/styles/app_color.dart';
import 'package:la_barber/core/ui/widgets/custom_button.dart';
import 'package:la_barber/features/admin/barbershop/presentation/cubit/barbershop_cubit.dart';
import 'package:la_barber/features/admin/barbershop/repository/models/barbershop_model.dart';
import 'package:la_barber/features/admin/servicos/presentation/widgets/dias_funcionamento_widget.dart';
import 'package:la_barber/features/admin/servicos/presentation/widgets/services_detail_tile.dart';

class BarbershopDetalhesPage extends StatefulWidget {
  final BarbershopCubit barbershopCubit;
  final BarbershopModel barbershop;
  const BarbershopDetalhesPage({
    super.key,
    required this.barbershopCubit,
    required this.barbershop,
  });

  @override
  State<BarbershopDetalhesPage> createState() => _BarbershopDetalhesPageState();
}

class _BarbershopDetalhesPageState extends State<BarbershopDetalhesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg100,
      appBar: AppBar(
        title: Text(widget.barbershop.name.toUpperCase()),
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CachedNetworkImage(
                  imageUrl: widget.barbershop.logo,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Image.asset('assets/images/logo.png'),
                ),
              ),
              const SizedBox(height: 20),
              ServicesDetailTile(
                title: 'Endereco',
                content:
                    'Rua: ${widget.barbershop.street}, ${widget.barbershop.number}, ${widget.barbershop.city} - ${widget.barbershop.state}',
                fontSize: 16,
              ),
              ServicesDetailTile(
                title: 'Telefone',
                content: widget.barbershop.phone,
                fontSize: 16,
              ),
              GroupedWorkingHoursWidget(
                workingHours: widget.barbershop.workingHours ?? [],
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
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
              context.pushNamed(Routes.barbershopEdit, arguments: widget.barbershop);
            },
          ),
        ),
      ),
    );
  }
}
