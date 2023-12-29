import 'package:flutter/material.dart';
import 'package:toggle_list/src/toggle_list_item.dart';

class RoutineListItem extends StatelessWidget {
  const RoutineListItem({super.key, required this.routineTitle});
  final String routineTitle;

  @override
  Widget build(BuildContext context) {
    return ToggleListItem(
      title: Text(routineTitle),
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
    );
  }
}
