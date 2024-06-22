// import 'package:flutter/material.dart';
// import 'package:la_barber/core/constants/routes.dart';

// import 'package:la_barber/core/ui/barbershop_icons.dart';
// import 'package:la_barber/core/ui/constants.dart';
// import 'package:la_barber/core/ui/helpers/context_extension.dart';
// import 'package:la_barber/features/admin/barbershop/presentation/cubit/barbershop_cubit.dart';
// import 'package:la_barber/features/admin/home/widgets/home_employee_tile.dart';
// import 'package:la_barber/features/admin/widgets/home_header.dart';
// import 'package:la_barber/utils/mocks.dart';

// class HomeAdmPage extends StatefulWidget {
//   final BarbershopCubit barbershopCubit;
//   const HomeAdmPage({
//     super.key,
//     required this.barbershopCubit,
//   });

//   @override
//   State<HomeAdmPage> createState() => _HomeAdmPageState();
// }

// class _HomeAdmPageState extends State<HomeAdmPage> {
//   @override
//   void initState() {
//     widget.barbershopCubit.getAllCompanies();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: SizedBox(
//           child: Column(
//             children: [
//               const HomeHeader(),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: Mocks.userBarbers.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return HomeEmployeeTile(employee: Mocks.userBarbers[index]);
//                   },
//                 ),
//               )
//             ],
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           shape: const CircleBorder(),
//           backgroundColor: ColorConstants.colorBrown,
//           onPressed: () {
//             context.pushNamed(Routes.adminRegisterBarbershop);

//             // await context.pushNamed('/employee/register');
//             // ref.invalidate(getMeProvider);
//             // ref.invalidate(homeAdmVmProvider);
//           },
//           child: const CircleAvatar(
//             backgroundColor: Colors.white,
//             maxRadius: 12,
//             child: Icon(
//               BarbershopIcons.addEmplyeee,
//               color: ColorConstants.colorBrown,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
