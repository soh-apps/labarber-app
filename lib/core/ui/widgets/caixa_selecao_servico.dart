// ignore_for_file: public_member_api_docs, sort_constructors_first, unrelated_type_equality_checks

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:la_barber/core/ui/styles/app_color.dart';
import 'package:la_barber/features/admin/servicos/repository/models/servico_model.dart';

class CaixaSelecaoServico extends StatelessWidget {
  final ServicoModel servico;
  final ValueChanged<bool> onChanged;
  final bool isFirst;
  final bool isLast;

  const CaixaSelecaoServico({
    super.key,
    required this.servico,
    required this.onChanged,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    double borderTop = isFirst ? 12 : 0;
    double borderBottom = isLast ? 12 : 0;
    return GestureDetector(
      onTap: () {
        onChanged(!servico.isAtivo);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        decoration: ShapeDecoration(
          color: servico.isAtivo ? Colors.green : AppColor.bg200,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(borderTop),
            topRight: Radius.circular(borderTop),
            bottomLeft: Radius.circular(borderBottom),
            bottomRight: Radius.circular(borderBottom),
          )),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: FittedBox(
                  child: Text(
                    '${servico.nome} \n ${UtilBrasilFields.obterReal(servico.valor)}',
                    style: GoogleFonts.poppins(
                      color: servico.isAtivo ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                  ),
                ),
              ),
            ),
            Checkbox(
              value: servico.isAtivo,
              side: const BorderSide(width: 2),
              onChanged: (value) {
                onChanged(value!);
              },
              activeColor: AppColor.corSecundaria, // Cor do checkbox quando marcado
              checkColor: Colors.white, // Cor do sinal de marcação dentro do checkbox
              shape: const CircleBorder(), // Formato do checkbox
            ),
          ],
        ),
      ),
    );
  }
}
