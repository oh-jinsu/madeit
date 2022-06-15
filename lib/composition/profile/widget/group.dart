import 'package:flutter/material.dart';

class ProfileGroup extends StatelessWidget {
  final List<Widget> children;

  const ProfileGroup({
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey[200]!,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: [
          for (int i = 0; i < children.length * 2 - 1; i++)
            if (i % 2 == 1) const Divider() else children[i ~/ 2]
        ],
      ),
    );
  }
}
