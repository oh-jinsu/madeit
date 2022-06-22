import 'package:antenna/antenna.dart';
import 'package:madeit/application/events/enter_room_failed.dart';
import 'package:madeit/application/events/enter_room_finished.dart';
import 'package:madeit/application/events/enter_room_pending.dart';

final enterRoomFormStore = createStore<bool>(({
  bool state = true,
  dynamic event,
}) {
  if (event is EnterRoomPending) {
    return false;
  }

  if (event is EnterRoomFinished || event is EnterRoomFailed) {
    return true;
  }

  return state;
});
