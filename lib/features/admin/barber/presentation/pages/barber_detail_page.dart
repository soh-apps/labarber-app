import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:la_barber/core/constants/routes.dart';
import 'package:la_barber/core/ui/helpers/context_extension.dart';
import 'package:la_barber/core/ui/styles/app_color.dart';
import 'package:la_barber/core/ui/styles/text_styles_typography.dart';
import 'package:la_barber/core/ui/widgets/custom_button.dart';
import 'package:la_barber/core/utils/enums/user_status_enum.dart';
import 'package:la_barber/core/utils/enums/user_type_enum.dart';
import 'package:la_barber/features/admin/barber/repository/models/barber_model.dart';
import 'package:la_barber/features/admin/servicos/presentation/widgets/services_detail_tile.dart';

class BarberDetailPage extends StatelessWidget {
  final BarberModel barber;
  const BarberDetailPage({
    super.key,
    required this.barber,
  });

  // late BarberModel barber;
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
                  barber.name.toUpperCase(),
                  style: AppTextStyles.titleLarge(),
                ),
              ),
              const SizedBox(height: 12),
              Visibility(
                visible: barber.telefone != null && barber.telefone != '',
                child: ServicesDetailTile(title: 'Telefone', content: barber.telefone ?? ''),
              ),
              ServicesDetailTile(
                title: 'Cargo',
                content: UserTypeHelper.getTypeName(barber.userType),
              ),
              Visibility(
                visible: barber.state != null && barber.state != '',
                child: ServicesDetailTile(
                  title: 'Status',
                  content: UserStatusHelper.getStatusNameForInt(barber.status),
                ),
              ),
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
