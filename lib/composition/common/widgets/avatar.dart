import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final double radius;
  final ImageProvider? image;

  const Avatar({
    Key? key,
    required this.radius,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (image != null) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: image,
        backgroundColor: Colors.white,
      );
    }

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
