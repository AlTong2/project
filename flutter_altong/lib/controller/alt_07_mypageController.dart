import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_altong/controller/alt_04_mainController.dart';
import 'package:flutter_altong/controller/alt_08_chatController.dart';
import 'package:flutter_altong/screen/alt_01_start.dart';
import 'package:flutter_altong/service/database_service.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class MyPageController extends GetxController{
  MainController mainController = MainController();
  DatabaseService dbService = DatabaseService();
  //TODO 블루투스 연결 기능 추가
  RxBool scanning = false.obs;
  RxList scanResults = [].obs;
  RxList scanResultsInfo = [].obs;
  // FlutterBluePlus flutterBlue = FlutterBluePlus();

  // 로그아웃
  void logout() async {
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.signOut();
      Get.delete<MainController>();
      Get.delete<ChatController>();
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

  // 블루투스 초기화
  Future<void> initializeBluetooth() async {
    print("블루투스 연결 진행");
    // 블루투스가 장치에서 지원되는지 확인합니다.
    if (await FlutterBluePlus.isSupported == false) {
      print("이 장치에서는 블루투스를 지원하지 않습니다");
      return;
    }

    var subscription = FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) async {
      print("상태 : ${state}");
      if (state == BluetoothAdapterState.on) {
        // 일반적으로 스캔 시작, 연결 등의 작업을 수행합니다.
      } else {
        print("블루투스가 꺼져있습니다.");
      }
    });
    print("종료.");
    // 중복 리스너를 방지하기 위해 취소합니다.
    // subscription.cancel();
  }


  // bluetooth 스캔함수
  Future<void> scanBluetoothDevices() async {
    // 블루투스 스캔 결과를 듣는 Subscription
     var subscription = await FlutterBluePlus.onScanResults.listen((results) {
      print("블루투스가 장치 스캔하러 옴.");
      print("결과 : ${results}");
      // 발견된 장치가 있으면 정보를 출력
      if (results.isNotEmpty) {
        ScanResult r = results.last;
        for (ScanResult r in results) {
          if(r.advertisementData.advName != ""){
            print('${r.device.remoteId}: "${r.advertisementData.advName}" 장치 발견!');
            Map<String, dynamic> rInfo = {"id" : r.device.remoteId, "name" : r.advertisementData.advName };
            bool keyExists = false;
            for (int i = 0; i < scanResultsInfo.length; i++) {
              if (scanResultsInfo[i]["id"] == r.device.remoteId &&
                  scanResultsInfo[i]["name"] == r.advertisementData.advName) {
                keyExists = true;
                break;
              }
            }
            if(!keyExists){
              scanResultsInfo.add(rInfo);
              scanResults.add(r);
            }
          }
        }
        print('${r.device.remoteId}: "${r.advertisementData.advName}" 장치 발견!');
      }
    }, onError: (e) => print("블루투스 스캔중 에러 : ${e}"));
    // 스캔이 완료되면 Subscription을 취소
    FlutterBluePlus.cancelWhenScanComplete(subscription);

    // 블루투스 어댑터 상태가 On 상태가 될 때까지 기다림
    await FlutterBluePlus.adapterState
        .where((val) => val == BluetoothAdapterState.on)
        .first;

    // 블루투스 검색 조건
    await FlutterBluePlus.startScan(
      // withServices: [Guid("180D")],
      withNames: ['altong-desktop'],
      timeout: Duration(seconds: 30),
    );
    // 스캔이 완료될 때까지 대기
    await FlutterBluePlus.isScanning.where((val) => val == false).toList();
    // 스캔 결과에 대한 구독을 취소합니다.
    subscription.cancel();
    // print("블루투스 장치 스캔이 완료되었습니다.");
    print("결과 ? ${scanResults}");

  }

  // 선택한 장치와 연결하는 함수
  Future<void> connectToDevice(ScanResult selectedDevice) async {
    try {
      // 선택한 장치에 연결을 시도합니다.
      await selectedDevice.device.connect();
      print('연결 성공: ${selectedDevice.device.platformName}');
    } catch (e) {
      print('연결 실패: $e');
    }
  }

  void getConnectedDevices() async {
    FlutterBluePlus flutterBlue = FlutterBluePlus();
    print("연결 확인");
    // 현재 연결된 장치 목록 가져오기
    List<BluetoothDevice> connectedDevices = await FlutterBluePlus.connectedDevices;

    // 연결된 장치 목록 출력
    connectedDevices.forEach((device) {
      print('연결된 기기: ${device.platformName} (${device.remoteId})');
    });
  }

// 사용 예시
  void main() {
    getConnectedDevices();
  }

}// EndController

