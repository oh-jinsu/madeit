import 'package:antenna/antenna.dart';
import 'package:madeit/application/effects/functions/protect.dart';
import 'package:madeit/application/effects/functions/with_auth.dart';
import 'package:madeit/application/events/enter_room_finished.dart';
import 'package:madeit/application/events/my_rooms_found.dart';
import 'package:madeit/application/events/user_found.dart';
import 'package:madeit/application/models/my_room.dart';
import 'package:madeit/implementation/providers/http_client/client.dart';
import 'package:madeit/implementation/providers/http_client/response.dart';

findMyRoomsEffect(dynamic event) async {
  if (event is UserFound) {
    _findMyRooms();
  }

  if (event is EnterRoomFinished) {
    _findMyRooms();
  }
}

_findMyRooms() async {
  final response = await retry(
    () async => get("rooms/mine", headers: await bearerTokenHeader()),
  );

  if (response is! SuccessResponse) {
    return;
  }

  final models = (response.body as List).map(MyRoomModel.fromjson).toList();

  dispatch(MyRoomsFound(models));
}
