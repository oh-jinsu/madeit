import 'package:antenna/antenna.dart';
import 'package:madeit/application/events/my_reactions_counted.dart';
import 'package:madeit/application/models/reaction_counts.dart';

final myReactionCountsStore = createStore<ReactionCountsModel?>(({
  ReactionCountsModel? state,
  event,
}) {
  if (event is MyReactionsCounted) {
    return event.model;
  }

  return state;
});
