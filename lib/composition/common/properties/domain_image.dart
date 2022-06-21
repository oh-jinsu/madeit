import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum ImageResolution {
  mdpi,
  xhdpi,
  xxhdpi,
  original,
}

class DomainImage {
  static String? _cdnHost;

  static NetworkImage fromNetwork(
    String id, {
    ImageResolution resolution = ImageResolution.xxhdpi,
  }) {
    _cdnHost ??= dotenv.get("CDN_HOST");

    final res = () {
      switch (resolution) {
        case ImageResolution.mdpi:
          return "/mdpi";
        case ImageResolution.xhdpi:
          return "/xhdpi";
        case ImageResolution.xxhdpi:
          return "/xxhdpi";
        case ImageResolution.original:
          return "";
      }
    }();

    return NetworkImage("$_cdnHost/$id$res");
  }
}
