import 'package:flutter/material.dart';
import 'package:la_barber/core/formatters.dart';
import 'package:la_barber/core/ui/constants.dart';

class WeekdaysPanel extends StatelessWidget {
  final List<String>? enabledDays;
  final ValueChanged<String> onDayPressed;
  const WeekdaysPanel({
    super.key,
    required this.onDayPressed,
    this.enabledDays,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selecione os dias da semana',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonDay(
                  label: 'Seg',
                  onDaySelected: onDayPressed,
                  enabledDays: enabledDays,
                  index: 2,
                ),
                ButtonDay(
                  label: 'Ter',
                  onDaySelected: onDayPressed,
                  enabledDays: enabledDays,
                  index: 3,
                ),
                ButtonDay(
                  label: 'Qua',
                  onDaySelected: onDayPressed,
                  enabledDays: enabledDays,
                  index: 4,
                ),
                ButtonDay(
                  label: 'Qui',
                  onDaySelected: onDayPressed,
                  enabledDays: enabledDays,
                  index: 5,
                ),
                ButtonDay(
                  label: 'Sex',
                  onDaySelected: onDayPressed,
                  enabledDays: enabledDays,
                  index: 6,
                ),
                ButtonDay(
                  label: 'Sab',
                  onDaySelected: onDayPressed,
                  enabledDays: enabledDays,
                  index: 7,
                ),
                ButtonDay(
                  label: 'Dom',
                  onDaySelected: onDayPressed,
                  enabledDays: enabledDays,
                  index: 1,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ButtonDay extends StatefulWidget {
  final List<String>? enabledDays;
  final String label;
  final int index;
  final ValueChanged<String> onDaySelected;

  const ButtonDay({
    super.key,
    required this.label,
    required this.index,
    required this.onDaySelected,
    this.enabledDays,
  });

  @override
  State<ButtonDay> createState() => _ButtonDayState();
}

class _ButtonDayState extends State<ButtonDay> {
  var selected = false;

  @override
  Widget build(BuildContext context) {
    final textColor = selected ? Colors.white : ColorConstants.colorGrey;
    var buttonColor = selected ? ColorConstants.colorBrown : Colors.white;
    final buttonBorderColor = selected ? ColorConstants.colorBrown : ColorConstants.colorGrey;

    final ButtonDay(:enabledDays, :label) = widget;

    final disableDay = enabledDays != null && !enabledDays.contains(label);
    if (disableDay) {
      buttonColor = Colors.grey[400]!;
    }

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: disableDay
            ? null
            : () {
                widget.onDaySelected(Formatters.getDayofWeek(widget.index));
                setState(() {
                  selected = !selected;
                });
              },
        child: Container(
          width: 40,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: buttonColor,
            border: Border.all(
              color: buttonBorderColor,
            ),
          ),
          child: Center(
              child: Text(
            label,
            style: TextStyle(fontSize: 12, color: textColor, fontWeight: FontWeight.w500),
          )),
        ),
      ),
    );
  }
}
