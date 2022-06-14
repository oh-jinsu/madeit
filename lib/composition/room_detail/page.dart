import 'package:flutter/material.dart';
import 'package:madeit/composition/common/widgets/avatar.dart';

class RoomDetailPage extends StatelessWidget {
  static const paddingLeft = 20.0;
  static const paddingRight = 20.0;

  static const bottomContainerHeight = 44.0;

  const RoomDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: paddingLeft,
            right: paddingRight,
            top: 24.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    height: 1.3,
                  ),
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
              const SizedBox(height: 12.0),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey[600],
                  ),
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
              const SizedBox(height: 16.0),
              const Text(
                "만 걸음 걸을 때마다 하루씩 젊어져요!\n\n하버드대학 스포츠과학센터의 실험결과에 따르면 자전거타기 5.7%, 달리기 6.0%의 체지방 감소율에 비해서 걷기는 13.4%로 다른 운동과 2배 이상의 체지방 감소율을 나타냈습니다. 100만 보를 걸으면 5만 Kcal가 소모됩니다. 이는 마라톤 풀코스를 17번 뛰는 것과 같은 효과가 있습니다.\n\n만보기 사진을 매일 오후 9시부터 9시 10분까지 인증하시면 됩니다. 초보자도 환영해요!",
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                "✅ 인증 로그",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListView(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  for (int i = 0; i < 9; i++)
                    if (i % 2 == 1)
                      const SizedBox(height: 32.0)
                    else
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Avatar(radius: 20.0),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey[600],
                                      height: 1.2,
                                    ),
                                    children: [
                                      const TextSpan(
                                        text: "익명 32",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: " · ",
                                      ),
                                      TextSpan(
                                        text: "1일 전",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: " · 성공률 ",
                                        style: TextStyle(),
                                      ),
                                      TextSpan(
                                        text: "87%",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: " · 인증됨 ✅",
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                const Text(
                                  "야호! 오늘도 만 걸음 걸었다! 너무 뿌듯해!",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                                const SizedBox(height: 12.0),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 164.0,
                                    color: Colors.grey[100],
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.visibility_off,
                                          color: Colors.grey[400],
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          "참여자에게만 공개된 사진입니다.",
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.grey[600],
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
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: paddingLeft,
            right: paddingRight,
            bottom: 8.0,
            top: 8.0,
          ),
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
                  padding: const EdgeInsets.all(0.0),
                  elevation: 0.0,
                  fixedSize: const Size(
                    bottomContainerHeight,
                    bottomContainerHeight,
                  ),
                  minimumSize: const Size(
                    bottomContainerHeight,
                    bottomContainerHeight,
                  ),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.all(0.0),
                    elevation: 0.0,
                    minimumSize: const Size.fromHeight(bottomContainerHeight),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text("참여하기"),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
