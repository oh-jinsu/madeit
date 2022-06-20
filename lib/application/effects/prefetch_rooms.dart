import 'package:antenna/antenna.dart';
import 'package:madeit/application/effects/functions/protect.dart';
import 'package:madeit/application/effects/predicates/typeof.dart';
import 'package:madeit/application/events/list_of_room_found.dart';
import 'package:madeit/application/events/provider_injected.dart';
import 'package:madeit/application/models/list_of.dart';
import 'package:madeit/application/models/room.dart';
import 'package:madeit/implementation/providers/http_client/client.dart';
import 'package:madeit/implementation/providers/http_client/response.dart';

final prefetchRoomsEffect = when<ProviderInjected>((dynamic event) async {
  final response = await retry(() => get("rooms"));

  if (response is! SuccessResponse) {
    return;
  }

  final model = ListOf.fromJson(response.body, RoomModel.fromjson);

  dispatch(ListOfRoomFound(model));
});
