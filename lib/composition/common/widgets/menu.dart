import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformMenuEntry {
  final IconData? icon;
  final String label;
  final void Function()? onTap;

  const PlatformMenuEntry({
    required this.label,
    this.icon,
    this.onTap,
  });
}

showPlatformMenu(
  BuildContext context, {
  Offset offset = Offset.zero,
  List<PlatformMenuEntry> entries = const [],
}) {
  if (Platform.isIOS) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          actions: [
            for (final entry in entries)
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.of(context).pop();

                  entry.onTap?.call();
                },
                child: Text(entry.label),
              )
          ],
          cancelButton: CupertinoButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "취소",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
        );
      },
    );
  } else {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy,
        MediaQuery.of(context).size.width - offset.dx,
        MediaQuery.of(context).size.height - offset.dy,
      ),
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey[200]!,
        ),
      ),
      items: [
        for (final entry in entries)
          PopupMenuItem(
            onTap: () async {
              Future.delayed(Duration.zero, () async {
                entry.onTap?.call();
              });
            },
            child: Row(
              children: [
                Icon(entry.icon, size: 20.0),
                const Spacer(),
                Text(
                  entry.label,
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
