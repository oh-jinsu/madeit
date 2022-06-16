import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  final void Function()? onTap;
  final Widget label;
  final Widget? icon;
  final bool showIcon;

  const ProfileMenu({
    Key? key,
    this.onTap,
    required this.label,
    this.showIcon = true,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 13.0,
        horizontal: 16.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: label,
          ),
          if (showIcon)
            icon ??
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
