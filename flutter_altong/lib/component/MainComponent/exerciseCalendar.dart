import 'package:flutter/material.dart';
import 'package:flutter_altong/component/MainComponent/calendarModal.dart';
import 'package:table_calendar/table_calendar.dart';

class ExerciseCarlendar extends StatefulWidget {
  const ExerciseCarlendar({super.key});

  @override
  State<ExerciseCarlendar> createState() => _ExerciseCarlendarState();
}

class _ExerciseCarlendarState extends State<ExerciseCarlendar> {
  DateTime _now = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  List<String> days = ['_', '월', '화', '수', '목', '금', '토', '일'];
  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
  }


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: TableCalendar(
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: _now,
          calendarFormat: _calendarFormat,
          daysOfWeekHeight: 30,
          headerStyle: HeaderStyle(
            formatButtonVisible : false,
          ),
          calendarStyle: const CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              )
          ),
          // 날짜 선택 체크
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          // 사용자가 캘린더에 요일을 클릭했을 때
          onDaySelected: (selectedDay, focusedDay) {
            print("선택 날짜 ?${_selectedDay}");
            print("선택 날되어있던 날 ${selectedDay}");
            if (!isSameDay(_selectedDay, selectedDay)) {
              // Call `setState()` when updating the selected day
              setState(() {
                _selectedDay = selectedDay;
                _now = focusedDay;
              });
            } else {
              print("두번 클릭 감지");
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return CalendarModal(selectedDay: selectedDay);
                },
              );
            }
          },
          // 캘린더의 포맷을 변경 (CalendarFormat.month 로 지정)
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              // Call `setState()` when updating calendar format
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            // No need to call `setState()` here
            _now = focusedDay;
          },
          calendarBuilders: CalendarBuilders(
            dowBuilder: (context, day) {
              return Center(child: Text(days[day.weekday])) ;
            }
          ),
        ),
      ),
    );
  }
}
