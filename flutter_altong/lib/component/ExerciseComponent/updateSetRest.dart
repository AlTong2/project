import 'package:flutter/material.dart';
import 'package:flutter_altong/controller/alt_06_exerciseController.dart';
import 'package:get/get.dart';

class UpdateSetRest extends StatelessWidget {
  const UpdateSetRest({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("휴식시간 설정", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("세트당"),
              Obx(
                    () => Row(
                  children: [
                    IconButton(onPressed: () => Get.find<ExerciseController>().setRest(1),
                        icon: Icon(Icons.add)),
                    Text("${Get.find<ExerciseController>().updateRestTime} 초"),
                    IconButton(onPressed: () => Get.find<ExerciseController>().setRest(0),
                        icon: Icon(Icons.remove))
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );;
  }
}
