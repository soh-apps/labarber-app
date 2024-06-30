import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:la_barber/core/ui/app_color.dart';
import 'package:la_barber/core/ui/barbershop_icons.dart';
import 'package:la_barber/core/ui/constants.dart';
import 'package:la_barber/core/ui/helpers/context_extension.dart';
import 'package:la_barber/features/admin/servicos/repository/models/servico_model.dart';

class ServicoTile extends StatelessWidget {
  final ServicoModel servico;

  const ServicoTile({
    super.key,
    required this.servico,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ColorConstants.colorBrown),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              image: DecorationImage(
                // image: switch (employee.avatar) {
                //   final avatar => NetworkImage(avatar),
                //   _ => const AssetImage(ImageConstants.avatar),
                // }
                image: AssetImage(ImageConstants.avatar),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: Text(
                    servico.nome,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Serviço: ${UtilBrasilFields.obterReal(servico.valor).toString()}',
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'comissão : ${UtilBrasilFields.obterReal(servico.comissao).toString()}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Center(
                        child: IconButton(
                          onPressed: () {
                            // context.pushNamed('/schedule', arguments: servico);
                          },
                          icon: const Icon(
                            BarbershopIcons.trash,
                            size: 28,
                            color: ColorConstants.colorRed,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
