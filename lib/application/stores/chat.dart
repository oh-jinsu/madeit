import 'package:antenna/antenna.dart';
import 'package:madeit/application/events/chatted.dart';
import 'package:madeit/application/events/exit_room_finished.dart';
import 'package:madeit/application/events/list_of_chat_found.dart';
import 'package:madeit/application/events/list_of_chat_pending.dart';
import 'package:madeit/application/events/my_rooms_found.dart';
import 'package:madeit/application/events/sign_out_finished.dart';
import 'package:madeit/application/models/chat/chat.dart';
import 'package:madeit/application/models/list_of.dart';
import 'package:madeit/application/models/option.dart';

final chatStore = createStore<Map<String, ListOf<ChatModel>>>(({
  state = const <String, ListOf<ChatModel>>{},
  event,
}) {
  if (event is SignOutFinished) {
    return const {};
  }

  if (event is MyRoomsFound) {
    return {
      for (final v in event.models)
        v.id: const ListOf(isPending: false, next: Option(null), items: [])
    };
  }

  if (event is Chatted) {
    return state.map((key, value) {
      if (key != event.model.roomId) {
        return MapEntry(key, value);
      }

      return MapEntry(
        key,
        value.copy(
          items: [event.model, ...value.items],
        ),
      );
    });
  }

  if (event is ListOfChatPending) {
    return state.map((key, value) {
      if (key != event.roomId) {
        return MapEntry(key, value);
      }

      return MapEntry(key, value.copy(isPending: true));
    });
  }

  if (event is ListOfChatFound) {
    return state.map((key, value) {
      if (key != event.roomId) {
        return MapEntry(key, value);
      }

      return MapEntry(
        key,
        value.copy(
          isPending: false,
          next: event.listOfModel.next,
          items: [
            ...value.items,
            ...event.listOfModel.items,
          ],
        ),
      );
    });
  }

  if (event is ExitRoomFinished) {
    return Map.from(state)..removeWhere((key, value) => key == event.roomId);
  }

  return state;
});
