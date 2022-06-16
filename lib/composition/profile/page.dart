import 'package:flutter/material.dart';
import 'package:madeit/composition/common/constants/strings.dart';
import 'package:madeit/composition/common/properties/text_style.dart';
import 'package:madeit/composition/common/widgets/avatar.dart';
import 'package:madeit/composition/common/widgets/navigation_bar.dart';
import 'package:madeit/composition/common/widgets/record_group.dart';
import 'package:madeit/composition/profile/widget/group.dart';
import 'package:madeit/composition/profile/widget/menu.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.profile),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 24.0,
        ),
        child: Column(
          children: [
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
            const SizedBox(height: 16.0),
            const RecordGroup(),
            const SizedBox(height: 16.0),
            const ProfileGroup(
              children: [
                ProfileMenu(
                  label: Text(
                    "이름, 프로필 사진",
                    style: BodyTextStyle(),
                  ),
                ),
                ProfileMenu(
                  label: Text(
                    "계정",
                    style: BodyTextStyle(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const ProfileGroup(
              children: [
                ProfileMenu(
                  label: Text(
                    "서비스이용약관",
                    style: BodyTextStyle(),
                  ),
                ),
                ProfileMenu(
                  label: Text(
                    "개인정보처리방침",
                    style: BodyTextStyle(),
                  ),
                ),
                ProfileMenu(
                  label: Text(
                    "지원 및 문의",
                    style: BodyTextStyle(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            ProfileGroup(
              children: [
                ProfileMenu(
                  label: Text(
                    "로그아웃",
                    style: BodyTextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppNavigationBar(currentIndex: 2),
    );
  }
}
