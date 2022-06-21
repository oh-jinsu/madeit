import 'package:flutter/material.dart';
import 'package:madeit/application/stores/my_rooms.dart';
import 'package:madeit/composition/common/properties/text_style.dart';
import 'package:madeit/composition/room/components/chat_field.dart';
import 'package:madeit/composition/room/components/list_of_chat.dart';

class RoomPage extends StatefulWidget {
  final String id;

  const RoomPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  static const paddingHorizontal = 12.0;
  static const avatarRadius = 20.0;
  static const gapFromAvatar = 8.0;

  bool isEditing = false;

  final focusNode = FocusNode();

  static double getMaxChatBubbleWidth(BuildContext context) {
    return MediaQuery.of(context).size.width -
        paddingHorizontal * 2 -
        avatarRadius * 2 * 2 -
        gapFromAvatar * 2;
  }

  @override
  void initState() {
    focusNode.addListener(() {
      setState(() {
        isEditing = focusNode.hasFocus;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = myRoomsStore.state!.firstWhere((e) => e.id == widget.id);

    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.title,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              RichText(
                text: TextSpan(
                  style: const CaptionTextStyle(),
                  children: [
                    TextSpan(
                      text: "${state.participantCount}명",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: " 평균 ${state.performance.label} ",
                    ),
                    TextSpan(
                      text: state.performance.value == -1
                          ? "기록 없음"
                          : "${state.performance.value}${state.performance.symbol}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: " 나의 ${state.myPerformance.label} ",
                    ),
                    TextSpan(
                      text: state.myPerformance.value == -1
                          ? "기록 없음"
                          : "${state.myPerformance.value}${state.myPerformance.symbol}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          titleSpacing: 0.0,
          centerTitle: false,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/room/photolog");
              },
              iconSize: 24.0,
              icon: const Icon(Icons.people_alt_outlined),
            )
          ],
        ),
        body: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed("/room/notification");
              },
              child: Ink(
                color: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[200]!,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 8.0,
                      bottom: 8.0,
                      top: 8.0,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.campaign_outlined,
                          size: 20.0,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 8.0),
                        const Expanded(
                          child: Text(
                            "안녕하세요 여러분 좋은 아침이에요 열심히 참여해 주세요~ 안녕하세요 여러분 좋은 아침이에요 열심히 참여해 주세요~ 안녕하세요 여러분 좋은 아침이에요 열심히 참여해 주세요~",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: CaptionTextStyle(),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.grey[400],
                          size: 20.0,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListOfChat(
                roomId: widget.id,
                paddingHorizontal: paddingHorizontal,
                maxWidth: getMaxChatBubbleWidth(context),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: Colors.grey[200]!,
                  ),
                ),
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    const SizedBox(width: 8.0),
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.add_a_photo,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    Expanded(
                      child: ChatField(
                        roomId: widget.id,
                        focusNode: focusNode,
                      ),
                    ),
                    if (!isEditing) ...[
                      const SizedBox(width: 4.0),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xffc8009e),
                          visualDensity: VisualDensity.compact,
                          fixedSize: const Size(64.0, 36.0),
                          minimumSize: const Size(64.0, 36.0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.add_task,
                              size: 18.0,
                            ),
                            SizedBox(width: 2.0),
                            Text(
                              "인증",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            SizedBox(width: 2.0),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(width: 8.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
