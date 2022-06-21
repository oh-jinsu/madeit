import 'package:madeit/application/models/chat/chat.dart';
import 'package:madeit/application/models/list_of.dart';

class ListOfChatFound {
  final String roomId;
  final ListOf<ChatModel> listOfModel;

  const ListOfChatFound({
    required this.roomId,
    required this.listOfModel,
  });
}
