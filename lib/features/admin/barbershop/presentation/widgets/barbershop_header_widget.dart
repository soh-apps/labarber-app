import 'package:flutter/material.dart';
import 'package:la_barber/core/ui/barbershop_icons.dart';
import 'package:la_barber/core/ui/constants.dart';
// import 'package:get_it/get_it.dart';
// import 'package:la_barber/core/ui/barbershop_nav_global_key.dart';
// import 'package:la_barber/core/ui/widgets/dialog_utils.dart';
// import 'package:la_barber/features/common/auth/model/user_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class BarbershopHeaderWidget extends StatelessWidget {
  final bool showFilter;

  const BarbershopHeaderWidget({super.key}) : showFilter = true;
  const BarbershopHeaderWidget.withoutFilter({super.key}) : showFilter = false;

  Future<void> logout(BuildContext context) async {
    // showLoadingDialog(context, message: "Loading");
    // final sp = await SharedPreferences.getInstance();
    // sp.clear();

    // if (GetIt.instance.isRegistered<UserModel>()) {
    //   GetIt.instance.unregister<UserModel>();
    // }

    // hideLoadingDialog(context);

    // Navigator.of(BarbershopNavGlobalKey.instance.navKey.currentContext!)
    //     .pushNamedAndRemoveUntil('/login', (route) => false);
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
              const CircleAvatar(
                backgroundColor: Color(0xffbdbdbd),
                child: SizedBox.shrink(),
              ),
              const SizedBox(
                width: 16,
              ),
              const Flexible(
                child: Text(
                  'Geraldo',
                  // barbershopData.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
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
          const Text(
            'Bem Vindo',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          const Center(
            child: Text(
              'Unidades',
              style: TextStyle(
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
