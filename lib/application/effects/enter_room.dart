import 'package:antenna/antenna.dart';
import 'package:madeit/application/effects/functions/refresh.dart';
import 'package:madeit/application/effects/functions/retry.dart';
import 'package:madeit/application/effects/functions/with_auth.dart';
import 'package:madeit/application/effects/predicates/typeof.dart';
import 'package:madeit/application/events/enter_room_failed.dart';
import 'package:madeit/application/events/enter_room_finished.dart';
import 'package:madeit/application/events/enter_room_pending.dart';
import 'package:madeit/application/events/enter_room_requested.dart';
import 'package:madeit/implementation/providers/http_client/client.dart';
import 'package:madeit/implementation/providers/http_client/response.dart';

final enterRoomEffect = when<EnterRoomRequested>((event) async {
  dispatch(const EnterRoomPending());

  final response = await retry(
    refresh(post(
      "participants",
      body: {
        "room_id": event.roomId,
      },
      headers: await bearerTokenHeader(),
    )),
  )();

  if (response is! SuccessResponse) {
    return dispatch(const EnterRoomFailed());
  }

  dispatch(EnterRoomFinished(event.roomId));
});
