import 'package:flutter/material.dart';
import 'package:madeit/composition/common/constants/strings.dart';
import 'package:madeit/composition/common/properties/text_style.dart';
import 'package:madeit/composition/common/widgets/navigation_bar.dart';

class MyRoomListPage extends StatelessWidget {
  const MyRoomListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.myRoutine),
      ),
      body: ListView(
        children: [
          for (int i = 0; i < 6; i++)
            if (i % 2 == 1)
              const Divider(height: 0.0)
            else
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed("/room");
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Expanded(
                            child: Text(
                              "하루에 만 보 걷기 🚶‍♂️",
                              style: TitleTextStyle(),
                            ),
                          ),
                          Text(
                            "오후 2:30",
                            style: CaptionTextStyle(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2.0),
                      RichText(
                        text: TextSpan(
                          style: const CaptionTextStyle(),
                          children: [
                            TextSpan(
                              text: "16명",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(
                              text: " 평균 성공률 ",
                            ),
                            TextSpan(
                              text: "86%",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(
                              text: " 나의 성공률 ",
                            ),
                            TextSpan(
                              text: "93%",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "오진수님 열심히 좀 해보세요 님이 제일 말 안 듣고 문제에요",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: BodyTextStyle(
                          color: Colors.grey[600]!,
                        ),
                      ),
                    ],
                  ),
                ),
              )
        ],
      ),
      bottomNavigationBar: const AppNavigationBar(currentIndex: 1),
    );
  }
}
