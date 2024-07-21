import 'dart:developer';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:la_barber/core/ui/styles/app_color.dart';
import 'package:la_barber/core/utils/enums/agendamento_status_enum.dart';
import 'package:la_barber/features/admin/agendamento/presentation/widgets/botao_secundario.dart';

import 'package:la_barber/features/admin/agendamento/repository/model/agendamento_model.dart';

class DetalhesAgendamentoDia extends StatelessWidget {
  final String data;
  final String? idUsuario;
  final AgendamentoModel agendamento;
  // final List<AgendamentoModel> listaAgendamentosdoDia;

  const DetalhesAgendamentoDia({
    super.key,
    required this.data,
    this.idUsuario,
    required this.agendamento,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 98.0),
              child: Image.asset('assets/images/logo.png'),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 24,
                left: 24,
                top: 24,
                bottom: 0,
              ),
              child: Center(
                child: Text(
                  '',
                  // "Agendamentos do dia ${widget.listaAgendamentosdoDia.first.data?.day.toString() ?? ''}",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 40, left: 40, bottom: 18),
                  child: GestureDetector(
                      onTap: () async {
                        log(agendamento.toString());
                      },
                      child: Text(
                        agendamento.horario,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2.0,
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40, left: 40, bottom: 18),
                  child: GestureDetector(
                    onTap: () async {
                      log(agendamento.toString());
                    },
                    child: BotaoSecundario(
                      titulo: 'Barbeiro: ${agendamento.nomeBarbeiro}',
                      radius: 16,
                      corFundo: Colors.transparent,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40, left: 40, bottom: 22),
                  child: GestureDetector(
                    onTap: () async {
                      log(agendamento.toString());
                    },
                    child: BotaoSecundario(
                      titulo: 'Telefone Barbeiro:  ${agendamento.telefoneBarbeiro}',
                      radius: 16,
                      corFundo: Colors.transparent,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40, left: 40, bottom: 18),
                  child: GestureDetector(
                    onTap: () async {
                      log(agendamento.toString());
                    },
                    child: BotaoSecundario(
                      titulo: 'Cliente: ${agendamento.nomeCliente}',
                      radius: 16,
                      corFundo: Colors.transparent,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40, left: 40, bottom: 22),
                  child: GestureDetector(
                    onTap: () async {
                      log(agendamento.toString());
                    },
                    child: BotaoSecundario(
                      titulo: 'Telefone Cliente:  ${agendamento.telefoneCliente}',
                      radius: 16,
                      corFundo: Colors.transparent,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40, left: 40, bottom: 22),
                  child: GestureDetector(
                    onTap: () async {
                      log(agendamento.toString());
                    },
                    child: BotaoSecundario(
                      titulo: 'Total:    ${UtilBrasilFields.obterReal(agendamento.valorTotal)}',
                      radius: 16,
                      corFundo: Colors.transparent,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40, left: 40, bottom: 22),
                  child: GestureDetector(
                    onTap: () async {
                      log(agendamento.toString());
                    },
                    child: BotaoSecundario(
                      titulo: 'Status:    ${AgendamentoStatusHelper.getStatusName(agendamento.status)}',
                      radius: 16,
                      corFundo: Colors.transparent,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40, left: 40, bottom: 22),
                  child: GestureDetector(
                    onTap: () async {
                      log(agendamento.toString());
                    },
                    child: BotaoSecundario(
                      titulo: 'Serviços:    ${agendamento.servicos.join(', ')}',
                      radius: 16,
                      corFundo: Colors.transparent,
                    ),
                  ),
                ),
                Visibility(
                  visible: agendamento.status == AgendamentoStatus.agendado ||
                      agendamento.status == AgendamentoStatus.realizado,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12, right: 0, left: 0, bottom: 44),
                    child: ElevatedButton(
                      onPressed: () async {
                        AlertDialog(
                          title: const Text(
                            'Cancelar',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          content: const Text(
                            'Tem certeza que deseja realizar o cancelamento?',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () async {},
                              child: const Text(
                                'Sim',
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text(
                                'Fechar',
                              ),
                            ),
                          ],
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.corSecundaria,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        maximumSize: const Size(double.infinity, 80),
                        padding: const EdgeInsets.only(
                          top: 12,
                          bottom: 12,
                          right: 44,
                          left: 44,
                        ),
                      ),
                      child: FittedBox(
                        child: Text(
                          'Cancelar Agendamento',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: agendamento.status == AgendamentoStatus.agendado,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4, right: 0, left: 0, bottom: 44),
                    child: ElevatedButton(
                      onPressed: () async {
                        // Get.to(
                        //   () => TelaConclusaoAgendamento(
                        //     agendamento: agendamento,
                        //   ),
                        // )?.then((value) async {
                        //   log('Concluiu Pagamento');
                        //   if (idUsuario != null) {
                        //     _controller.geraldo.value = await _controller
                        //         .buscaAgendamentosDoDia(data, idUsuario!);
                        //   } else {
                        //     _controller.geraldo.value =
                        //         await _controller.buscaTodosAgendamentosDoDia(
                        //       data,
                        //     );
                        //   }
                        // });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        maximumSize: const Size(double.infinity, 80),
                        padding: const EdgeInsets.only(
                          top: 12,
                          bottom: 12,
                          right: 44,
                          left: 44,
                        ),
                      ),
                      child: FittedBox(
                        child: Text(
                          'Concluir',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: agendamento.status == AgendamentoStatus.cancelado,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 40, left: 40, bottom: 22),
                    child: GestureDetector(
                      onTap: () async {
                        log(agendamento.comentario);
                      },
                      child: BotaoSecundario(
                        titulo: 'Motivo: ${agendamento.comentario}',
                        radius: 16,
                        corFundo: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                FittedBox(
                  child: ElevatedButton(
                    onPressed: () async {
                      // FuncoesUteis.enviarWhattsApp(numero: agendamento.telefoneCliente);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Enviar WhattsApp    ',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Image.asset(
                          'assets/images/whatsapp-redondo.webp',
                          height: 20,
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 12, top: 12),
                  child: Divider(
                    thickness: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
