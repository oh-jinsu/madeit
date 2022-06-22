import 'package:antenna/antenna.dart';
import 'package:madeit/application/effects/functions/refresh.dart';
import 'package:madeit/application/effects/functions/retry.dart';
import 'package:madeit/application/effects/functions/with_auth.dart';
import 'package:madeit/application/effects/predicates/typeof.dart';
import 'package:madeit/application/events/list_of_chat_found.dart';
import 'package:madeit/application/events/list_of_chat_pending.dart';
import 'package:madeit/application/events/more_chats_requested.dart';
import 'package:madeit/application/models/chat/chat.dart';
import 'package:madeit/application/models/list_of.dart';
import 'package:madeit/implementation/providers/http_client/client.dart';
import 'package:madeit/implementation/providers/http_client/response.dart';

final findListOfChatEffect = when<MoreChatsRequested>((event) async {
  dispatch(ListOfChatPending(roomId: event.roomId));

  final response = await retry(
    refresh(
      get(
        "chats?room_id=${event.roomId}${event.cursor != null ? "&cursor=${event.cursor}" : ""}&limit=20",
        headers: await bearerTokenHeader(),
      ),
    ),
  )();

  if (response is! SuccessResponse) {
    return;
  }

  final listOfModel = ListOf.fromJson(response.body, ChatModel.fromjson);

  dispatch(ListOfChatFound(roomId: event.roomId, listOfModel: listOfModel));
});
