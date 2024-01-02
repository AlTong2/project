import 'package:flutter/material.dart';

class PieChartIndicator extends StatelessWidget {
  const PieChartIndicator({super.key, required this.color, required this.text});
  final Color color;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.square, color: color,),
        Text(text)
      ],
    );
  }
}
