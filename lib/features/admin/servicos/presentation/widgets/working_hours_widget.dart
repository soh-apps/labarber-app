import 'package:flutter/material.dart';
import 'package:la_barber/features/admin/barbershop/repository/models/working_hour.dart';

class WorkingHoursWidget extends StatefulWidget {
  final List<WorkingHour> workingHours;

  const WorkingHoursWidget({super.key, required this.workingHours});

  @override
  WorkingHoursWidgetState createState() => WorkingHoursWidgetState();
}

class WorkingHoursWidgetState extends State<WorkingHoursWidget> {
  int? selectedDay;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // List of days of the week
        SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildDayButton(1, 'Seg'),
              _buildDayButton(2, 'Ter'),
              _buildDayButton(3, 'Qua'),
              _buildDayButton(4, 'Qui'),
              _buildDayButton(5, 'Sex'),
              _buildDayButton(6, 'Sab'),
              _buildDayButton(7, 'Dom'),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Display working hours for the selected day
        if (selectedDay != null)
          Column(
            children: widget.workingHours
                .where((wh) => wh.workingDays.contains(selectedDay))
                .map((wh) => ListTile(
                      title: Text('Início: ${wh.startingHour}, Fim: ${wh.endingHour}'),
                    ))
                .toList(),
          ),
      ],
    );
  }

  Widget _buildDayButton(int day, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedDay = day;
          });
        },
        child: Text(label),
      ),
    );
  }
}
