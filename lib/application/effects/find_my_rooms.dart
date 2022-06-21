import 'package:antenna/antenna.dart';
import 'package:madeit/application/effects/functions/protect.dart';
import 'package:madeit/application/effects/functions/with_auth.dart';
import 'package:madeit/application/effects/predicates/typeof.dart';
import 'package:madeit/application/events/my_rooms_found.dart';
import 'package:madeit/application/events/user_found.dart';
import 'package:madeit/application/models/my_room.dart';
import 'package:madeit/implementation/providers/http_client/client.dart';
import 'package:madeit/implementation/providers/http_client/response.dart';

final findMyRoomsEffect = when<UserFound>((dynamic event) async {
  final response = await retry(
    () async => get("rooms/mine", headers: await bearerTokenHeader()),
  );

  if (response is! SuccessResponse) {
    return;
  }

  final models = (response.body as List).map(MyRoomModel.fromjson).toList();

  dispatch(MyRoomsFound(models));
});
