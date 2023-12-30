import 'package:flutter/material.dart';
import 'package:flutter_altong/component/RoutineSettingComponent/mediumBtn.dart';
import 'package:flutter_altong/constants/constants.dart';
import 'package:flutter_altong/controller/alt_10_routineController.dart';
import 'package:get/get.dart';

class SetRestTime extends StatelessWidget {
  const SetRestTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("휴식시간 설정", style: TextStyle(fontSize: 18)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("세트당"),
              Obx(
                    () => Row(
                  children: [
                    IconButton(onPressed: () => Get.find<RoutineController>().setRest(1),
                        icon: Icon(Icons.add)),
                    Text("${Get.find<RoutineController>().rest} 초"),
                    IconButton(onPressed: () => Get.find<RoutineController>().setRest(0),
                        icon: Icon(Icons.remove))
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
