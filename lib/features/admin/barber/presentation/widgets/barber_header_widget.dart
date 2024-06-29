import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:la_barber/core/constants/routes.dart';
import 'package:la_barber/core/di/di.dart';
import 'package:la_barber/core/local_secure_storage/local_secure_storage.dart';
import 'package:la_barber/core/ui/barbershop_icons.dart';
import 'package:la_barber/core/ui/barbershop_nav_global_key.dart';
import 'package:la_barber/core/ui/constants.dart';
import 'package:la_barber/core/ui/widgets/dialog_utils.dart';
import 'package:la_barber/features/common/auth/model/user_model.dart';

class BarberHeaderWidget extends StatelessWidget {
  final bool showFilter;
  final String title;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const BarberHeaderWidget({
    super.key,
    this.showFilter = false,
    required this.title,
    required this.scaffoldKey,
  });

  Future<void> logout(BuildContext context) async {
    showLoadingDialog(context, message: "Loading");
    final LocalSecureStorage secureStorage = getIt();
    secureStorage.clear();

    if (GetIt.instance.isRegistered<UserModel>()) {
      GetIt.instance.unregister<UserModel>();
    }

    hideLoadingDialog(context);

    Navigator.of(BarbershopNavGlobalKey.instance.navKey.currentContext!)
        .pushNamedAndRemoveUntil(Routes.login, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.only(bottom: 16),
      width: MediaQuery.sizeOf(context).width,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        image: DecorationImage(
          image: AssetImage(
            ImageConstants.backgroundChair,
          ),
          fit: BoxFit.cover,
          opacity: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              GestureDetector(
                onTap: () {
                  log('CLicado');
                  scaffoldKey.currentState?.openDrawer();
                },
                child: const CircleAvatar(
                  backgroundColor: Color(0xffbdbdbd),
                  child: SizedBox.shrink(),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Flexible(
                child: Text(
                  getIt<UserModel>().name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              const Expanded(
                child: Text(
                  'editar',
                  style: TextStyle(
                    color: ColorConstants.colorBrown,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Spacer(),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () => logout(context),
                icon: const Icon(
                  BarbershopIcons.exit,
                  color: ColorConstants.colorBrown,
                  size: 32,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 32,
              ),
            ),
          ),
          Offstage(
            offstage: !showFilter,
            child: const SizedBox(
              height: 24,
            ),
          ),
          Offstage(
            offstage: !showFilter,
            child: TextFormField(
              decoration: const InputDecoration(
                label: Text('Buscar Unidade'),
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 24.0),
                  child: Icon(
                    BarbershopIcons.search,
                    color: ColorConstants.colorBrown,
                    size: 26,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
