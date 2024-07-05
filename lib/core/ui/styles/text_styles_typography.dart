import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle titleLarge({Color? color}) {
    return GoogleFonts.roboto(
      fontSize: 22,
      fontWeight: FontWeight.w400,
      color: color ?? Colors.black, // Defina uma cor padrão aqui se necessário
    );
  }
}
