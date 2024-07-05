import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:la_barber/core/di/di.dart';
import 'package:la_barber/features/admin/servicos/presentation/cubit/servico_cubit.dart';

class ServicoDialog {
  static void showUpdate({required BuildContext context}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Aluno Atualizado',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            'Aluno atualizado com sucesso!',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: <Widget>[
            Container(
              decoration: ShapeDecoration(
                color: const Color(0xFF0DDE09),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: TextButton(
                child: Text(
                  'Fechar',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  static void showErrorDelete({required BuildContext context}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Ops!',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Column(
            children: [
              Text(
                'Falha ao excluir Serviço!',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Center(
                child: Image.asset(
                  'assets/gifs/erro.gif',
                  height: 200,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Container(
              decoration: ShapeDecoration(
                color: const Color(0xFF0DDE09),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: TextButton(
                child: Text(
                  'Fechar',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  static void showPerguntaExcluir(
      {required BuildContext context, required Function() onPressed, required String servico}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BlocListener<ServicoCubit, ServicoState>(
          bloc: getIt<ServicoCubit>(),
          listener: (context, state) {
            if (state is ServicoSuccess) {
              Navigator.pop(context);
              ServicoDialog.showUpdate(context: context);
            } else if (state is ServicoFailure) {
              Navigator.pop(context);
              ServicoDialog.showErrorDelete(context: context);
            }
          },
          child: BlocBuilder<ServicoCubit, ServicoState>(
            bloc: getIt<ServicoCubit>(),
            builder: (context, state) {
              if (state is ServicoLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  title: Text(
                    'Tem certeza de que deseja excluir $servico?',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    Container(
                      decoration: ShapeDecoration(
                        color: const Color(0xFF0DDE09),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: TextButton(
                        child: Text(
                          'Excluir',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {
                          onPressed();
                        },
                      ),
                    ),
                    Container(
                      decoration: ShapeDecoration(
                        color: const Color(0xFF0DDE09),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: TextButton(
                        child: Text(
                          'Fechar',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        );
      },
    );
  }

  // static void showCreated({required BuildContext context}) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(
  //           'Aluno Cadastrado',
  //           style: GoogleFonts.poppins(
  //             color: Colors.black,
  //             fontSize: 30,
  //             fontWeight: FontWeight.w600,
  //           ),
  //         ),
  //         content: const Text('Aluno cadastrado com sucesso!'),
  //         actions: <Widget>[
  //           Container(
  //             decoration: ShapeDecoration(
  //               color: const Color(0xFF0DDE09),
  //               shape: RoundedRectangleBorder(
  //                 side: const BorderSide(width: 1),
  //                 borderRadius: BorderRadius.circular(12),
  //               ),
  //             ),
  //             child: TextButton(
  //               child: Text(
  //                 'Fechar',
  //                 style: GoogleFonts.poppins(
  //                   color: Colors.white,
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //               ),
  //               onPressed: () {
  //                 Get.back();
  //                 Get.back();
  //               },
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
