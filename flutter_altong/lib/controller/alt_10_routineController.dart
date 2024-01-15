import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_altong/Firebase.dart';
import 'package:flutter_altong/controller/alt_06_exerciseController.dart';
import 'package:flutter_altong/service/database_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RoutineController extends GetxController{
  List<String> exerciseList = ['스쿼트', '턱걸이', '팔굽혀펴기'];
  RxString selectExercise = "".obs;
  RxInt count = 0.obs;
  RxInt set = 0.obs;
  RxInt rest = 0.obs;
  // 루틴명
  RxString routineName = "".obs;
  // 루틴 운동 리스트
  RxList routine = [].obs;
  ExerciseController exerciseController = ExerciseController();
  DatabaseService dbService = DatabaseService();

  void select(exercise){
    selectExercise.value = exercise;
  }

  void setCount(pm){
    if(pm == 1) {
      count.value += 1;
    } else {
      if(count.value != 0){
        count.value -= 1;
      }
    }
  }
  void setSet(pm){
    if(pm == 1) {
      set.value += 1;
    } else {
      if(set.value != 0){
        set.value -= 1;
      }
    }
  }

  void setRest(pm){
    if(pm == 1) {
      rest.value += 10;
    } else {
      if(rest.value != 0){
        rest.value -= 10;
      }
    }
  }

  void deleteExercise(num){
    routine.removeAt(num);
  }

  void exerciseConfirm(){
    String name = selectExercise.value;
    int cnt = count.value;
    int setNum = set.value;
    if (name != ""  && setNum != 0 && cnt != 0){
      Map<String, dynamic> exercise = {
        //"num": routine.length,
        "exercise": name,
        "count": cnt,
        "set": setNum,
      };
      routine.add(exercise);
      selectExercise.value = exerciseList[0];
      count.value = 0;
      set.value = 0;
    }
    //print(routine);
  }
  // 루틴 이름 변경
  void updateText(String name) {
    routineName.value = name;
  }

  // 루틴 저장
  void saveRoutine() async{
    // RxList 값을 복사해서 사용
    List<dynamic> routineList = List.from(routine.value);
    // 루틴명이 존재하고, 루틴리스트에 1개이상의 루틴이있고, 쉬는시간이 0이상일때;
    if(routineName.value != "" && routineList.length != 0 && rest.value != 0){
      await dbService.fireBaseSaveRoutine(routineName.value, routineList, rest.value);
      routine.clear();
      rest.value = 0;
      routineName.value = "";
      String user = await getFirebaseUserName();
      int kcal = await getFirebaseUserKcal();
      Map<dynamic, dynamic> record = await getExerciseRecord();
      int curKcal = getCurrentKcal(record);
      List<String> recordDay = [];
      record.keys.forEach((key) {
        recordDay.add(key.toString()); // 각 키를 String으로 변환하여 리스트에 추가
      });
      Map<String, dynamic> arguments = {
        'user': user,
        'kcal': kcal,
        'recordDay' : recordDay,
        'record' : record,
        'curKcal' : curKcal
      };
      Get.offAllNamed("/main", arguments: arguments);
    }
    else{
      print("else");
      // 없는거 스낵바로 알려주기 ? 리턴 ?필요 ?
    }
  }

  int getCurrentKcal(Map<dynamic, dynamic> record) {
    print("현재 칼로리 구하러 옴 ?");
    int result = 0;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    print(formattedDate);
    int dayOfWeek = now.weekday;
    print(dayOfWeek);
    DateTime yesterday = now.subtract(Duration(days: 1));
    // 오늘 요일까지 반복
    double sum = 0.0;
    for(int i = 0; i < dayOfWeek; i++){
      // ex 화요일이면 2번 반복 (0~1까지)
      String day = DateFormat('yyyy-MM-dd').format(now.subtract(Duration(days: i)));
      // 반복한 날짜의 key값이 record에 존재 하나 확인
      if(record[day] != null){
        if(record[day]["PullUp"] != null){
          sum += (record[day]["PullUp"]["count"] as int)* 0.3;
        }
        if(record[day]["Squat"] != null){
          sum += (record[day]["Squat"]["count"] as int) * 0.7;
        }
        if(record[day]["PushUp"] != null){
          sum += (record[day]["PushUp"]["count"] as int) * 0.47;
        }
        print("${day}의 기록 : ${record[day]}");
      }
    }
    result = sum.round();
    return result;
  }

}