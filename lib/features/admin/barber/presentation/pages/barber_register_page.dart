import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_barber/core/constants/routes.dart';
import 'package:la_barber/core/ui/helpers/context_extension.dart';
import 'package:la_barber/features/admin/barber/presentation/cubit/barber_cubit.dart';

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
  final nomeEC = TextEditingController();
  final telefoneEC = TextEditingController();
  final cepEC = TextEditingController();
  final numeroEC = TextEditingController();

  @override
  void dispose() {
    nomeEC.dispose();
    telefoneEC.dispose();
    cepEC.dispose();
    numeroEC.dispose();
    super.dispose();
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
                const SizedBox(
                  height: 5,
                ),
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
                  controller: telefoneEC,
                  validator: Validatorless.required('Telefone obrigatório'),
                  decoration: const InputDecoration(
                    label: Text('Telefone'),
                  ),
                ),
                const SizedBox(height: 22),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: cepEC,
                  validator: Validatorless.required('Cep obrigatório'),
                  decoration: const InputDecoration(
                    label: Text('CEP'),
                  ),
                ),
                const SizedBox(height: 22),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: numeroEC,
                  validator: Validatorless.required('Número obrigatório'),
                  decoration: const InputDecoration(
                    label: Text('Número'),
                  ),
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
