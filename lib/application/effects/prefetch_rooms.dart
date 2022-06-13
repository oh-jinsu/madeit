import 'dart:math';

import 'package:madeit/application/events/list_of_room_found.dart';
import 'package:madeit/application/events/provider_injected.dart';
import 'package:madeit/application/models/list_of.dart';
import 'package:madeit/application/models/room.dart';
import 'package:madeit/core/channel.dart';
import 'package:madeit/implementation/providers/http_client/client.dart';
import 'package:madeit/implementation/providers/http_client/response.dart';
import 'package:madeit/utilities/dependency.dart';

prefetchRoomsEffect(ProviderInjected event) async {
  final client = inject<HttpClient>();

  final response = await client.get("rooms");

  if (response is! SuccessResponse) {
    return;
  }

  // final model = ListOf.fromJson(response.body, RoomModel.fromjson);

  final model = ListOf(
    next: null,
    items: List.generate(
      20,
      (index) {
        return RoomModel(
          id: index.toString(),
          title: "루틴 방 $index",
          participantCount: Random(10).nextInt(20) + 1,
          createdAt: DateTime.now().subtract(
            Duration(
              days: Random(20).nextInt(365),
            ),
          ),
        );
      },
    ),
  );

  dispatch(ListOfRoomFound(model));
}
