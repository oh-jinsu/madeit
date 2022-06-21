import 'package:madeit/application/effects/functions/protect.dart';
import 'package:madeit/application/effects/functions/with_auth.dart';
import 'package:madeit/application/events/message_chat_submitted.dart';
import 'package:madeit/implementation/providers/http_client/client.dart';
import 'package:madeit/implementation/providers/http_client/response.dart';

sendChatEffect(dynamic event) async {
  if (event is MessageChatSubmitted) {
    final response = await retry(
      () async => post(
        "chats",
        body: {
          "type": "message",
          "room_id": event.roomId,
          "message": event.message,
        },
        headers: await bearerTokenHeader(),
      ),
    );

    if (response is! SuccessResponse) {
      return;
    }
  }
}
