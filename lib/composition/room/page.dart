import 'package:flutter/material.dart';
import 'package:madeit/composition/common/properties/text_style.dart';
import 'package:madeit/composition/room/widget/chat_bubble.dart';
import 'package:madeit/composition/room/widget/continuos_chat_bubble.dart';

class RoomPage extends StatefulWidget {
  static const paddingHorizontal = 16.0;
  static const avatarRadius = 20.0;
  static const gapFromAvatar = 8.0;

  const RoomPage({Key? key}) : super(key: key);

  static double getMaxChatBubbleWidth(BuildContext context) {
    return MediaQuery.of(context).size.width -
        paddingHorizontal * 2 -
        avatarRadius * 2 * 2 -
        gapFromAvatar * 2;
  }

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  final focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "하루에 만 보 걷기 🚶‍♂️",
                style: TextStyle(
                  fontSize: 16.0,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              RichText(
                text: TextSpan(
                  style: const CaptionTextStyle(),
                  children: [
                    const TextSpan(
                      text: "평균 성공률 ",
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
            ],
          ),
          titleSpacing: 0.0,
          centerTitle: false,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey[200]!,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey[50],
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: RoomPage.paddingHorizontal,
                    vertical: 16.0,
                  ),
                  reverse: true,
                  children: [
                    CountinuosChatBubble(
                      isMine: true,
                      username: "오진수",
                      message: "안녕하세요 여러분 좋은 아침이에요 열심히 참여해 주세요~",
                      dateTime: DateTime.now(),
                      maxwidth: RoomPage.getMaxChatBubbleWidth(context),
                    ),
                    ChatBubble(
                      isMine: true,
                      username: "오진수",
                      message: "안녕하세요 신참입니다",
                      dateTime: DateTime.now(),
                      maxwidth: RoomPage.getMaxChatBubbleWidth(context),
                    ),
                    const SizedBox(height: 20.0),
                    for (int i = 0; i < 10 * 2 - 1; i++) ...[
                      CountinuosChatBubble(
                        isMine: false,
                        username: "조대훈",
                        message: "안녕하세요 여러분 좋은 아침이에요 열심히 참여해 주세요~",
                        dateTime: DateTime.now(),
                        maxwidth: RoomPage.getMaxChatBubbleWidth(context),
                      ),
                      ChatBubble(
                        isMine: false,
                        username: "조대훈",
                        message: "안녕하세요 여러분 좋은 아침이에요 열심히 참여해 주세요~",
                        dateTime: DateTime.now(),
                        maxwidth: RoomPage.getMaxChatBubbleWidth(context),
                      ),
                      const SizedBox(height: 20.0)
                    ],
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "2021년 3월 21일",
                          style: CaptionTextStyle(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Container(
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
                child: Row(
                  children: [
                    const SizedBox(width: 8.0),
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.add,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: Colors.grey[200]!,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, top: 8.0, bottom: 8.0),
                                child: TextField(
                                  focusNode: focusNode,
                                  keyboardType: TextInputType.multiline,
                                  minLines: 1,
                                  maxLines: 4,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                  ),
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(0.0),
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (v) {},
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                visualDensity: VisualDensity.compact,
                                fixedSize: const Size(32.0, 32.0),
                                minimumSize: const Size(32.0, 32.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                              ),
                              child: const Icon(
                                Icons.arrow_upward,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12.0),
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
