import 'dart:math';

import 'package:flutter/material.dart';
import 'package:madeit/composition/common/properties/text_style.dart';
import 'package:madeit/composition/common/widgets/avatar.dart';

class RoomPhotolog extends StatelessWidget {
  static const paddingLeft = 16.0;
  static const avatarRadius = 16.0;
  static const headerVerticalPadding = 8.0;
  static const edgeSize = 8.0;

  const RoomPhotolog({Key? key}) : super(key: key);

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
            InkWell(
              onTap: () {},
              child: Ink(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        top: 8.0,
                      ),
                      child: RichText(
                        text: const TextSpan(
                          style: CaptionTextStyle(),
                          children: [
                            TextSpan(
                              text: "1일 전",
                            ),
                            TextSpan(
                              text: " · 인증됨 ✅",
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 16.0,
                        top: 4.0,
                        right: 16.0,
                      ),
                      child: Text(
                        "야호! 오늘도 만 걸음 걸었다!",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: BodyTextStyle(),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    SizedBox(
                      height: 80.0,
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        scrollDirection: Axis.horizontal,
                        children: [
                          for (int i = 0; i < 1; i++)
                            if (i % 2 == 1)
                              const SizedBox(width: 4.0)
                            else
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4.0),
                                child: const Image(
                                  width: 80.0,
                                  height: 80.0,
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    "https://picsum.photos/300/300",
                                  ),
                                ),
                              ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
            ),
            const Divider()
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
