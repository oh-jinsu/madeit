import 'package:antenna/antenna.dart';
import 'package:madeit/application/events/my_rooms_found.dart';
import 'package:madeit/application/models/my_room.dart';

final myRoomsStore = createStore<List<MyRoomModel>?>(({
  List<MyRoomModel>? state,
  dynamic event,
}) {
  if (event is MyRoomsFound) {
    return event.models;
  }

  return state;
});
