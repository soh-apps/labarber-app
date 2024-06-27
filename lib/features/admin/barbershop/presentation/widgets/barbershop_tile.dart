import 'package:flutter/material.dart';
import 'package:la_barber/core/constants/routes.dart';
import 'package:la_barber/core/ui/barbershop_icons.dart';
import 'package:la_barber/core/ui/constants.dart';
import 'package:la_barber/core/ui/helpers/context_extension.dart';
import 'package:la_barber/features/admin/barbershop/repository/models/barbershop_model.dart';

class BarbershopHomeTile extends StatelessWidget {
  final BarbershopModel barberShop;

  const BarbershopHomeTile({
    super.key,
    required this.barberShop,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(Routes.barberListPage, arguments: barberShop);
      },
      child: Container(
        width: 200,
        height: 100,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ColorConstants.colorBrown),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  // image: switch (employee.avatar) {
                  //   final avatar => NetworkImage(avatar),
                  //   _ => const AssetImage(ImageConstants.avatar),
                  // }
                  image: AssetImage(ImageConstants.avatar),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    barberShop.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlinedButton(
                        style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 12)),
                        onPressed: () {
                          context.pushNamed('/employee/schedule', arguments: barberShop);
                        },
                        child: const Text('VER AGENDA'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 12)),
                        onPressed: () {
                          context.pushNamed('/schedule', arguments: barberShop);
                        },
                        child: const Text('EDITAR'),
                      ),
                      // const Icon(
                      //   BarbershopIcons.penEdit,
                      //   size: 16,
                      //   color: ColorConstants.colorBrown,
                      // ),
                      const Icon(
                        BarbershopIcons.trash,
                        size: 28,
                        color: ColorConstants.colorRed,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
