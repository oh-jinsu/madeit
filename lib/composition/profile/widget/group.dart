import 'package:flutter/material.dart';
import 'package:madeit/composition/profile/widget/menu_inkwell.dart';

class ProfileGroup extends StatelessWidget {
  static const cornerRaidus = 12.0;

  final List<Widget> children;

  const ProfileGroup({
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[200]!,
        ),
        borderRadius: BorderRadius.circular(cornerRaidus),
      ),
      child: Column(
        children: [
          for (int i = 0; i < children.length * 2 - 1; i++)
            if (i % 2 == 1)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(),
              )
            else
              MenuInkWell(
                cornerRaidus: cornerRaidus,
                isFirst: i == 0,
                isLast: i == 2 * (children.length - 1),
                child: children[i ~/ 2],
              ),
        ],
      ),
    );
  }
}
