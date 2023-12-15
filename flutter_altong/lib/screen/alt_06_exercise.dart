import 'package:flutter/material.dart';
import 'package:flutter_altong/component/ExerciseRoutineComponent/newRoutineBtn.dart';
import 'package:flutter_altong/component/ExerciseRoutineComponent/routineListItem.dart';
import 'package:flutter_altong/component/MainComponent/screenNameText.dart';
import 'package:flutter_altong/constants/constants.dart';
import 'package:toggle_list/toggle_list.dart';
import 'package:toggle_list/src/toggle_list_item.dart';


class ALT06Exercise extends StatelessWidget {
  const ALT06Exercise({Key? key});

  @override
  Widget build(BuildContext context) {
    String exercise = "운동";
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            ScreenName(name: exercise),
            Container(
              height: 550,
              margin: EdgeInsets.all(10),
              child: ToggleList(
                children: [
                  ToggleListItem(
                    title: Text("루틴 1"),
                    content: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("운동"),
                              Text("추가")
                            ],
                          ),
                            // TODO 운동 아이템으로 나누기 ?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("스쿼트"),
                                Text("20개/5세트"),
                                Row(
                                  children: [
                                    Text("수정"),
                                    Text("/"),
                                    Text("삭제"),
                                  ],
                                )
                              ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("푸시업"),
                              Text("20개/5세트"),
                              Row(
                                children: [
                                  Text("수정"),
                                  Text("/"),
                                  Text("삭제"),
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("세트당 휴식시간"),
                              Row(
                                children: [
                                  // TODO 시간은 설정하도록
                                  Text("1분"),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                  ),
                ),
                  ToggleListItem(
                    title: Text("루틴 2"),
                    content: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("운동"),
                              Text("추가")
                            ],
                          ),
                          // TODO 운동 아이템으로 나누기 ?
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("스쿼트"),
                              Text("30개/5세트"),
                              Row(
                                children: [
                                  Text("수정"),
                                  Text("/"),
                                  Text("삭제"),
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("풀업"),
                              Text("10개/5세트"),
                              Row(
                                children: [
                                  Text("수정"),
                                  Text("/"),
                                  Text("삭제"),
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("푸시업"),
                              Text("20개/5세트"),
                              Row(
                                children: [
                                  Text("수정"),
                                  Text("/"),
                                  Text("삭제"),
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("세트당 휴식시간"),
                              Row(
                                children: [
                                  // TODO 시간은 설정하도록
                                  Text("1분"),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            // TODO 루틴 추가방법 : modal ?
            NewRoutineBtn()
          ],
        ),
      ),
    );
  }
}