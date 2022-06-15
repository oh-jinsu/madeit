import 'package:flutter/material.dart';
import 'package:madeit/composition/common/constants/strings.dart';

class AppNavigationBar extends StatelessWidget {
  final int currentIndex;

  const AppNavigationBar({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey[200]!,
          ),
        ),
      ),
      child: BottomNavigationBar(
        onTap: (index) {
          if (index == currentIndex) {
            return;
          }

          switch (index) {
            case 0:
              Navigator.of(context).pushReplacementNamed("/home");
              break;
            case 1:
              Navigator.of(context).pushReplacementNamed("/room/mine");
              break;
            case 2:
              Navigator.of(context).pushReplacementNamed("/profile");
              break;
          }
        },
        elevation: 0.0,
        backgroundColor: Colors.white,
        currentIndex: currentIndex,
        selectedFontSize: 12.0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: Strings.exploration,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: Strings.myRoutine,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: Strings.profile,
          ),
        ],
      ),
    );
  }
}
