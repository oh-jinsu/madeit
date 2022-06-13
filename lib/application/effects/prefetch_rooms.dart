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

  final model = ListOf.fromJson(response.body, RoomModel.fromjson);

  dispatch(ListOfRoomFound(model));
}
