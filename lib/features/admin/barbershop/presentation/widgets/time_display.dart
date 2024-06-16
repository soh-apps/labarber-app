import 'package:flutter/material.dart';

class TimeDisplay extends StatelessWidget {
  final String label;
  final TimeOfDay? time;
  final VoidCallback onSelectTime;

  const TimeDisplay({
    super.key,
    required this.label,
    required this.time,
    required this.onSelectTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onSelectTime,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              time != null ? time!.format(context) : '--:--',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
