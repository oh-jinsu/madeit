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
      backgroundColor: Colors.grey[200],
      child: CircleAvatar(
        radius: radius - 1.0,
        backgroundColor: Colors.white,
        child: Icon(
          Icons.person,
          color: Colors.grey[300],
          size: radius,
        ),
      ),
    );
  }
}
