import 'package:flutter/material.dart';

import 'package:la_barber/core/di/di.dart';
import 'package:la_barber/core/ui/app_color.dart';
import 'package:la_barber/core/ui/constants.dart';
import 'package:la_barber/features/common/auth/model/user_model.dart';

class DrawerAdminWidget extends StatelessWidget {
  const DrawerAdminWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Menu',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    GestureDetector(
                      // onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: const AssetImage(ImageConstants.imageLogo) as ImageProvider,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${getIt<UserModel>().name} ${getIt<UserModel>().name}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          DrawerTile(
            title: 'Início',
            icon: const Icon(Icons.home),
            onTap: () => Navigator.pop(context),
          ),
          DrawerTile(
            title: 'Agendamentos',
            icon: const Icon(Icons.date_range),
            onTap: () => Navigator.pop(context),
          ),
          DrawerTile(
            title: 'Barbeiros Registrados',
            icon: const Icon(Icons.list_alt_outlined),
            onTap: () => Navigator.pop(context),
          ),
          DrawerTile(
            title: 'Serviços Registrados',
            icon: const Icon(Icons.list),
            onTap: () => Navigator.pop(context),
          ),
          DrawerTile(
            title: 'Financeiro',
            icon: const Icon(Icons.auto_graph),
            onTap: () => Navigator.pop(context),
          ),
          DrawerTile(
            title: 'Unidades',
            icon: const Icon(Icons.local_convenience_store_rounded),
            onTap: () => Navigator.pop(context),
          ),
          DrawerTile(
            title: 'Mensalistas',
            icon: const Icon(Icons.event_repeat),
            onTap: () => Navigator.pop(context),
          ),
          DrawerTile(
            title: 'Meus dados',
            icon: const Icon(Icons.account_circle_outlined),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  final String title;
  final Widget icon;
  final Function onTap;

  const DrawerTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black, // cor da borda
              width: 1.5, // largura da borda
            ),
            borderRadius: BorderRadius.circular(8.0), // raio da borda
            color: AppColor.bg100,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: ListTile(
            leading: icon,
            title: Text(title),
            visualDensity: const VisualDensity(vertical: -3),
          ),
        ),
      ),
    );
  }
}
