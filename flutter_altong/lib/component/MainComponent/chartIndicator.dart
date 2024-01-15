import 'package:flutter/material.dart';

class PieChartIndicator extends StatelessWidget {
  const PieChartIndicator({super.key, required this.color, required this.text});
  final Color color;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Icon(Icons.square, color: color,size: MediaQuery.of(context).size.width*0.04,),
          Text(text, style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03, fontFamily: 'pre'),)
        ],
      ),
    );
  }
}
