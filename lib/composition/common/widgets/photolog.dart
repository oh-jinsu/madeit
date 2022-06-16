import 'dart:math';

import 'package:flutter/material.dart';
import 'package:madeit/composition/common/properties/text_style.dart';
import 'package:madeit/composition/common/widgets/avatar.dart';

class Photolog extends StatelessWidget {
  static const paddingLeft = 16.0;
  static const avatarRadius = 16.0;
  static const headerVerticalPadding = 8.0;
  static const edgeSize = 8.0;

  const Photolog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          children: [
            Ink(
              color: Colors.white,
              child: Container(
                width: double.infinity,
                height: avatarRadius * 2 + headerVerticalPadding * 2,
                padding: const EdgeInsets.only(
                  left: paddingLeft,
                  right: 8.0,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[200]!),
                  ),
                ),
                child: Row(
                  children: [
                    const Avatar(radius: avatarRadius),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: const CaptionTextStyle(),
                          children: [
                            const TextSpan(
                              text: "나",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(text: " · 성공률 "),
                            TextSpan(
                              text: "87%",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(text: " · 2022.03.12 가입"),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(16.0),
                      child: SizedBox(
                        width: 32.0,
                        height: 32.0,
                        child: Icon(
                          Icons.chevron_right,
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Ink(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AspectRatio(
                    aspectRatio: 1.0,
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        "https://picsum.photos/1000/1000",
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        right: 8.0,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10.0),
                                RichText(
                                  text: const TextSpan(
                                    style: CaptionTextStyle(),
                                    children: [
                                      TextSpan(
                                        text: "1일 전",
                                      ),
                                      TextSpan(
                                        text: " · 좋아요 11개",
                                      ),
                                      TextSpan(
                                        text: " · 인증됨 ✅",
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                const Text(
                                  "야호! 오늘도 만 걸음 걸었다! 야호! 오늘도 만 걸음 걸었다! 야호! 오늘도 만 걸음 걸었다! 야호! 오늘도 만 걸음 걸었다! 야호! 오늘도 만 걸음 걸었다!",
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: BodyTextStyle(),
                                ),
                                const SizedBox(height: 6.0),
                                const SizedBox(height: 10.0),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(32.0),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Icon(
                                Icons.favorite_outline,
                                size: 20.0,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          left: paddingLeft + avatarRadius - edgeSize * 0.5,
          top: avatarRadius * 2 + headerVerticalPadding * 2 + edgeSize * -0.5,
          child: Transform.rotate(
            angle: pi / 4,
            child: Container(
              width: edgeSize,
              height: edgeSize,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey[200]!,
                  ),
                  right: BorderSide(
                    color: Colors.grey[200]!,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
