import 'package:antenna/antenna.dart';
import 'package:madeit/application/events/list_of_room_found.dart';
import 'package:madeit/application/models/list_of.dart';
import 'package:madeit/application/models/room.dart';

final listOfRoomStore = createStore<ListOf<RoomModel>?>(({
  ListOf<RoomModel>? state,
  dynamic event,
}) {
  if (event is ListOfRoomFound) {
    return event.model;
  }

  return state;
});
