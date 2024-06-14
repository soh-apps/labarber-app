import 'package:flutter/material.dart';

import 'package:la_barber/core/ui/barbershop_icons.dart';
import 'package:la_barber/core/ui/constants.dart';
import 'package:la_barber/core/ui/helpers/context_extension.dart';
import 'package:la_barber/features/admin/barbershop/presentation/cubit/barbershop_cubit.dart';
import 'package:la_barber/features/admin/barbershop/presentation/widgets/barbershop_header_widget.dart';
import 'package:la_barber/features/admin/barbershop/presentation/widgets/barbershop_tile.dart';
import 'package:la_barber/utils/mocks.dart';

class BarbershopListPage extends StatefulWidget {
  final BarbershopCubit barbershopCubit;
  const BarbershopListPage({
    super.key,
    required this.barbershopCubit,
  });

  @override
  State<BarbershopListPage> createState() => _BarbershopListPageState();
}

class _BarbershopListPageState extends State<BarbershopListPage> {
  @override
  void initState() {
    widget.barbershopCubit.getAllCompanies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          child: Column(
            children: [
              const BarbershopHeaderWidget.withoutFilter(),
              Expanded(
                child: ListView.builder(
                  itemCount: Mocks.companies.length,
                  itemBuilder: (BuildContext context, int index) {
                    return BarbershopHomeTile(company: Mocks.companies[index]);
                  },
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: ColorConstants.colorBrown,
          onPressed: () {
            context.pushNamed('/register/barbershop');

            // await context.pushNamed('/employee/register');
            // ref.invalidate(getMeProvider);
            // ref.invalidate(homeAdmVmProvider);
          },
          child: const CircleAvatar(
            backgroundColor: Colors.white,
            maxRadius: 12,
            child: Icon(
              BarbershopIcons.addEmplyeee,
              color: ColorConstants.colorBrown,
            ),
          ),
        ),
      ),
    );
  }
}
