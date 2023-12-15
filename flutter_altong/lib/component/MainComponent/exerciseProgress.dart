import 'package:flutter/material.dart';
import 'package:flutter_altong/constants/constants.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ExerciseProgress extends StatelessWidget {
  const ExerciseProgress({super.key, required this.currentKcal, required this.goalKcal});
  final int currentKcal;
  final int goalKcal;
  @override
  Widget build(BuildContext context) {
    double percent = currentKcal / goalKcal;
    String curKcal = "${currentKcal}Kcal";
    String glKcal = "${goalKcal}Kcal";
    return Column(
    children: [
      Container(
        alignment: FractionalOffset(percent, 1 - percent),
        child: FractionallySizedBox(
          child: Image.asset('img/running.png', width: 45, height: 45, fit: BoxFit.cover)),
      ),
      LinearPercentIndicator(
        padding: EdgeInsets.only(left: 16.0,right: 16.0),
        percent: percent,
        lineHeight: 40,
        backgroundColor: AppColors.progressBarBackground,
        progressColor: AppColors.progressBarGauge,
        width: MediaQuery.of(context).size.width,
        barRadius: Radius.circular(10),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(curKcal, style: TextStyle(fontSize: 20),),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(glKcal, style: TextStyle(fontSize: 20),),
          ),
        ],
      )
    ])
    ;
  }
}
