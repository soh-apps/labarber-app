import 'dart:developer';
import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_barber/core/di/di.dart';
import 'package:la_barber/core/ui/helpers/context_extension.dart';
import 'package:la_barber/core/ui/widgets/custom_check_box.dart';
import 'package:la_barber/core/ui/widgets/image_picker.dart';
import 'package:la_barber/core/utils/formatters.dart';
import 'package:la_barber/core/utils/user_type_enum.dart';
import 'package:la_barber/features/admin/barber/presentation/cubit/barber_cubit.dart';
import 'package:la_barber/features/admin/barber/repository/models/barber_model.dart';
import 'package:la_barber/features/admin/barbershop/repository/models/barbershop_model.dart';

import 'package:validatorless/validatorless.dart';

import 'package:la_barber/core/ui/helpers/form_helper.dart';
import 'package:la_barber/core/ui/helpers/messages.dart';

class BarberRegisterPage extends StatefulWidget {
  final BarberCubit barberCubit;

  const BarberRegisterPage({
    super.key,
    required this.barberCubit,
  });

  @override
  State<BarberRegisterPage> createState() => _BarberRegisterPageState();
}

class _BarberRegisterPageState extends State<BarberRegisterPage> {
  final formKey = GlobalKey<FormState>();

  final usernameEC = TextEditingController();
  final passwordEC = TextEditingController();
  final ufEC = TextEditingController();
  final cityEC = TextEditingController();
  final stateEC = TextEditingController();
  final streetEC = TextEditingController();
  final numberEC = TextEditingController();
  final complementEC = TextEditingController();
  final zipCodeEC = TextEditingController();

  final nomeEC = TextEditingController();
  final emailEC = TextEditingController();
  final telefoneEC = TextEditingController();
  final cepEC = TextEditingController();

  File? _selectedImage;
  bool isComoissioned = true;
  bool isManager = true;
  String barberName = '';

  @override
  void dispose() {
    nomeEC.dispose();
    telefoneEC.dispose();
    ufEC.dispose();
    cepEC.dispose();
    usernameEC.dispose();
    passwordEC.dispose();
    cityEC.dispose();
    stateEC.dispose();
    streetEC.dispose();
    numberEC.dispose();
    complementEC.dispose();
    zipCodeEC.dispose();
    emailEC.dispose();
    super.dispose();
  }

  void _onImageSelected(File? image) {
    setState(() {
      _selectedImage = image;
    });
  }

