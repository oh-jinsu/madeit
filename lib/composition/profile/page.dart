import 'package:flutter/material.dart';
import 'package:madeit/composition/common/constants/strings.dart';
import 'package:madeit/composition/common/widgets/avatar.dart';
import 'package:madeit/composition/common/widgets/navigation_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.profile),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [
            Center(
              child: Avatar(radius: 40.0),
            ),
            SizedBox(height: 16.0),
            Text(
              "오진수",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
      bottomNavigationBar: const AppNavigationBar(currentIndex: 2),
    );
  }
}
