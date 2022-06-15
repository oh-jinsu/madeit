import 'package:flutter/material.dart';
import 'package:madeit/composition/common/properties/text_style.dart';
import 'package:madeit/composition/common/widgets/room_photolog.dart';

class RoomPreviewPage extends StatelessWidget {
  static const paddingLeft = 16.0;
  static const paddingRight = 16.0;

  static const bottomContainerHeight = 44.0;

  const RoomPreviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: 72.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: paddingLeft,
                  right: paddingRight,
                ),
                child: RichText(
                  text: TextSpan(
                    style: const HeadlineTextStyle(),
                    children: [
                      const TextSpan(
                        text: "평균 성공률 ",
                      ),
                      TextSpan(
                        text: "95%\n",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      TextSpan(
                        text: 16.toString(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const TextSpan(
                        text: "명이 함께 하고 있는\n",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      const TextSpan(
                        text: "하루에 만 보 걷기 🚶‍♂️",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              Padding(
                padding: const EdgeInsets.only(
                  left: paddingLeft,
                  right: paddingRight,
                ),
                child: RichText(
                  text: TextSpan(
                    style: const CaptionTextStyle(),
                    children: [
                      TextSpan(
                        text: "조대훈",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const TextSpan(
                        text: " • 2021.03.04 개설",
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Padding(
                padding: EdgeInsets.only(
                  left: paddingLeft,
                  right: paddingRight,
                ),
                child: Text(
                  "만 걸음 걸을 때마다 하루씩 젊어져요!\n\n하버드대학 스포츠과학센터의 실험결과에 따르면 자전거타기 5.7%, 달리기 6.0%의 체지방 감소율에 비해서 걷기는 13.4%로 다른 운동과 2배 이상의 체지방 감소율을 나타냈습니다. 100만 보를 걸으면 5만 Kcal가 소모됩니다. 이는 마라톤 풀코스를 17번 뛰는 것과 같은 효과가 있습니다.\n\n만보기 사진을 매일 오후 9시부터 9시 10분까지 인증하시면 됩니다. 초보자도 환영해요!",
                  style: BodyTextStyle(),
                ),
              ),
              const SizedBox(height: 16.0),
              const Padding(
                padding: EdgeInsets.only(left: paddingLeft),
                child: Text(
                  "인증 로그 ✅",
                  style: HeaderTextStyle(),
                ),
              ),
              const SizedBox(height: 12.0),
              const Divider(),
              for (int i = 0; i < 5; i++) const RoomPhotolog(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(
          left: paddingLeft,
          right: paddingRight,
          bottom: 8.0,
          top: 8.0,
        ),
        child: SafeArea(
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey[200]!),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  fixedSize: const Size(
                    bottomContainerHeight,
                    bottomContainerHeight,
                  ),
                  minimumSize: const Size(
                    bottomContainerHeight,
                    bottomContainerHeight,
                  ),
                ),
                child: Icon(
                  Icons.chevron_left,
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed("/room");
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(bottomContainerHeight),
                  ),
                  child: const Text("참여하기"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
