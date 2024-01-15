import 'package:flutter/material.dart';

class ExerciseRestTime extends StatelessWidget {
  const ExerciseRestTime({super.key, required this.time});
  final int time;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible( flex : 2, child: Text("세트당 휴식시간", style: TextStyle(fontFamily: 'pre', fontSize: MediaQuery.of(context).size.width * 0.025),)),
          Flexible( flex : 2,fit: FlexFit.tight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Text("${time~/60} 분 ${time%60} 초", style: TextStyle(fontFamily: 'pre', fontSize: MediaQuery.of(context).size.width * 0.025),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
