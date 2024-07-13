import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:la_barber/features/admin/barber/repository/models/barber_model.dart';

class CaixaSelecaoBarbeiros extends StatelessWidget {
  final String barbeiroSelecionado;
  final List<BarberModel> listaBarbeiros;
  final ValueChanged<String?> onChanged;

  const CaixaSelecaoBarbeiros({
    super.key,
    required this.barbeiroSelecionado,
    required this.listaBarbeiros,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        style: const TextStyle(color: Colors.black),
        hint: const Text('Selecione um Barbeiro'),
        value: barbeiroSelecionado,
        onChanged: (newValue) {
          onChanged(newValue);
        },
        items: listaBarbeiros.map((barbeiro) {
          return DropdownMenuItem<String>(
            value: barbeiro.id.toString(), // Valor associado ao barbeiro (pode ser o nome ou o ID)
            child: Text(barbeiro.name),
          );
        }).toList(),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: kIsWeb ? 200 : null,
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
          width: kIsWeb ? 300 : double.maxFinite,
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
      ),
    );
  }
}
