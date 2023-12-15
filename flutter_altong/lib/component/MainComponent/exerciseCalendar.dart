import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ExerciseCarlendar extends StatelessWidget {
  const ExerciseCarlendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: TableCalendar(
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: DateTime.now(),
        ),
      ),
    );
  }
}
