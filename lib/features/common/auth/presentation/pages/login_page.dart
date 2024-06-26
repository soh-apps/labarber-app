// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:la_barber/features/common/auth/model/user_model.dart';
import 'package:la_barber/features/common/auth/presentation/cubits/auth_cubit.dart';
import 'package:la_barber/core/ui/constants.dart';
import 'package:la_barber/core/ui/helpers/form_helper.dart';
import 'package:la_barber/core/ui/helpers/messages.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  final AuthCubit authCubit;
  const LoginPage({
    super.key,
    required this.authCubit,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: formKey,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageConstants.backgroundChair),
              opacity: 0.2,
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(ImageConstants.imageLogo),
                          const SizedBox(
                            height: 24,
                          ),
                          TextFormField(
                            onTapOutside: (_) => context.unfocus(),
                            validator: Validatorless.multiple([
                              Validatorless.required('E-mail obrigatorio'),
                              // Validatorless.email('E-mail invalido')
                            ]),
                            controller: emailEC, //..text = 'caneto@gmail.com',
                            decoration: const InputDecoration(
                              label: Text('E-mail'),
                              hintText: 'E-mail',
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              labelStyle: TextStyle(color: Colors.black),
                              hintStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          TextFormField(
                            onTapOutside: (_) => context.unfocus(),
                            validator: Validatorless.multiple([
                              Validatorless.required('Senha obrigatoria'),
                              Validatorless.min(6, 'Senha deve conter pelo menos 6 caracteres'),
                            ]),
                            obscureText: true,
                            controller: passwordEC, //..text = '123123',
                            decoration: const InputDecoration(
                              label: Text('Senha'),
                              hintText: 'Senha',
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              labelStyle: TextStyle(color: Colors.black),
                              hintStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Esqueceu a senha?',
                              style: TextStyle(
                                fontSize: 12,
                                color: ColorConstants.colorBrown,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(56)),
                            onPressed: () {
                              switch (formKey.currentState?.validate()) {
                                case (false || null):
                                  context.showError('Campos inválidos');
                                case true:
                                  // widget.authCubit.login(emailEC.text, passwordEC.text);
                                  widget.authCubit.saveLocalUser(UserModel(
                                      token: '123',
                                      refreshToken: '456',
                                      name: emailEC.text,
                                      credentialId: 1,
                                      userType: UserType.admin));
                              }
                            },
                            child: const Text(
                              'ACESSAR',
                            ),
                          )
                        ],
                      ),
                      // Align(
                      //   alignment: Alignment.bottomCenter,
                      //   child: InkWell(
                      //     onTap: () {
                      //       Navigator.of(context)
                      //           .pushNamed('/auth/register/user');
                      //     },
                      //     child: const Text(
                      //       'Criar conta',
                      //       style: TextStyle(
                      //         fontSize: 16,
                      //         color: Colors.white,
                      //         fontWeight: FontWeight.w500,
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
