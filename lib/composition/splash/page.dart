import 'package:flutter/material.dart';
import 'package:madeit/application/events/list_of_room_found.dart';
import 'package:madeit/core/manager.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SubscriptionManagerMixin {
  @override
  void initState() {
    on((ListOfRoomFound event) {
      Navigator.of(context).pushReplacementNamed("/home");
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
