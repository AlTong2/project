import 'package:flutter/material.dart';

class CalendarModal extends StatelessWidget {
  const CalendarModal({super.key, required this.selectedDay});
  final DateTime? selectedDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      child: ListView(
        children: [
          Center(
            child: Text(
              'Selected Day: $selectedDay',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
