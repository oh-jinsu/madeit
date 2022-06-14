import 'package:flutter/material.dart';
import 'package:madeit/composition/common/properties/text_style.dart';

class MyChatBubble extends StatelessWidget {
  final String username;
  final String message;
  final DateTime dateTime;
  final double maxwidth;

  const MyChatBubble({
    Key? key,
    required this.username,
    required this.message,
    required this.dateTime,
    required this.maxwidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(height: 2.0),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              text: const TextSpan(
                style: CaptionTextStyle(),
                children: [
                  TextSpan(
                    text: "오후 02:30",
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
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0),
              bottomLeft: Radius.circular(16.0),
            ),
          ),
          constraints: BoxConstraints(
            maxWidth: maxwidth,
          ),
          child: Text(
            message,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 4.0),
      ],
    );
  }
}
