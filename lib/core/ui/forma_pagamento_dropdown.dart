import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class FormaPagamentoDropdown extends StatelessWidget {
  final String? dropdownValue;
  final ValueChanged<String?> onChanged;
  final String? hintText;

  const FormaPagamentoDropdown({
    super.key,
    required this.dropdownValue,
    required this.onChanged,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        style: const TextStyle(color: Colors.black),
        value: dropdownValue,
        onChanged: onChanged,
        items: <String>['Cartão de crédito', 'Cartão de débito', 'PIX', 'Dinheiro', 'MENSALISTA']
            .map<DropdownMenuItem<String>>(
          (String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          },
        ).toList(),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: const Color(0xFFE8E8E8),
          ),
          offset: const Offset(0, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all(6),
            thumbVisibility: MaterialStateProperty.all(true),
          ),
        ),
        buttonStyleData: ButtonStyleData(
          height: 44,
          width: double.maxFinite,
          padding: const EdgeInsets.only(left: 14, right: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black26,
            ),
            color: const Color(0xFFE8E8E8),
          ),
          elevation: 2,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
        hint: hintText != null ? Text(hintText!) : null,
      ),
    );
  }
}
