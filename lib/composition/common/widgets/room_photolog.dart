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
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
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
            Positioned(
              left: paddingLeft + avatarRadius - edgeSize * 0.5,
              bottom: edgeSize * -0.5,
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
        ),
        InkWell(
          onTap: () {},
          child: Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
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
                          const SizedBox(height: 8.0),
                          const Text(
                            "야호! 오늘도 만 걸음 걸었다! 너무 뿌듯해! 수고했어 사랑 고생했지 나의 사랑.. 이 부분이 뭔가 과거의 나에게, 지금의 나에게 건네주는 것",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: BodyTextStyle(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: const Image(
                        width: 80.0,
                        height: 80.0,
                        fit: BoxFit.cover,
                        image: NetworkImage("https://picsum.photos/500/500"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
              ],
            ),
          ),
        ),
        const Divider()
      ],
    );
  }
}
