import 'package:flutter/material.dart';
import 'package:madeit/composition/common/properties/text_style.dart';

class ProfileRecordItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String content;

  const ProfileRecordItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 6.0),
        Text(
          label,
          style: const CaptionTextStyle(),
        ),
        const SizedBox(height: 4.0),
        Text(
          content,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        )
      ],
    );
  }
}
