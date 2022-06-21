import 'dart:convert';

import 'package:antenna/antenna.dart';
import 'package:madeit/application/events/chatted.dart';
import 'package:madeit/application/events/sign_out_finished.dart';
import 'package:madeit/application/events/user_found.dart';
import 'package:madeit/application/models/chat/chat.dart';
import 'package:madeit/implementation/providers/ws_client/client.dart';
import 'package:madeit/implementation/repositories/auth.dart';
import 'package:madeit/utilities/debug.dart';
import 'package:madeit/utilities/dependency.dart';

wsEffect(event) async {
  if (event is UserFound) {
    final client = inject<WsClient>();

    final repository = inject<AuthRepository>();

    final accessToken = await repository.findAccessToken();

    if (accessToken == null) {
      return;
    }

    client.setClient(query: {
      "token": accessToken,
    });

    client.on("chat-created", (data) {
      final model = ChatModel.fromjson(data);

      dispatch(Chatted(model));
    });

    client.onConnect((data) {
      show("socket conneceted");
    });

    client.onDisconnect((data) {
      show("socket disconnected");
    });

    client.connect();
  }

  if (event is SignOutFinished) {
    final client = inject<WsClient>();

    client.disconnect();
  }
}
