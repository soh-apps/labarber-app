// import 'package:barbearia_evollution/presentation/auth/auth_controller.dart';
// import 'package:barbearia_evollution/presentation/auth/cadastro_page.dart';
// import 'package:barbearia_evollution/utils/app_color.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _senhaController = TextEditingController();

//   final AuthController _controller = Get.put(AuthController());

//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => _controller.isLoading.isTrue
//           ? const Center(
//               child: CircularProgressIndicator.adaptive(),
//             )
//           : Scaffold(
//               extendBodyBehindAppBar: true,
//               appBar: AppBar(
//                 backgroundColor: Colors.transparent,
//                 elevation: 0,
//                 actions: [
//                   IconButton(
//                     onPressed: () => Get.to(() => const CadastroPage()),
//                     icon: Image.asset(
//                       'assets/images/logo_insta.png',
//                       width: 34,
//                     ),
//                   ),
//                 ],
//                 forceMaterialTransparency: true,
//               ),
//               body: SingleChildScrollView(
//                 child: Container(
//                   color: AppColor.corFundo,
//                   // color: Colors.green,
//                   child: Column(
//                     children: [
//                       Container(
//                         decoration: const BoxDecoration(
//                           backgroundBlendMode: BlendMode.color,
//                           gradient: LinearGradient(
//                             begin: Alignment(0.00, -1.00),
//                             end: Alignment(0, 1),
//                             colors: [
//                               Color.fromARGB(255, 0, 0, 0),
//                               Colors.transparent,
//                               Color.fromARGB(104, 0, 0, 0),
//                               Color.fromARGB(179, 0, 0, 0),
//                               Color.fromARGB(255, 0, 0, 0),
//                             ],
//                             stops: [0.0, 0.2, 0.4, 0.8, 1.0],
//                           ),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 32,
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 20),
//                             child: SizedBox(
//                               height: MediaQuery.sizeOf(context).height * 1,
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Column(
//                                     children: [
//                                       Image.asset(
//                                         'assets/images/logo.png',
//                                         height: 140,
//                                       ),
//                                     ],
//                                   ),
//                                   Form(
//                                     key: _formKey,
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         const SizedBox(height: 24),
//                                         Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               vertical: 8),
//                                           child: Center(
//                                             child: Text(
//                                               "Entre agora",
//                                               textAlign: TextAlign.center,
//                                               style: GoogleFonts.poppins(
//                                                 color: Colors.white,
//                                                 fontSize: 24,
//                                                 fontWeight: FontWeight.w900,
//                                                 letterSpacing: 1.60,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               vertical: 20),
//                                           child: ClipRRect(
//                                             borderRadius:
//                                                 BorderRadius.circular(24),
//                                             child: TextFormField(
//                                               cursorColor: Colors.white,
//                                               controller: _emailController,
//                                               style: const TextStyle(
//                                                   color: Colors.white),
//                                               decoration: InputDecoration(
//                                                 filled: true,
//                                                 hintText: 'E-mail',
//                                                 hintStyle: const TextStyle(
//                                                   color: Colors.grey,
//                                                 ),
//                                                 fillColor: Colors.black,
//                                                 focusedBorder:
//                                                     OutlineInputBorder(
//                                                   borderSide: BorderSide(
//                                                     color:
//                                                         AppColor.corPrincipal,
//                                                     width: 3,
//                                                   ),
//                                                   borderRadius:
//                                                       BorderRadius.circular(24),
//                                                 ),
//                                                 enabledBorder:
//                                                     OutlineInputBorder(
//                                                   borderSide: const BorderSide(
//                                                       color: Colors.black),
//                                                   borderRadius:
//                                                       BorderRadius.circular(8),
//                                                 ),
//                                                 border: OutlineInputBorder(
//                                                   borderSide: BorderSide(
//                                                       color: AppColor
//                                                           .corPrincipal),
//                                                   borderRadius:
//                                                       BorderRadius.circular(8),
//                                                 ),
//                                               ),
//                                               validator: (value) {
//                                                 if (value == null ||
//                                                     value == "") {
//                                                   return "O valor de e-mail deve ser preenchido";
//                                                 }
//                                                 if (!value.contains("@") ||
//                                                     !value.contains(".") ||
//                                                     value.length < 4) {
//                                                   return "O valor do e-mail deve ser válido";
//                                                 }
//                                                 return null;
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                         ClipRRect(
//                                           borderRadius:
//                                               BorderRadius.circular(24),
//                                           child: TextFormField(
//                                             controller: _senhaController,
//                                             obscureText: true,
//                                             style: const TextStyle(
//                                                 color: Colors.white),
//                                             decoration: InputDecoration(
//                                               filled: true,
//                                               fillColor: Colors.black,
//                                               hintText: 'Senha',
//                                               hintStyle: const TextStyle(
//                                                 color: Colors.grey,
//                                               ),
//                                               border: OutlineInputBorder(
//                                                   borderSide: BorderSide(
//                                                     color:
//                                                         AppColor.corPrincipal,
//                                                   ),
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           24)),
//                                               focusedBorder: OutlineInputBorder(
//                                                   borderSide: BorderSide(
//                                                       color:
//                                                           AppColor.corPrincipal,
//                                                       width: 3),
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           24)),
//                                               enabledBorder: OutlineInputBorder(
//                                                   borderSide: const BorderSide(
//                                                       color: Colors.black),
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           24)),
//                                             ),
//                                             validator: (value) {
//                                               if (value == null ||
//                                                   value.length < 4) {
//                                                 return "Insira uma senha válida.";
//                                               }
//                                               return null;
//                                             },
//                                           ),
//                                         ),
//                                         GestureDetector(
//                                           onTap: () => _controller
//                                               .esqueciMinhaSenhaClicado(
//                                                   context),
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(
//                                                 left: 8.0, top: 14),
//                                             child: Text(
//                                               '  Esqueci minha senha',
//                                               textAlign: TextAlign.center,
//                                               style: GoogleFonts.roboto(
//                                                 color: Colors.white,
//                                                 fontSize: 12,
//                                                 fontWeight: FontWeight.w700,
//                                                 letterSpacing: 1.60,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         const SizedBox(height: 48),
//                                         SizedBox(
//                                           width: double
//                                               .infinity, // Ocupa toda a largura do widget pai
//                                           child: ElevatedButton(
//                                             onPressed: () {
//                                               if (_formKey.currentState!
//                                                   .validate()) {
//                                                 _controller.entrarUsuario(
//                                                     context: context,
//                                                     email:
//                                                         _emailController.text,
//                                                     senha:
//                                                         _senhaController.text);
//                                               }
//                                             },
//                                             style: ElevatedButton.styleFrom(
//                                               padding: EdgeInsets.zero,
//                                               backgroundColor:
//                                                   AppColor.corPrincipal,
//                                               shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(10),
//                                               ),
//                                             ),
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(16),
//                                               child: Text(
//                                                 "Entrar",
//                                                 style: GoogleFonts.roboto(
//                                                   color: Colors.white,
//                                                   fontSize: 14,
//                                                   fontWeight: FontWeight.w700,
//                                                   letterSpacing: 1.60,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         const SizedBox(height: 8),
//                                         Center(
//                                           child: Text(
//                                             'ou',
//                                             textAlign: TextAlign.center,
//                                             style: GoogleFonts.roboto(
//                                               color: Colors.white,
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w700,
//                                               letterSpacing: 1.60,
//                                             ),
//                                           ),
//                                         ),
//                                         const SizedBox(height: 8),
//                                         Center(
//                                           child: GestureDetector(
//                                             onTap: () => Get.to(
//                                                 () => const CadastroPage()),
//                                             child: Text(
//                                               'Realizar cadastro',
//                                               textAlign: TextAlign.center,
//                                               style: GoogleFonts.roboto(
//                                                 color: Colors.blue,
//                                                 fontSize: 12,
//                                                 fontWeight: FontWeight.w700,
//                                                 letterSpacing: 1.60,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//     );
//   }
// }
