import 'package:antenna/antenna.dart';
import 'package:flutter/material.dart';
import 'package:madeit/application/stores/list_of_room.dart';
import 'package:madeit/composition/common/constants/strings.dart';
import 'package:madeit/composition/common/properties/text_style.dart';
import 'package:madeit/composition/common/widgets/navigation_bar.dart';

class RoomExplorationPage extends StatefulWidget {
  const RoomExplorationPage({Key? key}) : super(key: key);

  @override
  State<RoomExplorationPage> createState() => _RoomExplorationPageState();
}

class _RoomExplorationPageState extends State<RoomExplorationPage>
    with AntennaManager {
  @override
  void initState() {
    sync(listOfRoomStore);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = listOfRoomStore.state;

    if (state == null) {
      return const SizedBox();
    }

    return Scaffold(
      body: ListView(
        children: [
          for (int i = 0; i < state.items.length * 2; i++)
            if (i % 2 == 1)
              const Divider(height: 0.0)
            else
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed("/room/preview", arguments: {
                    "id": state.items[i ~/ 2].id,
                  });
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
                              Text(
                                state.items[i ~/ 2].title,
                                style: const TitleTextStyle(),
                              ),
                              const SizedBox(height: 2.0),
                              Text(
                                state.items[i ~/ 2].description,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const BodyTextStyle(),
                              ),
                              const SizedBox(height: 4.0),
                              Row(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: const CaptionTextStyle(),
                                      children: [
                                        TextSpan(
                                          text: state.items[i ~/ 2].owner.name,
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
                                              "${state.items[i ~/ 2].participantCount}",
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              "/${state.items[i ~/ 2].maxParticipant}명",
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
                            Text(
                              "평균 ${state.items[i ~/ 2].performance.label}",
                              style: const TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2.0),
                            if (state.items[i ~/ 2].performance.value == -1)
                              Text(
                                "기록 없음",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              )
                            else
                              Text(
                                "${state.items[i ~/ 2].performance.value}${state.items[i ~/ 2].performance.symbol}",
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
      ),
      bottomNavigationBar: const AppNavigationBar(currentIndex: 0),
      appBar: AppBar(
        title: const Text(Strings.exploration),
      ),
    );
  }
}
