import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_altong/component/MainComponent/chartIndicator.dart';
import 'package:flutter_altong/constants/constants.dart';
import 'package:intl/intl.dart';

class CalendarModal extends StatefulWidget {
  const CalendarModal({super.key, required this.selectedDay, required this.record});
  final DateTime? selectedDay;
  final Map<dynamic, dynamic> record;

  @override
  State<CalendarModal> createState() => _CalendarModalState();
}

class _CalendarModalState extends State<CalendarModal> {
  // TODO 요일 선택시 해당 요일부터 1주일 전까지의 데이터 불러오기.
  List<Map<String, dynamic>> exerciseData = [
    // weekday로 가져올경우 월 = 1 ~ 일 = 7
    /*
    {
      "2024/01/01" :
      {
        "Squat" :
        {
          "count" : 120,
          "weekday" : 1
        },
        "PushUp" :
        {
          "count" : 70,
          "weekday" : 1
        },
        "PullUp" :
        {
          "count" : 10,
          "weekday" : 1
        }
      },
    }
    */
  ];
  List<Map> kcalList = [];
  List<Map> exerciseCountList = [];
  double sumCount = 0.toDouble();

  void loadWeekKcal(){
    // TODO 해당 요일부터 1주일간의 운동데이터 체크 ? 해서 칼로리 계산한 Map 생성
    //일주일간의 데이터 가져오게 했으니 각 날짜 요일 별로 칼로리 산출하기
    List<String> keys = [];
    if(exerciseData.length != 0){
      keys = exerciseData[0].keys.toList();
    }
    List<String> weekDays = [
      'Mon',
      'Tue',
      'Wed',
      'Thur',
      'Fri',
      'Sat',
      'Sun',
    ];
    print("키값 : ${keys}");
    // 각 키에 해당하는 값 가져오기
    // dayKcal[weekDays[(value["Squat"]["weekday"])-1]] = 0;
    for(int j = 0; j < weekDays.length; j++) {
      Map<String, dynamic> dayKcal = {};
      dayKcal['day'] = weekDays[j];
      dayKcal['kcal'] = 0.0;
      kcalList.add(dayKcal);
    }
    for(int j = 0; j < kcalList.length; j++) {
      for (String key in keys) {
        // 요일별 횟수 넣을 Map

        dynamic value = exerciseData[0][key]; // 각 키에 해당하는 값 가져오기
        // print("키: $key, 값: $value");

          if(kcalList[j]["day"] == weekDays[value["Squat"]["weekday"]-1]){
            kcalList[j]["kcal"] = kcalList[j]["kcal"] + ((value["Squat"]["count"] * 0.7));
          }

          if(kcalList[j]["day"] == weekDays[value["PushUp"]["weekday"]-1]){
            kcalList[j]["kcal"] = kcalList[j]["kcal"] + ((value["PushUp"]["count"] * 0.47));
          }

        if(kcalList[j]["day"] == weekDays[value["PullUp"]["weekday"]-1]){
          kcalList[j]["kcal"] = kcalList[j]["kcal"] + ((value["PullUp"]["count"] * 0.3));
        }
      }
    }
  }

  void loadWeekExercise(){
    sumCount = 0;
    // TODO 해당 요일부터 1주일간의 운동데이터 체크 ? 운동별 개수 체크한 Map생성
    List<String> keys = [];
    if(exerciseData.length != 0){
      // keys = exerciseData.map((entry) => entry.keys.first).toList();
      keys = exerciseData[0].keys.toList();
      print("키킼;키 :${keys}");
    }
    List<String> exercise = [
      'Squat',
      'PushUp',
      'PullUp',
    ];
    // 운동 횟수 담을 Map
    for(int j = 0; j < exercise.length; j++) {
      Map<String, dynamic> exerciseCount = {};
      exerciseCount['exercise'] = exercise[j];
      exerciseCount['count'] = 0.toDouble();
      exerciseCountList.add(exerciseCount);
    }

    for (String key in keys) {
      dynamic value = exerciseData[0][key]; // 각 키에 해당하는 값 가져오기
      for(int i = 0; i < exerciseCountList.length; i++){
        if(exerciseCountList[i]["exercise"] == "Squat"){
          exerciseCountList[i]["count"] = (exerciseCountList[i]["count"] as double)+  value["Squat"]["count"];
          sumCount =  sumCount + value["Squat"]["count"];
        }
        if(exerciseCountList[i]["exercise"] == "PushUp"){
          exerciseCountList[i]["count"] = (exerciseCountList[i]["count"] as double)+  value["PushUp"]["count"];
          sumCount =  sumCount + value["PushUp"]["count"];
        }
        if(exerciseCountList[i]["exercise"] == "PullUp"){
          exerciseCountList[i]["count"] = (exerciseCountList[i]["count"] as double)+  value["PullUp"]["count"];
          sumCount =  sumCount + value["PullUp"]["count"];
        }
      }
    }
    print(exerciseCountList);
  }

