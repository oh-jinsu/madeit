import 'package:madeit/application/events/list_of_room_found.dart';
import 'package:madeit/application/models/list_of.dart';
import 'package:madeit/application/models/room.dart';
import 'package:madeit/core/store.dart';

ListOf<RoomModel>? listOfRoomReducer(ListOf<RoomModel>? state, dynamic event) {
  if (event is ListOfRoomFound) {
    return event.model;
  }

  return state;
}

final listOfRoomStore = createStore(listOfRoomReducer);
