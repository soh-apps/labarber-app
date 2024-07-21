import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:la_barber/core/di/di.dart';
import 'package:la_barber/core/ui/styles/app_color.dart';
import 'package:la_barber/features/admin/agendamento/presentation/cubits/agendamento_cubit.dart';
import 'package:la_barber/features/admin/agendamento/presentation/widgets/agendamento_tile.dart';
import 'package:la_barber/features/admin/agendamento/presentation/widgets/date_selector_button.dart';
import 'package:la_barber/features/admin/barber/repository/models/barber_model.dart';

class AgendamentosBarbeiroSelecionado extends StatefulWidget {
  final BarberModel barbeiro;
  const AgendamentosBarbeiroSelecionado({super.key, required this.barbeiro});

  @override
  State<AgendamentosBarbeiroSelecionado> createState() => _AgendamentosBarbeiroSelecionadoState();
}

class _AgendamentosBarbeiroSelecionadoState extends State<AgendamentosBarbeiroSelecionado> {
  final AgendamentoCubit agendamentoCubit = getIt();

  @override
  void initState() {
    agendamentoCubit.buscaAgendamentosEntreDatas(widget.barbeiro.id ?? 0);
    super.initState();
  }

  DateTime? dataInicio;
  DateTime? dataFim;

  void selecionaDataInicio(DateTime date) {
    setState(() {
      dataInicio = date;
    });
  }

  void selecionaDataFim(DateTime date) {
    setState(() {
      dataFim = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg100,
      appBar: AppBar(
        title: Text('Agendamentos'.toUpperCase()),
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
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 24,
                left: 24,
                top: 24,
                bottom: 8,
              ),
              child: Center(
                child: Text(
                  widget.barbeiro.name.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DateSelectorButton(
                    onDateSelected: selecionaDataInicio,
                    titulo: 'De',
                  ),
                  if (dataInicio != null)
                    // Text('Data selecionada: ${DateFormat('dd/MM/yyyy').format(_selectedDate!)}'),
                    const SizedBox(width: 10),
                  DateSelectorButton(
                    onDateSelected: selecionaDataFim,
                    titulo: 'Até',
                  ),
                ],
              ),
            ),
            // Lita AQUI
            BlocBuilder<AgendamentoCubit, AgendamentoState>(
              bloc: agendamentoCubit,
              builder: (context, state) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: agendamentoCubit.agendamentos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AgendamentoTile(agendamento: agendamentoCubit.agendamentos[index]);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
