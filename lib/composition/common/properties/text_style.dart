import 'package:flutter/material.dart';

class CaptionTextStyle extends TextStyle {
  const CaptionTextStyle({
    Color color = const Color(0xff757575),
  }) : super(
          color: color,
          fontSize: 12.0,
        );
}

class BodyTextStyle extends TextStyle {
  const BodyTextStyle({
    Color color = Colors.black,
  }) : super(
          color: color,
          fontSize: 14.0,
        );
}

class TitleTextStyle extends TextStyle {
  const TitleTextStyle()
      : super(
          color: Colors.black,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        );
}

class HeaderTextStyle extends TextStyle {
  const HeaderTextStyle({
    Color color = Colors.black,
  }) : super(
          color: color,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        );
}

class HeadlineTextStyle extends TextStyle {
  const HeadlineTextStyle()
      : super(
          color: Colors.black,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        );
}
