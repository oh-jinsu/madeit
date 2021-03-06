import 'package:flutter/material.dart';
import 'package:madeit/composition/common/properties/text_style.dart';
import 'package:madeit/composition/common/widgets/avatar.dart';

class ChatBubble extends StatelessWidget {
  final void Function()? onAvatarTap;
  final bool isMine;
  final String username;
  final String message;
  final DateTime dateTime;
  final double maxwidth;
  final bool isContinous;

  const ChatBubble({
    Key? key,
    this.onAvatarTap,
    required this.isMine,
    required this.username,
    required this.message,
    required this.dateTime,
    required this.maxwidth,
    this.isContinous = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isContinous)
          const SizedBox(
            width: 48.0,
          )
        else if (!isMine) ...[
          GestureDetector(
            onTap: onAvatarTap,
            child: const Avatar(radius: 20.0),
          ),
          const SizedBox(width: 8.0),
        ],
        Column(
          crossAxisAlignment:
              isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (!isContinous) ...[
              const SizedBox(height: 2.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isMine) ...[
                    Text(
                      username,
                      style: const TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    RichText(
                      text: const TextSpan(
                        style: CaptionTextStyle(),
                        children: [
                          TextSpan(
                            text: " • ",
                          ),
                        ],
                      ),
                    ),
                  ],
                  RichText(
                    text: TextSpan(
                      style: const CaptionTextStyle(),
                      children: [
                        TextSpan(
                          text: () {
                            final hour = dateTime.hour;

                            final minute =
                                dateTime.minute.toString().padLeft(2, "0");

                            if (hour > 12) {
                              return "오후 ${hour - 12}:$minute";
                            }

                            return "오전 $hour:$minute";
                          }(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 4.0),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                color: isMine
                    ? Theme.of(context).colorScheme.primary
                    : Colors.white,
                border: isMine ? null : Border.all(color: Colors.grey[200]!),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(isContinous || isMine ? 16.0 : 0.0),
                  topRight:
                      Radius.circular(isContinous || !isMine ? 16.0 : 0.0),
                  bottomRight: const Radius.circular(16.0),
                  bottomLeft: const Radius.circular(16.0),
                ),
              ),
              constraints: BoxConstraints(
                maxWidth: maxwidth,
              ),
              child: Text(
                message,
                style: BodyTextStyle(
                  color: isMine ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
