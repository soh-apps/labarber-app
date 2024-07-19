import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:la_barber/core/constants/routes.dart';
import 'package:la_barber/core/ui/styles/app_color.dart';
import 'package:la_barber/core/ui/widgets/custom_button.dart';
import 'package:la_barber/features/admin/servicos/presentation/widgets/services_detail_tile.dart';
import 'package:la_barber/features/admin/servicos/repository/models/servico_model.dart';

class ServicoDetalhesPage extends StatelessWidget {
  final ServicoModel servico;
  const ServicoDetalhesPage({
    super.key,
    required this.servico,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg100,
      appBar: AppBar(
        title: Text(servico.nome.toUpperCase()),
        backgroundColor: AppColor.bg100,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.pushNamed(context, Routes.servicoEditPage, arguments: servico);
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
                  imageUrl: servico.urlImagem,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Image.asset('assets/images/logo.png'),
                ),
              ),
              const SizedBox(height: 20),
              ServicesDetailTile(title: 'Nome', content: servico.nome),
              ServicesDetailTile(title: 'Tempo de Serviço', content: '${servico.tempoServico} minutos'),
              ServicesDetailTile(
                  title: 'Valor do Serviço', content: 'R\$ ${servico.valor.toStringAsFixed(2).replaceAll('.', ',')}'),
              ServicesDetailTile(
                  title: 'Valor da Comissão',
                  content: 'R\$ ${servico.comissao.toStringAsFixed(2).replaceAll('.', ',')}'),
              ServicesDetailTile(title: 'Porcentagem Comissão', content: '${servico.porcentagemComissao}%'),
              ServicesDetailTile(title: 'Descrição do Serviço', content: servico.descricao ?? ''),
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
              Navigator.pushNamed(context, Routes.servicoEditPage, arguments: servico);
            },
          ),
        ),
      ),
    );
  }
}
