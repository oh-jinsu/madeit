import 'package:flutter/material.dart';
import 'package:madeit/composition/room_participant_log/widgets/tile.dart';

class RoomParticipantLog extends StatelessWidget {
  const RoomParticipantLog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "인증 로그 ✅",
        ),
        titleSpacing: 0.0,
      ),
      body: ListView(
        children: [
          for (int i = 0; i < 16; i++) const RoomParticipantLogTile(),
        ],
      ),
    );
  }
}
