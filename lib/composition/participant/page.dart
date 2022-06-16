import 'package:flutter/material.dart';
import 'package:madeit/composition/common/properties/text_style.dart';
import 'package:madeit/composition/common/widgets/avatar.dart';
import 'package:madeit/composition/common/widgets/photolog.dart';
import 'package:madeit/composition/common/widgets/record_group.dart';

class ParticipantPage extends StatelessWidget {
  const ParticipantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("프로필"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            const Center(
              child: Avatar(radius: 40.0),
            ),
            const SizedBox(height: 12.0),
            const Text(
              "오진수",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              "2022.03.12 가입",
              style: CaptionTextStyle(),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 16.0,
                top: 12.0,
                right: 16.0,
                bottom: 16.0,
              ),
              child: RecordGroup(
                label: "하루에 만 보 걷기 🚶‍♂️에서 받은",
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey[200]!),
                  bottom: BorderSide(color: Colors.grey[200]!),
                ),
              ),
              child: RichText(
                text: TextSpan(
                  style: const HeaderTextStyle(),
                  children: [
                    const TextSpan(
                      text: "성공률 ",
                    ),
                    TextSpan(
                        text: "87%",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary)),
                    const TextSpan(
                      text: " 인증 로그 ✅",
                    ),
                  ],
                ),
              ),
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                for (int i = 0; i < 16 * 2 + 1; i++)
                  if (i % 2 == 0)
                    const Divider()
                  else
                    const Photolog(
                      username: "오진수",
                      showJoinedAt: false,
                      showSuccesRate: false,
                      showMoreButton: true,
                    ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
