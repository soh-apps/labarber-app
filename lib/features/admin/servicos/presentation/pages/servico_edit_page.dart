import 'dart:developer';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_barber/core/di/di.dart';
import 'package:validatorless/validatorless.dart';

import 'package:la_barber/core/ui/helpers/context_extension.dart';
import 'package:la_barber/core/ui/helpers/form_helper.dart';
import 'package:la_barber/core/ui/helpers/messages.dart';
import 'package:la_barber/features/admin/barbershop/repository/models/barbershop_model.dart';
import 'package:la_barber/features/admin/servicos/presentation/cubit/servico_cubit.dart';
import 'package:la_barber/features/admin/servicos/presentation/widgets/image_picker_servico_widget.dart';
import 'package:la_barber/features/admin/servicos/repository/models/servico_model.dart';

class ServicoEditPage extends StatefulWidget {
  final ServicoCubit servicoCubit;
  final ServicoModel servico;

  const ServicoEditPage({
    super.key,
    required this.servicoCubit,
    required this.servico,
  });

  @override
  State<ServicoEditPage> createState() => _ServicoEditPageState();
}

class _ServicoEditPageState extends State<ServicoEditPage> {
  final formKey = GlobalKey<FormState>();
  final nomeEC = TextEditingController();
  final tempoServicoEC = TextEditingController();
  final valorEC = TextEditingController();
  final comissaoEC = TextEditingController();
  final descricaoServicoEc = TextEditingController();
  String _formattedTime = '';
  String porcentagem = '';

  final BarbershopModel barberShop = getIt<BarbershopModel>();

  @override
  void initState() {
    super.initState();
    nomeEC.text = widget.servico.nome;
    tempoServicoEC.text = widget.servico.tempoServico;
    valorEC.text = widget.servico.valor.toStringAsFixed(2).replaceAll('.', ',');
    comissaoEC.text = widget.servico.comissao.toStringAsFixed(2).replaceAll('.', ',');
    descricaoServicoEc.text = widget.servico.descricao ?? '';
    porcentagem = '${widget.servico.porcentagemComissao} %';
  }

  @override
  void dispose() {
    nomeEC.dispose();
    valorEC.dispose();
    tempoServicoEC.dispose();
    comissaoEC.dispose();
    descricaoServicoEc.dispose();
    super.dispose();
  }

  String? _selectedImagePath;

  void _onImageSelected(String imagePath) {
    setState(() {
      _selectedImagePath = imagePath;
    });
  }

  void _calculatePercentage(String value) {
    if (value.isNotEmpty && valorEC.text.isNotEmpty) {
      double comissao;
      double totalValue;

      try {
        comissao = double.parse(value.replaceAll('.', '').replaceAll(',', '.').trim());
      } catch (e) {
        comissao = 0.0;
      }
      try {
        totalValue = double.parse(valorEC.text.replaceAll('.', '').replaceAll(',', '.').trim());
      } catch (e) {
        totalValue = 1.0; // Evitar divisão por zero
      }
      double porcentagemLocal = (comissao * 100) / totalValue;
      setState(() {
        porcentagem = '${porcentagemLocal.toStringAsFixed(0)} %';
      });
    }
  }

  void _formatTime(String value) {
    if (value.isNotEmpty) {
      int minutes = int.parse(value);
      int hours = minutes ~/ 60;
      int remainingMinutes = minutes % 60;

      setState(() {
        _formattedTime = '$hours horas e ${remainingMinutes}minutos';
      });
    } else {
      setState(() {
        _formattedTime = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ServicoCubit, ServicoState>(
      bloc: widget.servicoCubit,
      listener: (context, state) {
        if (state is ServicoSuccess) {
          context.hideLoadingDialog(context);
          context.showSuccess('Unidade Cadastrada com Sucesso!');
          context.pop();
        } else if (state is ServicoLoading) {
          context.showLoadingDialog(context);
        } else if (state is ServicoFailure) {
          context.hideLoadingDialog(context);
          context.showError(state.errorMessage);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.servico.nome.toUpperCase()),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const SizedBox(height: 20),
                Center(
                  child: ImagePickerServicoWidget(
                    onImageSelected: _onImageSelected,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: nomeEC,
                  validator: Validatorless.required('Nome obrigatório'),
                  decoration: const InputDecoration(
                    label: Text('Nome'),
                  ),
                ),
                const SizedBox(height: 22),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: tempoServicoEC,
                  validator: Validatorless.required('Tempo de serviço obrigatório!'),
                  decoration: const InputDecoration(
                    label: Text('Tempo de Serviço (em minutos)'),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 3,
                  onChanged: _formatTime,
                ),
                Visibility(
                  visible: _formattedTime.isNotEmpty,
                  child: Text(
                    '  Tempo: $_formattedTime',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 22),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: valorEC,
                  validator: Validatorless.required('Valor do serviço obrigatório!'),
                  decoration: const InputDecoration(
                    label: Text('Valor do Serviço'),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CentavosInputFormatter(),
                  ],
                  onChanged: (value) {
                    _calculatePercentage(comissaoEC.text);
                  },
                ),
                const SizedBox(height: 22),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: comissaoEC,
                  decoration: const InputDecoration(
                    label: Text('Valor da Comissão'),
                  ),
                  validator: Validatorless.required('Valor da Comissão obrigatória!'),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CentavosInputFormatter(),
                  ],
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    _calculatePercentage(value);
                  },
                ),
                Visibility(
                    visible: porcentagem.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(' Porcentagem da comissao $porcentagem'),
                    )),
                const SizedBox(height: 22),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: descricaoServicoEc,
                  decoration: const InputDecoration(
                    labelText: 'Descrição do Serviço',
                    alignLabelWithHint: true, // Isso alinha o label com a hint no canto superior esquerdo
                    border: OutlineInputBorder(),
                  ),
                  maxLength: 500,
                  maxLines: 3,
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.only(right: 12, left: 12, top: 12),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(56)),
                    onPressed: () {
                      switch (formKey.currentState?.validate()) {
                        case null || false:
                          context.showError('Formulário invalido');
                        case true:
                          log(_selectedImagePath ?? 'Sem imagem selecionada');
                          ServicoModel servico = ServicoModel(
                            nome: nomeEC.text,
                            valor: double.parse(valorEC.text),
                            comissao: double.parse(comissaoEC.text),
                            descricao: descricaoServicoEc.text,
                            urlImagem: _selectedImagePath ?? 'assets/images/default_image.png',
                            barberUnitId: barberShop.id,
                            porcentagemComissao: int.parse(porcentagem.replaceAll(' %', '')),
                            tempoServico: tempoServicoEC.toString(),
                          );
                          widget.servicoCubit.editarServico(servico);
                      }
                    },
                    child: const Text('EDITAR SERVIÇO'),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
