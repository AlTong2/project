import 'package:flutter/material.dart';
import 'package:flutter_altong/constants/constants.dart';

class NewRoutineBtn extends StatelessWidget {
  const NewRoutineBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: 100,
        height: 50,
        child: ElevatedButton(style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.btnColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            )
        )
            ,onPressed: (){},
            child:
            Text("새 루틴 추가")
        ),
      );
  }
}
