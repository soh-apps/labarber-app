import 'package:flutter/material.dart';
import 'package:la_barber/core/ui/widgets/barbershop_loader.dart';

void showLoadingDialog(BuildContext context, {String message = "Loading"}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const BarbershopLoader();
    },
  );
}

void hideLoadingDialog(BuildContext context) {
  if (Navigator.of(context, rootNavigator: true).canPop()) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
