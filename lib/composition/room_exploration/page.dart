import 'package:antenna/builder.dart';
import 'package:flutter/material.dart';
import 'package:madeit/application/stores/list_of_room.dart';
import 'package:madeit/composition/common/constants/strings.dart';
import 'package:madeit/composition/common/properties/text_style.dart';
import 'package:madeit/composition/common/widgets/navigation_bar.dart';

class RoomExplorationPage extends StatelessWidget {
  const RoomExplorationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: watch(listOfRoomStore)((value) {
        if (value == null) {
          return const SizedBox();
        }

        return ListView(
          children: [
            for (int i = 0; i < value.items.length * 2; i++)
              if (i % 2 == 1)
                const Divider(height: 0.0)
              else
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed("/room/preview");
                  },
                  child: Ink(
                    color: Colors.white,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 16.0,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "하루에 만 보 걷기 🚶‍♂️",
                                  style: TitleTextStyle(),
                                ),
                                const SizedBox(height: 2.0),
                                const Text(
                                  "만 걸음 걸을 때마다 하루씩 젊어져요!",
                                  style: BodyTextStyle(),
                                ),
                                const SizedBox(height: 4.0),
                                Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        style: const CaptionTextStyle(),
                                        children: [
                                          TextSpan(
                                            text: "조대훈",
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: " · 참여 인원 ",
                                          ),
                                          TextSpan(
                                            text:
                                                "${value.items[i ~/ 2].participantCount}",
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: "/20명",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "평균 성공률",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2.0),
                              Text(
                                "95%",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 4.0)
                        ],
                      ),
                    ),
                  ),
                ),
          ],
        );
      }),
      bottomNavigationBar: const AppNavigationBar(currentIndex: 0),
      appBar: AppBar(
        title: const Text(Strings.exploration),
      ),
    );
  }
}
