import 'package:flutter/material.dart';

class SignUpRow extends StatelessWidget {
  final void Function()? onTap;
  final Widget? preffix;
  final Widget body;
  final Widget? suffix;

  const SignUpRow({
    Key? key,
    this.onTap,
    this.preffix,
    required this.body,
    this.suffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        color: Colors.white,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
          ),
          child: Row(
            children: [
              const SizedBox(width: 16.0),
              if (preffix != null) preffix!,
              const SizedBox(width: 8.0),
              Expanded(child: body),
              const SizedBox(width: 8.0),
              if (suffix != null) suffix!,
              const SizedBox(width: 12.0),
            ],
          ),
        ),
      ),
    );
  }
}
