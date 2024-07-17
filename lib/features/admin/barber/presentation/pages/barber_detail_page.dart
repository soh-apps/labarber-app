import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:la_barber/core/constants/routes.dart';
import 'package:la_barber/core/ui/helpers/context_extension.dart';
import 'package:la_barber/core/ui/styles/app_color.dart';
import 'package:la_barber/core/ui/styles/text_styles_typography.dart';
import 'package:la_barber/core/ui/widgets/custom_button.dart';
import 'package:la_barber/features/admin/barber/repository/models/barber_model.dart';
import 'package:la_barber/features/admin/servicos/presentation/widgets/services_detail_tile.dart';

class BarberDetailPage extends StatefulWidget {
  const BarberDetailPage({super.key});

  @override
  State<BarberDetailPage> createState() => _BarberDetailPageState();
}

class _BarberDetailPageState extends State<BarberDetailPage> {
  late BarberModel barber;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    barber = ModalRoute.of(context)!.settings.arguments as BarberModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg100,
      appBar: AppBar(
        title: Text(barber.name.toUpperCase()),
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
                  imageUrl: barber.imageUrl ?? '',
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Image.asset('assets/images/logo.png'),
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  barber.name,
                  style: AppTextStyles.titleLarge(),
                ),
              ),
              const SizedBox(height: 12),
              ServicesDetailTile(title: 'Telefone', content: barber.name),
              ServicesDetailTile(title: 'E-mail', content: barber.email ?? ''),
              ServicesDetailTile(title: 'Cargo', content: barber.telefone ?? ''),
              const SizedBox(height: 80),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: CustomButton(
                  paddingHorizontal: 12,
                  text: 'Editar',
                  onPressed: () {
                    context.pushNamed(Routes.barberEdit, arguments: barber);
                    // Navigator.pushNamed(context, Routes.servicoEditPage, arguments: servico);
                  },
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: CustomButton(
                  paddingHorizontal: 12,
                  backgroundColor: Colors.red,
                  text: 'Excluir',
                  onPressed: () {
                    // Navigator.pushNamed(context, Routes.servicoEditPage, arguments: servico);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 12),
      //   child:
      // ),
    );
  }
}
