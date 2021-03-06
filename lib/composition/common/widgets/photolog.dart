import 'dart:math';

import 'package:flutter/material.dart';
import 'package:madeit/composition/common/properties/text_style.dart';
import 'package:madeit/composition/common/widgets/avatar.dart';

class Photolog extends StatefulWidget {
  static const paddingLeft = 16.0;
  static const avatarRadius = 16.0;
  static const headerVerticalPadding = 8.0;
  static const edgeSize = 8.0;

  final photoLength = 3;

  final String username;
  final bool showSuccesRate;
  final bool showJoinedAt;
  final bool showMoreButton;
  final void Function()? onTap;

  const Photolog({
    Key? key,
    required this.username,
    this.showSuccesRate = true,
    this.showJoinedAt = true,
    this.showMoreButton = false,
    this.onTap,
  }) : super(key: key);

  @override
  State<Photolog> createState() => _PhotologState();
}

class _PhotologState extends State<Photolog> {
  int curentPage = 0;

  late final pageController = PageController(initialPage: curentPage);

  @override
  void dispose() {
    pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          children: [
            GestureDetector(
              onTap: widget.onTap,
              child: Ink(
                color: Colors.white,
                child: Container(
                  width: double.infinity,
                  height: Photolog.avatarRadius * 2 +
                      Photolog.headerVerticalPadding * 2,
                  padding: const EdgeInsets.only(
                    left: Photolog.paddingLeft,
                    right: 12.0,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[200]!),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Avatar(radius: Photolog.avatarRadius),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: const CaptionTextStyle(),
                            children: [
                              TextSpan(
                                text: widget.username,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (widget.showSuccesRate) ...[
                                const TextSpan(text: " ?? ????????? "),
                                TextSpan(
                                  text: "87%",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                              if (widget.showJoinedAt)
                                const TextSpan(text: " ?? 2022.03.12 ??????"),
                            ],
                          ),
                        ),
                      ),
                      if (widget.onTap != null)
                        Icon(
                          Icons.chevron_right,
                          size: 20.0,
                          color: Colors.grey[400],
                        )
                      else if (widget.showMoreButton)
                        Icon(
                          Icons.more_vert,
                          size: 20.0,
                          color: Colors.grey[400],
                        )
                    ],
                  ),
                ),
              ),
            ),
            Ink(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 1.0,
                    child: Stack(
                      children: [
                        PageView(
                          controller: pageController,
                          physics: const ClampingScrollPhysics(),
                          onPageChanged: (page) {
                            setState(() {
                              curentPage = page;
                            });
                          },
                          children: [
                            for (int i = 0; i < widget.photoLength; i++)
                              Image(
                                image: NetworkImage(
                                  "https://picsum.photos/1000/${1000 + i}",
                                ),
                              ),
                          ],
                        ),
                        Positioned(
                          bottom: 8.0,
                          left: 0.0,
                          right: 0.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int i = 0;
                                  i < widget.photoLength * 2 - 1;
                                  i++)
                                if (i % 2 == 1)
                                  const SizedBox(width: 4.0)
                                else
                                  Container(
                                    width: 6.0,
                                    height: 6.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3.0),
                                      color: i ~/ 2 == curentPage
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Colors.grey[200],
                                    ),
                                  ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: widget.onTap,
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
                                        text: "1??? ???",
                                      ),
                                      TextSpan(
                                        text: " ?? ????????? 11???",
                                      ),
                                      TextSpan(
                                        text: " ?? ????????? ???",
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                const Text(
                                  "??????! ????????? ??? ?????? ?????????! ??????! ????????? ??? ?????? ?????????! ??????! ????????? ??? ?????? ?????????! ??????! ????????? ??? ?????? ?????????! ??????! ????????? ??? ?????? ?????????!",
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
          left: Photolog.paddingLeft +
              Photolog.avatarRadius -
              Photolog.edgeSize * 0.5,
          top: Photolog.avatarRadius * 2 +
              Photolog.headerVerticalPadding * 2 +
              Photolog.edgeSize * -0.5,
          child: Transform.rotate(
            angle: pi / 4,
            child: Container(
              width: Photolog.edgeSize,
              height: Photolog.edgeSize,
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
