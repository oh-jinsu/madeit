import 'package:antenna/antenna.dart';
import 'package:flutter/material.dart';
import 'package:madeit/application/events/list_of_room_found.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with AntennaManager {
  @override
  void initState() {
    on((event) {
      if (event is ListOfRoomFound) {
        Navigator.of(context).pushReplacementNamed("/home");
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
