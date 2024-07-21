import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelectorButton extends StatefulWidget {
  final ValueChanged<DateTime> onDateSelected;
  final String titulo;

  const DateSelectorButton({
    super.key,
    required this.onDateSelected,
    this.titulo = '',
  });

  @override
  DateSelectorButtonState createState() => DateSelectorButtonState();
}

class DateSelectorButtonState extends State<DateSelectorButton> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      widget.onDateSelected(picked); // Passa a data selecionada de volta ao widget pai
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.titulo),
        ElevatedButton(
          onPressed: () {
            setState(() {
              // Sua lógica para alterar o mês aqui, se necessário
            });
          },
          child: GestureDetector(
            onTap: () => _selectDate(context),
            child: Text(
              DateFormat('dd/MM/yyyy').format(_selectedDate),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
