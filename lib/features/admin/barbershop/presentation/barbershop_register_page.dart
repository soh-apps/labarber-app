import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

import 'package:la_barber/core/ui/helpers/form_helper.dart';
import 'package:la_barber/core/ui/helpers/messages.dart';
import 'package:la_barber/core/ui/widgets/hours_panel.dart';
import 'package:la_barber/core/ui/widgets/weekdays_panel.dart';
import 'package:la_barber/features/admin/barbershop/presentation/cubit/barbershop_cubit.dart';

class BarbershopRegisterPage extends StatefulWidget {
  final BarbershopCubit barbershopCubit;
  const BarbershopRegisterPage({
    super.key,
    required this.barbershopCubit,
  });

  @override
  State<BarbershopRegisterPage> createState() => _BarbershopRegisterPageState();
}

class _BarbershopRegisterPageState extends State<BarbershopRegisterPage> {
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final barbershopRegisterVM =
    //     ref.watch(barbershopRegisterVmProvider.notifier);

    // ref.listen(barbershopRegisterVmProvider, (_, state) {
    //   switch(state.status) {
    //     case BarbershopRegisterStateStatus.initial:
    //       break;
    //     case BarbershopRegisterStateStatus.error:
    //       context.showError('Desculpe ocorreu um erro ao registrar barbearia');
    //     case BarbershopRegisterStateStatus.success:
    //       Navigator.of(context).pushNamedAndRemoveUntil('/home/adm', (route) => false);
    //   }
    // });

    return BlocListener<BarbershopCubit, BarbershopState>(
      bloc: widget.barbershopCubit,
      listener: (context, state) {
        // if (state is AuthStateError) {
        //   context.showError(state.errorMessage);

        //   context.hideLoadingDialog(context); // Pop dialog
        // } else if (state is AuthStateSuccess) {
        //   // hideLoadingDialog(context); // Pop dialog
        //   context.showSuccess('Deu certo o Login');
        //   Navigator.of(context).pushNamedAndRemoveUntil('/home/adm', (route) => false);
        // } else if (state is AuthStateLoaging) {
        //   context.showLoadingDialog(context, message: "Loading");

        //   //  BarbershopLoader();
        // }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cradastrar estabelecimento'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(children: [
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: nameEC,
                  validator: Validatorless.required('Nome obrigatório'),
                  decoration: const InputDecoration(
                    label: Text('Nome'),
                  ),
                ),
                const SizedBox(height: 22),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: emailEC,
                  validator: Validatorless.multiple(
                      [Validatorless.required('E-mail obrigatório'), Validatorless.email('E-mail obrigatório')]),
                  decoration: const InputDecoration(
                    label: Text('E-mail'),
                  ),
                ),
                const SizedBox(height: 24),
                WeekdaysPanel(
                  onDayPressed: (String value) {
                    // barbershopRegisterVM.addOrRemoveOpenDay(value);
                  },
                ),
                const SizedBox(height: 24),
                HoursPanel(
                  startTime: 6,
                  endTime: 23,
                  onHourPressed: (int value) {
                    // barbershopRegisterVM.addOrRemoveOpenHour(value);
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
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
                  child: const Text('CADASTRAR ESTABELECIMENTO'),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
