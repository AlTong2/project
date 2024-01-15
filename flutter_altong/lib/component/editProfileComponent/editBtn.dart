import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  const EditButton({super.key, required this.text, required this.btnFunc, required this.color});
  final String text;
  final VoidCallback btnFunc;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width *0.75,
      height: MediaQuery.of(context).size.height *0.08,
      padding: EdgeInsets.all(5),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
              )
          ),
          onPressed: btnFunc,
          child: Text(text, style: TextStyle(fontFamily: 'pre'),)),
    );
  }

}
