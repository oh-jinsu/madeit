import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final double radius;

  const Avatar({
    Key? key,
    required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey[100],
      child: Icon(
        Icons.person,
        color: Colors.grey[400],
        size: radius,
      ),
    );
  }
}
