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
          Text("휴식시간 설정", style: TextStyle(fontSize: MediaQuery.of(context).size.width* 0.04, fontFamily: 'pre')),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("세트당",style: TextStyle(fontFamily: 'pre')),
              Obx(
                    () => Row(
                  children: [
                    IconButton(onPressed: () => Get.find<RoutineController>().setRest(0),
                        icon: Icon(Icons.remove)),
                    Text("${Get.find<RoutineController>().rest} 초",style: TextStyle(fontFamily: 'pre'),),
                    IconButton(onPressed: () => Get.find<RoutineController>().setRest(1),
                        icon: Icon(Icons.add)),
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
