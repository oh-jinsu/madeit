import 'package:flutter/material.dart';
import 'package:madeit/composition/common/properties/text_style.dart';
import 'package:madeit/composition/common/widgets/avatar.dart';

class ChatBubble extends StatelessWidget {
  final String username;
  final String message;
  final DateTime dateTime;
  final double maxwidth;

  const ChatBubble({
    Key? key,
    required this.username,
    required this.message,
    required this.dateTime,
    required this.maxwidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Avatar(radius: 20.0),
        const SizedBox(width: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 2.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
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
                        text: " • 오후 02:30",
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4.0),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                  bottomLeft: Radius.circular(16.0),
                ),
              ),
              constraints: BoxConstraints(
                maxWidth: maxwidth,
              ),
              child: Text(
                message,
                style: const BodyTextStyle(),
              ),
            ),
            const SizedBox(height: 4.0),
          ],
        ),
      ],
    );
  }
}
