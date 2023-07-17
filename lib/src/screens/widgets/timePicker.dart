import 'package:flutter/material.dart';

class Time extends StatefulWidget {
  TimeOfDay time;

  Time({Key? key, required this.time});

  @override
  State<Time> createState() => _TimeState();
}

class _TimeState extends State<Time> {
  @override
  Widget build(BuildContext context) {
    return TimePickerDialog(
      initialTime: widget.time,
      hourLabelText: "Minute",
      minuteLabelText: "Second",
    );
  }
}
