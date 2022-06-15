import 'package:flutter/material.dart';
import 'package:madeit/composition/common/properties/text_style.dart';
import 'package:madeit/composition/common/widgets/avatar.dart';

class RoomNotificationListPage extends StatelessWidget {
  const RoomNotificationListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("공지사항 📢"),
        titleSpacing: 0.0,
      ),
      body: ListView(
        children: [
          for (int i = 0; i < 10; i++)
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey[200]!),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      const Avatar(radius: 12.0),
                      const SizedBox(width: 8.0),
                      Text(
                        "조대훈",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        " 2022.03.12 공지",
                        style: CaptionTextStyle(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  const Text(
                    "무슨 공지를 이렇게 길게 써요",
                    style: BodyTextStyle(),
                  ),
                  const SizedBox(height: 4.0),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
