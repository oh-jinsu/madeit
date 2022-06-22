import 'package:antenna/antenna.dart';
import 'package:flutter/material.dart';
import 'package:madeit/application/events/more_chats_requested.dart';
import 'package:madeit/application/models/chat/message.dart';
import 'package:madeit/application/models/chat/notice.dart';
import 'package:madeit/application/models/chat/user.dart';
import 'package:madeit/application/stores/chat.dart';
import 'package:madeit/application/stores/user.dart';
import 'package:madeit/composition/common/properties/text_style.dart';
import 'package:madeit/composition/room/widget/chat_bubble.dart';

class ListOfChat extends StatefulWidget {
  final double paddingHorizontal;
  final double maxWidth;

  final String roomId;

  const ListOfChat({
    Key? key,
    required this.roomId,
    required this.paddingHorizontal,
    required this.maxWidth,
  }) : super(key: key);

  @override
  State<ListOfChat> createState() => _ListOfChatState();
}

class _ListOfChatState extends State<ListOfChat> with AntennaManager {
  @override
  void initState() {
    sync(chatStore);

    final state = chatStore.state[widget.roomId]!;

    if (state.items.isEmpty) {
      dispatch(
        MoreChatsRequested(roomId: widget.roomId, cursor: state.next.value),
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = userStore.state!;

    final list = chatStore.state[widget.roomId]!;

    final items = list.items;

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (list.next.value == null) {
            return true;
          }

          dispatch(
            MoreChatsRequested(roomId: widget.roomId, cursor: list.next.value),
          );
        }

        return true;
      },
      child: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: widget.paddingHorizontal,
          vertical: 16.0,
        ),
        reverse: true,
        children: [
          for (int i = 0; i < items.length; i++) ...[
            () {
              final item = items[i];

              final isContinuos = () {
                if (i == items.length - 1) {
                  return false;
                }

                if (item is! UserChatModel) {
                  return false;
                }

                final upper = items[i + 1];

                if (upper is! UserChatModel) {
                  return false;
                }

                if (item.user.id != upper.user.id) {
                  return false;
                }

                if (item.createdAt.year != upper.createdAt.year) {
                  return false;
                }

                if (item.createdAt.month != upper.createdAt.month) {
                  return false;
                }

                if (item.createdAt.day != upper.createdAt.day) {
                  return false;
                }

                if (item.createdAt.hour != upper.createdAt.hour) {
                  return false;
                }

                if (item.createdAt.minute != upper.createdAt.minute) {
                  return false;
                }

                return true;
              }();

              if (item is NoticeChatModel) {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: Center(
                    child: Text(
                      item.message,
                      style: const CaptionTextStyle(),
                    ),
                  ),
                );
              }

              if (item is MessageChatModel) {
                return Padding(
                  padding: EdgeInsets.only(top: isContinuos ? 0.0 : 20.0),
                  child: ChatBubble(
                    isMine: item.user.id == user.id,
                    username: item.user.name,
                    message: item.message,
                    dateTime: item.createdAt,
                    maxwidth: widget.maxWidth,
                    isContinous: isContinuos,
                  ),
                );
              }

              throw Error();
            }(),
          ],
          Center(
            child: SizedBox(
              width: 24.0,
              height: 24.0,
              child: list.isPending ? const CircularProgressIndicator() : null,
            ),
          ),
        ],
      ),
    );
  }
}
