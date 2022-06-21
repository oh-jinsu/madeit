import 'package:antenna/antenna.dart';
import 'package:madeit/application/events/chatted.dart';
import 'package:madeit/application/events/my_rooms_found.dart';
import 'package:madeit/application/events/sign_out_finished.dart';
import 'package:madeit/application/models/my_room.dart';
import 'package:madeit/application/models/option.dart';

final myRoomsStore = createStore<List<MyRoomModel>?>(({
  List<MyRoomModel>? state,
  dynamic event,
}) {
  if (event is MyRoomsFound) {
    return event.models;
  }

  if (event is SignOutFinished) {
    return null;
  }

  if (event is Chatted) {
    return state?.map((room) {
      if (room.id != event.model.roomId) {
        return room;
      }

      return room.copy(lastChat: Option(event.model));
    }).toList();
  }

  return state;
});