  @override
  void initState() {
    // Verifica se a instância está registrada no getIt
    if (getIt.isRegistered<BarbershopModel>()) {
      try {
        barberName = getIt<BarbershopModel>().name;
      } catch (e) {
        // Loga o erro ou trata de outra forma necessária
        log('Erro ao obter o nome do barbeiro: $e');
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BarberCubit, BarberState>(
      bloc: widget.barberCubit,
      listener: (context, state) {
        if (state is BarberSuccess) {
          context.hideLoadingDialog(context);
          context.showSuccess('Colaborador Criado com Sucesso!');
          context.pop();
          // Navigator.of(context).pushNamedAndRemoveUntil(Routes.homeAdmin, (route) => false);
        } else if (state is BarberLoading) {
          context.showLoadingDialog(context, message: "Loading");
        } else if (state is BarberFailure) {
          context.hideLoadingDialog(context);
          context.showError(state.errorMessage);
        } else if (state is BarberCepSuccess) {
          context.hideLoadingDialog(context);
          setState(() {
            cityEC.text = widget.barberCubit.cepModel?.localidade ?? cityEC.text;
            stateEC.text = widget.barberCubit.cepModel?.uf ?? stateEC.text;
            streetEC.text = widget.barberCubit.cepModel?.logradouro ?? streetEC.text;
          });
        } else if (state is BarberCepFailure) {
          context.showError(state.errorMessage);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastrar Colaborador '),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Visibility(
                  visible: barberName.isNotEmpty,
                  child: Center(
                    child: Text(
                      'UNIDADE - $barberName',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                Center(
                  child: ImagePickerWidget(
                    imageUrl: null,
                    onImageSelected: _onImageSelected,
                  ),
                ),
                const SizedBox(height: 22),
                const Center(
                  child: Text(
                    'Dados de Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: nomeEC,
                  validator: Validatorless.required('Nome obrigatório'),
                  decoration: const InputDecoration(
                    label: Text('Nome'),
                    hintText: 'Nome do Colaborador',
                  ),
                ),
                const SizedBox(height: 22),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: usernameEC,
                  validator: Validatorless.required('Usuário de Login obrigatório'),
                  decoration: const InputDecoration(
                    label: Text('Usuário de Login'),
                  ),
                ),
                const SizedBox(height: 22),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: passwordEC,
                  validator: Validatorless.required('Senha do usuário obrigatório'),
                  decoration: const InputDecoration(
                    label: Text('Senha do usuário'),
                  ),
                ),
                const SizedBox(height: 22),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: emailEC,
                  validator: Validatorless.multiple(
                    [
                      Validatorless.required('E-mail obrigatorio'),
                      Validatorless.email('E-mail invalido'),
                    ],
                  ),
                  decoration: const InputDecoration(
                    label: Text('E-mail'),
                  ),
                ),
                const SizedBox(height: 22),
                CustomCheckbox(
                  value: isComoissioned,
                  label: 'Colaborador Comissionado',
                  onChanged: (value) {
                    setState(() {
                      isComoissioned = value ?? false;
                    });
                  },
                ),
                CustomCheckbox(
                  value: isManager,
                  label: 'Colaborador Gerente',
                  onChanged: (value) {
                    setState(() {
                      isManager = value ?? false;
                    });
                  },
                ),
                const SizedBox(height: 22),
                const Center(
                  child: Text(
                    'Dados de Usuário',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: telefoneEC,
                  decoration: const InputDecoration(
                    label: Text('Telefone'),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter(),
                  ],
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 22),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: cepEC,
                  decoration: const InputDecoration(
                    label: Text('CEP'),
                  ),
                  onChanged: (value) {
                    if (value.length == 10) {
                      widget.barberCubit.getByCEP(Formatters.formatCep(value));
                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CepInputFormatter(),
                  ],
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 22),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: stateEC,
                  decoration: const InputDecoration(
                    label: Text('Estado'),
                    hintText: 'EX: SP, RJ, etc...',
                  ),
                  maxLength: 2,
                ),
                const SizedBox(height: 22),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: streetEC,
                  decoration: const InputDecoration(
                    label: Text('Endereço'),
                    hintText: 'EX: Rua, Avenida, etc...',
                  ),
                ),
                const SizedBox(height: 22),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: numberEC,
                  decoration: const InputDecoration(
                    label: Text('Número'),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 22),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: complementEC,
                  decoration: const InputDecoration(
                    label: Text('Complemento'),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 48),
                Padding(
                  padding: const EdgeInsets.only(right: 12, left: 12),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(56)),
                    onPressed: () {
                      switch (formKey.currentState?.validate()) {
                        case null || false:
                          context.showError('Formulário invalido');
                        case true:
                          log(_selectedImage.toString());
                          final barber = BarberModel(
                            name: nomeEC.text,
                            email: emailEC.text,
                            telefone: telefoneEC.text,
                            zipCode: Formatters.formatCep(cepEC.text),
                            street: streetEC.text,
                            number: numberEC.text,
                            complement: complementEC.text,
                            city: cityEC.text,
                            state: stateEC.text,
                            username: usernameEC.text,
                            password: passwordEC.text,
                            commissioned: isComoissioned,
                            barberUnitId: 0,
                            isManager: isManager,
                            userType: isManager ? UserType.manager : UserType.barber,
                            // image: _selectedImage,
                          );
                          widget.barberCubit.registerBarber(barber);
                      }
                    },
                    child: const Text('CADASTRAR COLABORADOR'),
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
