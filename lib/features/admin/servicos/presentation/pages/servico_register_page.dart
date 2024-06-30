import 'dart:developer';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_barber/core/ui/helpers/context_extension.dart';
import 'package:la_barber/features/admin/barbershop/repository/models/barbershop_model.dart';
import 'package:la_barber/features/admin/servicos/presentation/cubit/servico_cubit.dart';
import 'package:la_barber/features/admin/servicos/presentation/widgets/image_picker_servico_widget.dart';
import 'package:la_barber/features/admin/servicos/repository/models/servico_model.dart';
import 'package:validatorless/validatorless.dart';

import 'package:la_barber/core/ui/helpers/form_helper.dart';
import 'package:la_barber/core/ui/helpers/messages.dart';

class ServicoRegisterPage extends StatefulWidget {
  final ServicoCubit servicoCubit;

  const ServicoRegisterPage({
    super.key,
    required this.servicoCubit,
  });

  @override
  State<ServicoRegisterPage> createState() => _ServicoRegisterPageState();
}

class _ServicoRegisterPageState extends State<ServicoRegisterPage> {
  final formKey = GlobalKey<FormState>();
  final nomeEC = TextEditingController();
  final valorEC = TextEditingController();
  final comissaoEC = TextEditingController();
  final descricaoServicoEc = TextEditingController();
  final TextInputFormatter formatter = RealInputFormatter(moeda: true);

  late BarbershopModel barberShop;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    barberShop = ModalRoute.of(context)!.settings.arguments as BarbershopModel;
  }

  @override
  void dispose() {
    nomeEC.dispose();
    valorEC.dispose();
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

  String? validatePercentage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, informe a porcentagem';
    }
    int? parsedValue = int.tryParse(value);
    if (parsedValue == null || parsedValue < 0 || parsedValue > 100) {
      return 'Porcentagem deve estar entre 0 e 100';
    }
    return null;
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
          title: const Text('Cradastrar Serviço'),
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
                  controller: valorEC,
                  validator: Validatorless.required('Valor do serviço obrigatório!'),
                  decoration: const InputDecoration(
                    label: Text('Valor do Serviço'),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CentavosInputFormatter(),
                    // CurrencyTextInputFormatter.currency(locale: 'pt_BR', symbol: 'R\$', decimalDigits: 2)
                  ],
                ),
                const SizedBox(height: 22),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: comissaoEC,
                  decoration: const InputDecoration(
                    label: Text('Valor da Comissão'),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CentavosInputFormatter(),
                  ],
                  keyboardType: TextInputType.number,
                ),
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
                            unitId: barberShop.id,
                          );
                          widget.servicoCubit.registerServico(servico);
                      }
                    },
                    child: const Text('CADASTRAR SERVIÇO'),
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
