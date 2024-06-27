import 'dart:developer';
import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_barber/core/constants/routes.dart';
import 'package:la_barber/core/ui/helpers/context_extension.dart';
import 'package:la_barber/core/ui/widgets/custom_check_box.dart';
import 'package:la_barber/core/ui/widgets/image_picker.dart';
import 'package:la_barber/features/admin/barber/presentation/cubit/barber_cubit.dart';
import 'package:la_barber/features/admin/barber/repository/models/barber_model.dart';

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
  final numeroEC = TextEditingController();

  File? _selectedImage;
  int barberUnitId = 0;
  bool isComoissioned = true;
  bool isManager = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    barberUnitId = ModalRoute.of(context)!.settings.arguments as int;
  }

  @override
  void dispose() {
    nomeEC.dispose();
    telefoneEC.dispose();
    cepEC.dispose();
    numeroEC.dispose();
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
  Widget build(BuildContext context) {
    return BlocListener<BarberCubit, BarberState>(
      bloc: widget.barberCubit,
      listener: (context, state) {
        if (state is BarberSuccess) {
          context.hideLoadingDialog(context);
          context.showSuccess('Colaborador Criado com Sucesso!');
          Navigator.of(context).pushNamedAndRemoveUntil(Routes.homeAdmin, (route) => false);
        } else if (state is BarberLoading) {
          context.showLoadingDialog(context, message: "Loading");
        } else if (state is BarberFailure) {
          context.hideLoadingDialog(context);
          context.showError(state.errorMessage);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cradastrar Colaborador'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const SizedBox(height: 22),
                // Picker de imagem aqui
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
                ),
                const SizedBox(height: 22),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: cepEC,
                  decoration: const InputDecoration(
                    label: Text('CEP'),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CepInputFormatter(),
                  ],
                ),
                const SizedBox(height: 22),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: streetEC,
                  decoration: const InputDecoration(
                    label: Text('Estado'),
                    hintText: 'EX: SP, RJ, etc...',
                  ),
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
                ),
                const SizedBox(height: 22),
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
                            zipCode: cepEC.text,
                            street: streetEC.text,
                            number: numberEC.text,
                            complement: complementEC.text,
                            city: cityEC.text,
                            state: stateEC.text,
                            username: usernameEC.text,
                            password: passwordEC.text,
                            commissioned: isComoissioned,
                            barberUnitId: barberUnitId,
                            isManager: isManager,
                            // image: _selectedImage,
                          );
                          widget.barberCubit.registerBarber(barber);
                        // barbershopRegisterVM.register(
                        //     name: nameEC.text,
                        //     email: emailEC.text,
                        // );
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
