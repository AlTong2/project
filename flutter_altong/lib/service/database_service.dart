import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseService{

  DatabaseReference ref = FirebaseDatabase.instance.ref();

  // 루틴 데이터 저장하기
  // 저장 목록 : 루틴 이름, 회원 아이디, 운동 목록( 개수 / 세트 ), 휴식시간
  Future<void> fireBaseSaveRoutine(routineName, routineList, restTime) async {
    // 회원 정보 가져오기
    var auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      String? uid = auth.currentUser?.uid;
      FirebaseDatabase database = FirebaseDatabase.instance;
      DatabaseReference dbref = database.ref("PERSONAL_ROUTINE_INFO");
      return Future.delayed(Duration(seconds: 3)).then((value) async {
        var value = await dbref.child('$uid').get();
        await dbref.child(uid!).push().set({
          'routine_name': routineName,
          'routine_list': routineList,
          'rest_time': restTime,
        });
      }
      );
    }
  }

  // 루틴 데이터 받아오기
  Future<List<dynamic>?> fetchRoutineData() async {
    // 회원 정보 가져오기
    var auth = FirebaseAuth.instance;
    List<dynamic> resultData = [];
    if (auth.currentUser != null) {
      String? uid = auth.currentUser?.uid;
      DatabaseReference dbref = FirebaseDatabase.instance.reference().child("PERSONAL_ROUTINE_INFO").child(uid!);

      // 저장한 데이터 가져오기
      var savedData = await dbref.get();
      if (savedData != null && savedData.value != null) {
        print("저장 데이터: ${savedData.value}");
        Map<dynamic, dynamic> dataMap = jsonDecode(jsonEncode(savedData.value));

        dataMap.forEach((key, value) {
        // 여기서 데이터 처리
        Map<String, dynamic> routinedata = { "key" : key, "value" : dataMap[key]};
        resultData.add(routinedata);
         });
        // 가져온 데이터 처리
      } else {
        print("No data available");
      }
      return resultData;
    }
  }

  // 루틴 데이터 삭제하기
  Future<void> fireBaseDeleteRoutine(routineKey) async{
    // 회원 정보 가져오기
    var auth = FirebaseAuth.instance;
    // 현재 유저가 존재 할 경우
    if (auth.currentUser != null) {
      //현재 유저의 uid 취득후 해당 uid의 데이터 베이스로 접근
      String? uid = auth.currentUser?.uid;
      DatabaseReference dbref = FirebaseDatabase.instance.reference().child("PERSONAL_ROUTINE_INFO").child(uid!);
      dbref.child(routineKey).remove();
    }
  }

  // 루틴 데이터 업데이트
  Future<void> fireBaseUpdateRoutine(key, routineName, routineList, restTime) async {
    // 회원 정보 가져오기
    var auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      String? uid = auth.currentUser?.uid;
      FirebaseDatabase database = FirebaseDatabase.instance;
      DatabaseReference dbref = database.ref("PERSONAL_ROUTINE_INFO");
      return Future.delayed(Duration(seconds: 3)).then((value) async {
        await dbref.child('$uid').child('$key').set({
          'routine_name': routineName,
          'routine_list': routineList,
          'rest_time': restTime,
        });
      }
      );
    }
  }

}