  void setRecord(){
    // Map<String, dynamic>
    // print(widget.record);
    String formattedDate = "";
    Map<String, dynamic> dateRecord = {};
    for(int i = 0; i < 7; i++){
      DateTime? date = widget.selectedDay?.subtract(Duration(days: i));
      if (date != null) {
        formattedDate = DateFormat('yyyy-MM-dd').format(date);
        if(widget.record[formattedDate] != null){
          print("********${widget.record[formattedDate]}");
           {
             dateRecord[formattedDate] = widget.record[formattedDate];
          };
        }
      }
    }
    exerciseData.add(dateRecord);
    print(exerciseData);
    loadWeekKcal();
    loadWeekExercise();
  }

  @override
  void initState() {
    super.initState();
    setRecord();
  }
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    print("칼로리 그래프에 넣을 데이터${kcalList}");
    print("운동 횟수 :${exerciseCountList}, 총 개수 ${sumCount.toDouble()}");
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Center(
              child: Text(
                '${widget.selectedDay?.year}-${widget.selectedDay?.month}-${widget.selectedDay?.day}일 상세 정보',
                style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05, fontWeight: FontWeight.bold, fontFamily: 'kuk'),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Center(
              child: Text(
                '운동 데이터 분석',
                style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05, fontWeight: FontWeight.bold, fontFamily: 'kuk'),
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
                  sections: List.generate(exerciseCountList.length, (i) {
                    final isTouched = i == touchedIndex;
                    final fontSize = isTouched ? 25.0 : 16.0;
                    final radius = isTouched ? 60.0 : 50.0;
                    const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
                    // 이 밑으로 ListView.builder사용하고, 컴포넌트화하여, 적용
                    switch (exerciseCountList[i]["exercise"]) {
                      case "Squat":
                        return PieChartSectionData(
                          color: AppColors.pieColorOrange,
                          value: exerciseCountList[i]["count"].toDouble(),
                          title: '${(exerciseCountList[i]["count"].toDouble()/sumCount * 100).toStringAsFixed(1)}%',
                          radius: radius,
                          titleStyle: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: shadows,
                          ),
                        );
                      case "PushUp":
                        return PieChartSectionData(
                          color: AppColors.pieColorYellow,
                          value: exerciseCountList[i]["count"].toDouble(),
                          title: '${(exerciseCountList[i]["count"].toDouble()/sumCount * 100).toStringAsFixed(1)}%',
                          radius: radius,
                          titleStyle: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: shadows,
                          ),
                        );
                      case "PullUp":
                        return PieChartSectionData(
                          color: AppColors.pieColorBrown,
                          value: exerciseCountList[i]["count"].toDouble(),
                          title: '${(exerciseCountList[i]["count"].toDouble()/sumCount * 100).toStringAsFixed(1)}%',
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
                      color: AppColors.pieColorOrange,
                      text: '스쿼트',
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    PieChartIndicator(
                      color: AppColors.pieColorYellow,
                      text: '팔굽혀펴기',
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    PieChartIndicator(
                      color: AppColors.pieColorBrown,
                      text: '턱걸이',
                    ),
                    SizedBox(
                      height: 4,
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
                style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05, fontWeight: FontWeight.bold, fontFamily: 'kuk'),
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
                          (rod.toY * 15).round().toString(),
                        const TextStyle(
                          color: AppColors.barColorRed,
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
                barGroups: List.generate(
                  kcalList.length, (index) => BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: kcalList[index]["kcal"] / 15, // 적절한 데이터로 설정
                        width: 20,
                        gradient: _barsGradient,
                      ),
                    ],
                    showingTooltipIndicators: [0],
                  ),
                ),
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
                style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05, fontWeight: FontWeight.bold, fontFamily: 'kuk'),
              ),
            ),
          ),
          Container(
            height: 400,
            child: ListView(
              children: [
                TextButton(onPressed: () {
                }, child: Text("20240104_Squat_01.mp4", textAlign: TextAlign.left,style: TextStyle(fontSize: MediaQuery.of(context).size.width* 0.04 ))),
                TextButton(onPressed: () {
                }, child: Text("20240104_Squat_02.mp4", textAlign: TextAlign.left,style: TextStyle(fontSize: MediaQuery.of(context).size.width* 0.04 ))),
                TextButton(onPressed: () {
                }, child: Text("20240104_PullUp_01.mp4", textAlign: TextAlign.left,style: TextStyle(fontSize: MediaQuery.of(context).size.width* 0.04 ))),
                TextButton(onPressed: () {
                }, child: Text("20240104_PullUp_02.mp4", textAlign: TextAlign.left,style: TextStyle(fontSize: MediaQuery.of(context).size.width* 0.04 )))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: AppColors.barColorRed,
      fontWeight: FontWeight.bold,
      fontSize: MediaQuery.of(context).size.width * 0.035,
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
      AppColors.progressBarGauge,
      AppColors.barColorRed,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

}


