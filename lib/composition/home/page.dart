import 'package:flutter/material.dart';
import 'package:madeit/application/reducers/list_of_room.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: listOfRoomStore,
        builder: (context, snapshot) {
          return const Center(
            child: Text("Hello world"),
          );
        },
      ),
    );
  }
}
