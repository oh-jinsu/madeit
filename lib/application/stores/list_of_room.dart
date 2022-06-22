import 'package:antenna/antenna.dart';
import 'package:madeit/application/events/enter_room_finished.dart';
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

  if (event is EnterRoomFinished) {
    return state?.copy(
      items: state.items.map((item) {
        if (item.id != event.roomId) {
          return item;
        }

        return item.copy(
          participantCount: item.participantCount + 1,
        );
      }).toList(),
    );
  }

  return state;
});
