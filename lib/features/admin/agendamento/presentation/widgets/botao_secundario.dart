import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:la_barber/core/ui/styles/app_color.dart';

class BotaoSecundario extends StatelessWidget {
  final String titulo;
  final Function? onClick;
  final double? fontSize;
  final double? radius;
  final Color corFundo;

  const BotaoSecundario({
    super.key,
    required this.titulo,
    this.onClick,
    this.fontSize,
    this.radius,
    this.corFundo = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: ShapeDecoration(
        color: corFundo,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: AppColor.corSecundaria,
          ),
          borderRadius: BorderRadius.circular(radius ?? 12),
        ),
      ),
      child: Center(
        child: Text(
          titulo,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: fontSize ?? 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
