import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double iconWidth;
  final String text;

  const CustomAppBar({
    super.key,
    this.iconWidth = 34,
    this.text = '',
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(text),
      centerTitle: true,
      actions: const [
        // InstagramIconButton(
        //   iconWidth: iconWidth,
        // ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
