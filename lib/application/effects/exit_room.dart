import 'package:antenna/antenna.dart';
import 'package:madeit/application/effects/functions/protect.dart';
import 'package:madeit/application/effects/functions/with_auth.dart';
import 'package:madeit/application/effects/predicates/typeof.dart';
import 'package:madeit/application/events/exit_room_finished.dart';
import 'package:madeit/application/events/exit_room_requested.dart';
import 'package:madeit/implementation/providers/http_client/client.dart';
import 'package:madeit/implementation/providers/http_client/response.dart';

final exitRoomEffect = when<ExitRoomRequested>((event) async {
  final response = await retry(
    () async => delete(
      "participants",
      body: {
        "room_id": event.roomId,
      },
      headers: await bearerTokenHeader(),
    ),
  );

  if (response is! SuccessResponse) {
    return;
  }

  dispatch(ExitRoomFinished(event.roomId));
});
