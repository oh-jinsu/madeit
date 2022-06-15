import 'package:flutter/material.dart';
import 'package:madeit/composition/common/properties/text_style.dart';
import 'package:madeit/composition/common/widgets/avatar.dart';

class CountinuosChatBubble extends StatelessWidget {
  final bool isMine;
  final String username;
  final String message;
  final DateTime dateTime;
  final double maxwidth;

  const CountinuosChatBubble({
    Key? key,
    required this.isMine,
    required this.username,
    required this.message,
    required this.dateTime,
    required this.maxwidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isMine) ...[
          const SizedBox(width: 48.0),
        ],
        Column(
          crossAxisAlignment:
              isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
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
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
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
