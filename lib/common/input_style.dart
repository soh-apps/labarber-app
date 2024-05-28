import 'package:flutter/material.dart';
import 'package:la_barber/core/ui/app_color.dart';

class InputStyle extends InputDecoration {
  InputStyle({
    super.hintText,
    TextStyle? hintStyle,
    Color? fillColor,
    Color? focusedBorderColor,
    super.label,
    BorderRadiusGeometry? borderRadius,
  }) : super(
          filled: true,
          hintStyle: hintStyle ?? const TextStyle(color: Colors.grey),
          fillColor: fillColor ?? Colors.black,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: focusedBorderColor ?? AppColor.corSecundaria,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(24),
          ),
          border: OutlineInputBorder(
            borderSide:
                BorderSide(color: focusedBorderColor ?? AppColor.corSecundaria),
            borderRadius: BorderRadius.circular(24),
          ),
        );
}
