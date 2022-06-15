import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  final Widget label;
  final bool showIcon;

  const ProfileMenu({
    Key? key,
    required this.label,
    this.showIcon = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13.0),
      child: Row(
        children: [
          Expanded(
            child: label,
          ),
          if (showIcon)
            Icon(
              Icons.chevron_right,
              size: 20.0,
              color: Colors.grey[400],
            ),
        ],
      ),
    );
  }
}
