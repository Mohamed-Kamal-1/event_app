import 'package:evently_app/database/model/event.dart';
import 'package:evently_app/extensions/extension_home_screen.dart';
import 'package:flutter/material.dart';

typedef SelectTime = Function(TimeOfDay time);
class EventTimeWidget extends StatefulWidget {
  final Event event;
  final SelectTime selectTime;
 const EventTimeWidget({super.key, required this.event,required this.selectTime});

  @override
  State<EventTimeWidget> createState() => _EventTimeWidgetState();
}

class _EventTimeWidgetState extends State<EventTimeWidget> {
  @override
  Widget build(BuildContext context) {
    final eventTime = TimeOfDay.fromDateTime(
      widget.event.time!,
    ).format(context);
    TimeOfDay initialTime = TimeOfDay.fromDateTime(widget.event.time!);
    return TextButton(
      onPressed: () {
        chooseTime(initialTime);
      },
      child: Text(
        " ${(selectedTime == null) ? eventTime : selectedTime?.format(context)}",
        style: context.fonts.titleSmall,
      ),
    );
  }

  TimeOfDay? selectedTime;

  void chooseTime(TimeOfDay initialTime) async {
    var time = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? initialTime,
    );
    if (time != null) {
      setState(() {
        selectedTime = time;
        widget.selectTime(selectedTime!);
      });
    }
  }
}
