import 'package:flutter/material.dart';
import 'package:madeit/composition/common/widgets/photolog.dart';

class RoomPhotologListPage extends StatelessWidget {
  const RoomPhotologListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "멤버별 인증 로그 ✅",
        ),
        titleSpacing: 0.0,
      ),
      body: ListView(
        children: [
          for (int i = 0; i < 16 * 2 + 1; i++)
            if (i % 2 == 0)
              const Divider()
            else
              Photolog(
                username: "조대훈",
                onTap: () {
                  Navigator.of(context).pushNamed("/participant");
                },
              ),
        ],
      ),
    );
  }
}
