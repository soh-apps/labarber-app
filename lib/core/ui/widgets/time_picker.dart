import 'package:flutter/material.dart';

class TimePickerButton extends StatefulWidget {
  final ValueChanged<TimeOfDay> onTimeChanged;

  const TimePickerButton({super.key, required this.onTimeChanged});

  @override
  _TimePickerButtonState createState() => _TimePickerButtonState();
}

class _TimePickerButtonState extends State<TimePickerButton> {
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = TimeOfDay.now();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
      widget.onTimeChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => _selectTime(context),
        child: Text('Hora: ${_selectedTime.format(context)}'),
      ),
    );
  }
}
