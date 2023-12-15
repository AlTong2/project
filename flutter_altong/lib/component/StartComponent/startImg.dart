import 'package:flutter/cupertino.dart';

class MainImg extends StatelessWidget {
  const MainImg({super.key, required this.image});
  final Widget image;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: image,
    );
  }
}
