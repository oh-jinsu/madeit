import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<T?> showPlatformDialog<T>(
  BuildContext context, {
  required Widget content,
  List<Widget> actions = const [],
}) {
  if (Platform.isIOS) {
    return showCupertinoDialog<T>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("안내"),
          content: content,
          actions: actions,
        );
      },
    );
  }

  return showDialog<T>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("안내"),
        content: content,
        actions: actions,
      );
    },
  );
}
