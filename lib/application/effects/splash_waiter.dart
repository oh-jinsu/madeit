import 'package:flutter/material.dart';
import 'package:madeit/application/events/list_of_room_found.dart';
import 'package:madeit/main.dart';

void splashWaiterEffect(ListOfRoomFound event) {
  Navigator.of(requireContext).pushReplacementNamed("/home");
}
