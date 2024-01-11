

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

// 유저명 가져오기
Future<String> getFirebaseUserName() async {
  String user = "";
  var uid = await FirebaseAuth.instance.currentUser?.uid;
  var mem_info = FirebaseDatabase.instance.ref();
  var child = await mem_info.child("member_info/${uid}/name").once();
  var user_name = child.snapshot;
  print(user_name);
  String name = user_name.value.toString();
  print("name : ${name}");
  return name;
}

Future<int> getFirebaseUserKcal() async {
  String user = "";
  var uid = await FirebaseAuth.instance.currentUser?.uid;
  var mem_info = FirebaseDatabase.instance.ref();
  var child = await mem_info.child("member_info/${uid}/kcal").once();
  var user_kcal = child.snapshot;
  print(user_kcal);
  int kcal = user_kcal.value as int;
  print("kcal : ${kcal}");
  return kcal;
}

Future<Map<dynamic, dynamic>> getExerciseRecord() async {
  String user = "";
  var uid = await FirebaseAuth.instance.currentUser?.uid;
  var exercise_data = FirebaseDatabase.instance.ref();
  var child = await exercise_data.child("exercise_data/${uid}").once();
  var record = child.snapshot.value  as Map<dynamic, dynamic>;
  print(record);
  print("기록 : ${record}");
  return record;
}


/*
Future<String?> getUID({String? id}) {
  var databaseRef = FirebaseDatabase.instance.ref();
  return Future.delayed(dbTime).then((value) async {
    var event = await databaseRef.child('users/$id/uid').once();
    var value = event.snapshot;
    String uid;
    if (value.exists) {
      uid = value.value.toString();
    } else {
      uid = 'None';
    }
    print('uid : $uid');
    return uid;
  });
}
* */