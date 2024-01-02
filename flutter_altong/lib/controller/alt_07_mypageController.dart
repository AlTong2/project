import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_altong/controller/alt_04_mainController.dart';
import 'package:flutter_altong/screen/alt_01_start.dart';
import 'package:flutter_altong/service/database_service.dart';
import 'package:get/get.dart';

class MyPageController extends GetxController{
  MainController mainController = MainController();
  DatabaseService dbService = DatabaseService();
  //TODO 블루투스 연결 기능 추가

  // 로그아웃
  void logout() async {
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.signOut();
      Get.delete<MainController>();
      Get.offAllNamed("/start");
    }
  }

  // 회원정보 수정
  void updateUser(String name, String curPw, String pw, String kcal) async{
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;
      if (user != null && user.email != null) {
        // 사용자가 로그인된 상태일 때, 다시 로그인을 요청하여 최신 인증 정보를 갱신합니다.
        try {
          AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!,
            password: curPw, // 사용자의 현재 비밀번호를 입력합니다.
          );
          await user.reauthenticateWithCredential(credential);
          String? key = auth.currentUser?.uid;
          print("키 칼로리 : ${key},${kcal}");
          // 여기서 비밀번호 업데이트를 수행합니다.
          await user.updatePassword(pw);
          await dbService.fireBaseUpdateKcal(name, key, int.parse(kcal));
          print('비밀번호가 성공적으로 변경되었습니다.');
          Get.delete<MainController>();
          Get.offAllNamed("/start");
        } catch (e) {
          print('Firebase 에러: $e');
        }
      } else {
        // 사용자가 로그인되어 있지 않은 경우, 로그인 화면으로 이동하거나 사용자에게 로그인을 요청합니다.
      }
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력해주세요.';
    } else if (value.length < 6) {
      return '비밀번호를 6자 이상 입력해주세요.';
    }
    return null; // 유효성 검사 통과
  }

}