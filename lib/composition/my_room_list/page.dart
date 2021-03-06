import 'package:antenna/antenna.dart';
import 'package:flutter/material.dart';
import 'package:madeit/application/events/exit_room_requested.dart';
import 'package:madeit/application/models/chat/image.dart';
import 'package:madeit/application/models/chat/message.dart';
import 'package:madeit/application/models/chat/notice.dart';
import 'package:madeit/application/models/chat/photolog.dart';
import 'package:madeit/application/stores/my_rooms.dart';
import 'package:madeit/composition/common/constants/strings.dart';
import 'package:madeit/composition/common/properties/text_style.dart';
import 'package:madeit/composition/common/widgets/dialog.dart';
import 'package:madeit/composition/common/widgets/menu.dart';
import 'package:madeit/composition/common/widgets/navigation_bar.dart';

class MyRoomListPage extends StatefulWidget {
  const MyRoomListPage({Key? key}) : super(key: key);

  @override
  State<MyRoomListPage> createState() => _MyRoomListPageState();
}

class _MyRoomListPageState extends State<MyRoomListPage> with AntennaManager {
  TapDownDetails tapDownDetails = TapDownDetails();

  @override
  void initState() {
    sync(myRoomsStore);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = myRoomsStore.state;

    if (state == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(Strings.myRoutine),
        ),
        body: const Center(),
        bottomNavigationBar: const AppNavigationBar(currentIndex: 1),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.myRoutine),
      ),
      body: ListView(
        children: [
          for (int i = 0; i < state.length * 2; i++)
            if (i % 2 == 1)
              const Divider(height: 0.0)
            else
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed("/room", arguments: {
                    "id": state[i ~/ 2].id,
                  });
                },
                onLongPress: () => showPlatformMenu(
                  context,
                  offset: tapDownDetails.globalPosition,
                  entries: [
                    PlatformMenuEntry(
                      onTap: () async {
                        final result = await showPlatformDialog(
                          context,
                          content: Text(
                            "?????? ${state[i ~/ 2].title}?????? ????????? ??????????",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                return Navigator.of(context).pop(false);
                              },
                              child: const Text("?????????"),
                            ),
                            TextButton(
                              onPressed: () {
                                return Navigator.of(context).pop(true);
                              },
                              child: const Text("???"),
                            )
                          ],
                        );

                        if (result == true) {
                          dispatch(ExitRoomRequested(state[i ~/ 2].id));
                        }
                      },
                      label: "????????????",
                      icon: Icons.exit_to_app,
                    )
                  ],
                ),
                onTapDown: (details) {
                  tapDownDetails = details;
                },
                child: Ink(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 16.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                state[i ~/ 2].title,
                                style: const TitleTextStyle(),
                              ),
                            ),
                            Text(
                              () {
                                final lastChat = state[i ~/ 2].lastChat.value;

                                if (lastChat == null) {
                                  return "";
                                }

                                final dateTime = lastChat.createdAt;

                                final hour = dateTime.hour;

                                final minute =
                                    dateTime.minute.toString().padLeft(2, "0");

                                if (hour > 12) {
                                  return "?????? ${hour - 12}:$minute";
                                }

                                return "?????? $hour:$minute";
                              }(),
                              style: const CaptionTextStyle(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2.0),
                        RichText(
                          text: TextSpan(
                            style: const CaptionTextStyle(),
                            children: [
                              TextSpan(
                                text: "${state[i ~/ 2].participantCount}???",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: " ?????? ${state[i ~/ 2].performance.label} ",
                              ),
                              TextSpan(
                                text: state[i ~/ 2].performance.value == -1
                                    ? "?????? ??????"
                                    : "${state[i ~/ 2].performance.value}${state[i ~/ 2].performance.symbol}",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text:
                                    " ?????? ${state[i ~/ 2].myPerformance.label} ",
                              ),
                              TextSpan(
                                text: state[i ~/ 2].myPerformance.value == -1
                                    ? "?????? ??????"
                                    : "${state[i ~/ 2].myPerformance.value}${state[i ~/ 2].myPerformance.symbol}",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (state[i ~/ 2].lastChat.value != null) ...[
                          const SizedBox(height: 8.0),
                          Text(
                            () {
                              final chat = state[i ~/ 2].lastChat.value!;

                              if (chat is NoticeChatModel) {
                                return chat.message;
                              }

                              if (chat is MessageChatModel) {
                                return chat.message;
                              }

                              if (chat is ImageChatModel) {
                                return "????????? ???????????????.";
                              }

                              if (chat is PhotologChatModel) {
                                return chat.message;
                              }

                              throw Error();
                            }(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: BodyTextStyle(
                              color: Colors.grey[600]!,
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
              )
        ],
      ),
      bottomNavigationBar: const AppNavigationBar(currentIndex: 1),
    );
  }
}
