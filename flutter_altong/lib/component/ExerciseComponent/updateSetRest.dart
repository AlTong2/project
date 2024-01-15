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
          Text("휴식시간 설정", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04, fontFamily: 'pre', fontWeight: FontWeight.w500)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("세트당", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03, fontFamily: 'pre')),
              Obx(
                    () => Row(
                  children: [
                    IconButton(onPressed: () => Get.find<ExerciseController>().setRest(0),
                        icon: Icon(Icons.remove, size:  MediaQuery.of(context).size.width * 0.04)),
                    Text("${Get.find<ExerciseController>().updateRestTime} 초",style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03, fontFamily: 'pre')),
                    IconButton(onPressed: () => Get.find<ExerciseController>().setRest(1),
                        icon: Icon(Icons.add, size:  MediaQuery.of(context).size.width * 0.04,)),
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
