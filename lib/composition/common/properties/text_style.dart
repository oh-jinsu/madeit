import 'package:flutter/material.dart';

class CaptionTextStyle extends TextStyle {
  const CaptionTextStyle()
      : super(
          color: const Color(0xff757575),
          fontSize: 12.0,
        );
}

class BodyTextStyle extends TextStyle {
  const BodyTextStyle()
      : super(
          color: Colors.black,
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
  const HeaderTextStyle()
      : super(
          color: Colors.black,
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
