import 'package:flutter/material.dart';
import 'package:madeit/application/stores/list_of_room.dart';
import 'package:madeit/application/stores/my_rooms.dart';
import 'package:madeit/composition/common/properties/text_style.dart';
import 'package:madeit/composition/common/widgets/photolog.dart';

class RoomPreviewPage extends StatelessWidget {
  final String id;

  static const paddingLeft = 16.0;
  static const paddingRight = 16.0;

  static const bottomContainerHeight = 44.0;

  const RoomPreviewPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final room =
        listOfRoomStore.state!.items.firstWhere((item) => item.id == id);

    final isFull = room.participantCount == room.maxParticipant;

    final isEntered = () {
      final myRooms = myRoomsStore.state;
      if (myRooms == null) {
        return true;
      }

      return myRooms.every((element) => element.id != id);
    }();

    return Scaffold(
      body: Ink(
        color: Colors.white,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32.0),
                Padding(
                  padding: const EdgeInsets.only(
                    left: paddingLeft,
                    right: paddingRight,
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: const HeadlineTextStyle(),
                      children: [
                        if (room.performance.value != -1) ...[
                          TextSpan(
                            text: "평균 ${room.performance.label}",
                          ),
                          TextSpan(
                            text:
                                "${room.performance.value}${room.performance.symbol}%\n",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                        if (room.participantCount > 1) ...[
                          TextSpan(
                            text: room.participantCount.toString(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const TextSpan(
                            text: "명이 함께하고 있는\n",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                        TextSpan(
                          text: room.title,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                Padding(
                  padding: const EdgeInsets.only(
                    left: paddingLeft,
                    right: paddingRight,
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: const CaptionTextStyle(),
                      children: [
                        TextSpan(
                          text: room.owner.name,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        TextSpan(
                          text: () {
                            final dateTime = room.createdAt;

                            final year = dateTime.year;

                            final month =
                                dateTime.month.toString().padLeft(2, "0");

                            final day = dateTime.day.toString().padLeft(2, "0");

                            return " • $year.$month.$day 개설";
                          }(),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.only(
                    left: paddingLeft,
                    right: paddingRight,
                  ),
                  child: Text(
                    room.description,
                    style: const BodyTextStyle(),
                  ),
                ),
                const SizedBox(height: 16.0),
                const Padding(
                  padding: EdgeInsets.only(left: paddingLeft),
                  child: Text(
                    "최신 인증 로그 ✅",
                    style: HeaderTextStyle(),
                  ),
                ),
                const SizedBox(height: 12.0),
                const Divider(),
                for (int i = 0; i < 5 * 2 + 1; i++)
                  if (i % 2 == 0)
                    const Divider()
                  else
                    const Photolog(
                      username: "익명",
                    ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Ink(
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.only(
            left: paddingLeft,
            right: paddingRight,
            bottom: 4.0,
            top: 4.0,
          ),
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey[200]!))),
          child: SafeArea(
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey[200]!),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    fixedSize: const Size(
                      bottomContainerHeight,
                      bottomContainerHeight,
                    ),
                    minimumSize: const Size(
                      bottomContainerHeight,
                      bottomContainerHeight,
                    ),
                  ),
                  child: Icon(
                    Icons.chevron_left,
                    color: Colors.grey[400],
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (!isEntered || isFull) {
                        return;
                      }

                      Navigator.of(context).pushReplacementNamed("/room");
                    },
                    style: ElevatedButton.styleFrom(
                      primary: isEntered ? null : Colors.grey[400],
                      minimumSize: const Size.fromHeight(bottomContainerHeight),
                    ),
                    child: Text(() {
                      if (isFull) {
                        return "정원이 가득 찼어요";
                      }

                      if (!isEntered) {
                        return "이미 가입한 방이에요";
                      }

                      return "참여하기";
                    }()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
