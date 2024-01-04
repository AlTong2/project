import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_altong/component/MainComponent/chartIndicator.dart';
import 'package:flutter_altong/constants/constants.dart';

class CalendarModal extends StatefulWidget {
  const CalendarModal({super.key, required this.selectedDay});
  final DateTime? selectedDay;

  @override
  State<CalendarModal> createState() => _CalendarModalState();
}

class _CalendarModalState extends State<CalendarModal> {
  // TODO 요일 선택시 해당 요일의 데이터 불러오기
  List<Map<dynamic, dynamic>> ExerciseData = [
      {
        "monday" :
        {
           "Squart" :{
             "count" : 120
           },
           "PushUp" : {
            "count" : 70
           },
           "PullUp" : {
            "count" : 10
          }
        },
        "tuesday" :
        {
          "Squart" :{
            "count" : 75
          },
          "PushUp" : {
            "count" : 60
          },
          "PullUp" : {
            "count" : 20
          }
        },
        "wednesday" :
        {
          "Squart" :{
            "count" : 100
          },
          "PushUp" : {
            "count" : 20
          },
          "PullUp" : {
            "count" : 40
          }
        },
        "thursday" :
        {
          "Squart" :{
            "count" : 55
          },
          "PushUp" : {
            "count" : 25
          },
          "PullUp" : {
            "count" : 15
          }
        }
      }
  ];

  int touchedIndex = -1;

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Color(0xFF2196F3),
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Color(0xFFFFC300),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Color(0xFF6E1BFF),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Color(0xFF3BFF49),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Center(
              child: Text(
                '${widget.selectedDay?.year}-${widget.selectedDay?.month}-${widget.selectedDay?.day}일 상세 정보',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Center(
              child: Text(
                '운동 데이터 분석',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(width: 24,),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width * 0.55, // 너비 전체 사용
                height: MediaQuery.of(context).size.height * 0.35,
                child: PieChart(
                PieChartData(
                  // sections에 운동별 %표시하는 방법 추가
                  sections: List.generate(4, (i) {
                    final isTouched = i == touchedIndex;
                    final fontSize = isTouched ? 25.0 : 16.0;
                    final radius = isTouched ? 60.0 : 50.0;
                    const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
                    // 이 밑으로 ListView.builder사용하고, 컴포넌트화하여, 적용
                    switch (i) {
                      case 0:
                        return PieChartSectionData(
                          color: Color(0xFF2196F3),
                          value: 40,
                          title: '40%',
                          radius: radius,
                          titleStyle: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: shadows,
                          ),
                        );
                      case 1:
                        return PieChartSectionData(
                          color: Color(0xFFFFC300),
                          value: 30,
                          title: '30%',
                          radius: radius,
                          titleStyle: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: shadows,
                          ),
                        );
                      case 2:
                        return PieChartSectionData(
                          color: Color(0xFF6E1BFF),
                          value: 15,
                          title: '15%',
                          radius: radius,
                          titleStyle: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: shadows,
                          ),
                        );
                      case 3:
                        return PieChartSectionData(
                          color: Color(0xFF3BFF49),
                          value: 15,
                          title: '15%',
                          radius: radius,
                          titleStyle: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: shadows,
                          ),
                        );
                      default:
                        throw Error();
                    }
                  }),
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                ),
                swapAnimationDuration: Duration(milliseconds: 150), // Optional
                swapAnimationCurve: Curves.linear, // Optional
                ),
              ),
              SizedBox(width: 24,),
              // 그래프 옆에 운동 목록 표시
              Container(
                margin: EdgeInsets.only(top: 140),
                // 여기도 ListView사용해서 유동적으로 변경 ?
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PieChartIndicator(
                      color: Color(0xFF2196F3),
                      text: '팔굽혀펴기',
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    PieChartIndicator(
                      color: Color(0xFFFFC300),
                      text: '스쿼트',
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    PieChartIndicator(
                      color: Color(0xFF6E1BFF),
                      text: '턱걸이',
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    PieChartIndicator(
                      color:  Color(0xFF3BFF49),
                      text: '런지',
                    ),
                    SizedBox(
                      height: 18,
                    ),
                  ],
                ),
              ),
            ],
          ),
          // 일별 소모 칼로리
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Center(
              child: Text(
                '일별 칼로리 분석',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // 일별 소모 칼로리 그래프
          Container(
            margin: EdgeInsets.only(top: 25),
            width: MediaQuery.of(context).size.width * 0.55, // 너비 전체 사용
            height: MediaQuery.of(context).size.height * 0.45,
            child: BarChart(
              BarChartData(
                // barTouchData
                barTouchData: BarTouchData(
                  enabled: false,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.transparent,
                    tooltipPadding: EdgeInsets.zero,
                    tooltipMargin: 8,
                    getTooltipItem: (
                        BarChartGroupData group,
                        int groupIndex,
                        BarChartRodData rod,
                        int rodIndex,
                        ) {
                      return BarTooltipItem(
                          (rod.toY*15).round().toString(),
                        const TextStyle(
                          color: AppColors.contentColorCyan,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
                // titlesData
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: getTitles,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                // borderData
                borderData: FlBorderData(
                  show: false,
                ),
                // barGroups
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(
                        toY: 150/15,
                        width: 20,
                        gradient: _barsGradient,
                      )
                    ],
                    showingTooltipIndicators: [0],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData(
                        toY: 100/15,
                        width: 20,
                        gradient: _barsGradient,
                      )
                    ],
                    showingTooltipIndicators: [0],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [
                      BarChartRodData(
                        toY: 140/15,
                        width: 20,
                        gradient: _barsGradient,
                      )
                    ],
                    showingTooltipIndicators: [0],
                  ),
                  BarChartGroupData(
                    x: 3,
                    barRods: [
                      BarChartRodData(
                        toY: 170/15,
                        width: 20,
                        gradient: _barsGradient,
                      )
                    ],
                    showingTooltipIndicators: [0],
                  ),
                  BarChartGroupData(
                    x: 4,
                    barRods: [
                      BarChartRodData(
                        toY: 130/15,
                        width: 20,
                        gradient: _barsGradient,
                      )
                    ],
                    showingTooltipIndicators: [0],
                  ),
                  BarChartGroupData(
                    x: 5,
                    barRods: [
                      BarChartRodData(
                        toY: 270/15,
                        width: 20,
                        gradient: _barsGradient,
                      )
                    ],
                    showingTooltipIndicators: [0],
                  ),
                  BarChartGroupData(
                    x: 6,
                    barRods: [
                      BarChartRodData(
                        toY: 160/15,
                        width: 20,
                        gradient: _barsGradient,
                      )
                    ],
                    showingTooltipIndicators: [0],
                  ),
                ],
                gridData: FlGridData(show: false),
                alignment: BarChartAlignment.spaceAround,
                maxY: 20,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Center(
              child: Text(
                '영상 체크',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            height: 400,
            child: Center(child: Text("준비중입니다.")),
          )
        ],
      ),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: AppColors.contentColorBlue,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Mn';
        break;
      case 1:
        text = 'Te';
        break;
      case 2:
        text = 'Wd';
        break;
      case 3:
        text = 'Tu';
        break;
      case 4:
        text = 'Fr';
        break;
      case 5:
        text = 'St';
        break;
      case 6:
        text = 'Sn';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  LinearGradient get _barsGradient => LinearGradient(
    colors: [
      AppColors.contentColorBlue,
      AppColors.contentColorCyan,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

}


