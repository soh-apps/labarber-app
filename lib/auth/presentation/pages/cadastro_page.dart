import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_barber/auth/presentation/cubits/register/register_cubit.dart';
import 'package:la_barber/core/ui/helpers/form_helper.dart';
import 'package:flutter/material.dart';
import 'package:la_barber/core/ui/widgets/hours_panel.dart';
import 'package:la_barber/core/ui/widgets/weekdays_panel.dart';
import 'package:validatorless/validatorless.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final telefoneEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    telefoneEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      bloc: RegisterCubit(),
      builder: (context, state) {
        return Scaffold(
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
                    validator: Validatorless.multiple([
                      Validatorless.required('E-mail obrigatório'),
                      Validatorless.email('E-mail obrigatório')
                    ]),
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
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(56)),
                    onPressed: () {
                      // switch (formKey.currentState?.validate()) {
                      //   case null || false:
                      //     context.showError('Formulário invalido');
                      //   case true:
                      //   barbershopRegisterVM.register(
                      //       name: nameEC.text,
                      //       email: emailEC.text,
                      //   );
                      // }
                    },
                    child: const Text('CADASTRAR ESTABELECIMENTO'),
                  )
                ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
