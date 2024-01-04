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
  // TODO 로그인시 해당 유저의 운동한 날짜만 받아와서 데이터 넣기
  final Map<DateTime?, dynamic> _events = {
    DateTime(2023, 12, 18) : DateTime(2023, 12, 18),
    DateTime(2023, 12, 19) : DateTime(2023, 12, 19),
    DateTime(2023, 12, 20) : DateTime(2023, 12, 20),
    DateTime(2023, 12, 21) : DateTime(2023, 12, 21),
    DateTime(2023, 12, 22) : DateTime(2023, 12, 22),
    DateTime(2023, 12, 23) : DateTime(2023, 12, 23),
    DateTime(2023, 12, 29) : DateTime(2023, 12, 29)
  };

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
  }


  @override
  Widget build(BuildContext context) {
    print(_events[DateTime(2023, 12, 23)]);
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
                  // TODO 해당날짜를 불렀을때 컨트롤러로 이동하게 수정 ? 날짜 받아오기 아니면 날짜가지고 modal안에서 설정 ?
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
            },
            markerBuilder: (context, date, events) {
              DateTime _date = DateTime(date.year, date.month, date.day);
              if ( isSameDay(_date, _events[_date] )) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.only( left: 5,bottom: 10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check, color: Colors.red, size: 35,),
                );
              }
            },
          ),

        ),
      ),
    );
  }
}
