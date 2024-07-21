import 'package:flutter/material.dart';
import 'package:la_barber/core/utils/enums/user_status_enum.dart';

class UserStatusDropdown extends StatefulWidget {
  final ValueChanged<UserStatus> onPressed;
  final UserStatus selectedStatus;

  const UserStatusDropdown({
    super.key,
    required this.onPressed,
    required this.selectedStatus,
  });

  @override
  State<UserStatusDropdown> createState() => _UserStatusDropdownState();
}

class _UserStatusDropdownState extends State<UserStatusDropdown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(' Status'),
          const SizedBox(height: 4),
          DropdownButtonFormField<UserStatus>(
            value: widget.selectedStatus,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
            ),
            hint: const Text('Select User Status'),
            onChanged: (UserStatus? newValue) {
              if (newValue != null) {
                widget.onPressed(newValue);
              }
            },
            items: UserStatus.values.map<DropdownMenuItem<UserStatus>>((UserStatus status) {
              return DropdownMenuItem<UserStatus>(
                value: status,
                child: Text(UserStatusHelper.getStatusName(status)),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
