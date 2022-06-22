import 'package:antenna/antenna.dart';
import 'package:madeit/application/effects/functions/refresh.dart';
import 'package:madeit/application/effects/functions/retry.dart';
import 'package:madeit/application/effects/functions/with_auth.dart';
import 'package:madeit/application/effects/predicates/typeof.dart';
import 'package:madeit/application/events/my_reactions_counted.dart';
import 'package:madeit/application/events/user_found.dart';
import 'package:madeit/application/models/reaction_counts.dart';
import 'package:madeit/implementation/providers/http_client/client.dart';
import 'package:madeit/implementation/providers/http_client/response.dart';

final countMyReactionsEffect = when<UserFound>((event) async {
  final response = await retry(
    refresh(get("reactions/mine/count", headers: await bearerTokenHeader())),
  )();

  if (response is! SuccessResponse) {
    return;
  }

  final model = ReactionCountsModel.fromJson(response.body);

  dispatch(MyReactionsCounted(model));
});
