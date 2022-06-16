import 'package:flutter/material.dart';

class SignUpRadioBox extends StatelessWidget {
  final void Function()? onTap;
  final bool enabled;

  const SignUpRadioBox({
    Key? key,
    this.onTap,
    required this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24.0),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: buildMark(context),
      ),
    );
  }

  Widget buildMark(BuildContext context) {
    if (enabled) {
      return Icon(
        Icons.check_circle,
        color: Theme.of(context).colorScheme.primary,
        size: 20.0,
      );
    }

    return Icon(
      Icons.circle_outlined,
      color: Colors.grey[400],
      size: 20.0,
    );
  }
}
