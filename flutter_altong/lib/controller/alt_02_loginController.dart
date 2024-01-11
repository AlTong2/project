import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_altong/Firebase.dart';
import 'package:flutter_altong/controller/alt_06_exerciseController.dart';
import 'package:flutter_altong/screen/alt_04_main.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LoginController extends GetxController{
  ExerciseController exerciseController = ExerciseController();

  void loginFunc(String email, String password) async{
    var auth = FirebaseAuth.instance;
    print("로그인 함수");
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (FirebaseAuth.instance.currentUser != null) {
        print(auth.currentUser?.uid);
        print(credential);
        String user = await getFirebaseUserName();
        int kcal = await getFirebaseUserKcal();
        Map<dynamic, dynamic> record = await getExerciseRecord();
        int curKcal = getCurrentKcal(record);
        print("record : ${record}");
        List<String> recordDay = [];
        record.keys.forEach((key) {
          recordDay.add(key.toString()); // 각 키를 String으로 변환하여 리스트에 추가
        });
        print("키 값 : ${recordDay}");
        //exerciseController.getRoutine();
        print("로그인 성공 : ${user}");
        Map<String, dynamic> arguments = {
          'user': user,
          'kcal': kcal,
          'main' : 0,
          'recordDay' : recordDay,
          'record' : record,
          'curKcal' : curKcal
        };
        Get.offAllNamed("/main", arguments: arguments);
      }
    } catch (e) {
      print("로그인 실패: $e");
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

  void reRoad() async{
    print("새로고침 시도");
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        String user = await getFirebaseUserName();
        int kcal = await getFirebaseUserKcal();
        Map<dynamic, dynamic> record = await getExerciseRecord();
        int curKcal = getCurrentKcal(record);
        List<String> recordDay = [];
        record.keys.forEach((key) {
          recordDay.add(key.toString()); // 각 키를 String으로 변환하여 리스트에 추가
        });
        //exerciseController.getRoutine();
        print("새로고침 성공 : ${user}");
        Map<String, dynamic> arguments = {
          'user': user,
          'kcal': kcal,
          'main' : 0,
          'recordDay' : recordDay,
          'record' : record,
          'curKcal' : curKcal
        };
        Get.offAllNamed("/main", arguments: arguments);
      }
    } catch (e) {
      print("새로고침 실패: $e");
    }
  }


 }


