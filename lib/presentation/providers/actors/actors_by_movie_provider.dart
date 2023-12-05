import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviepedia_app/domain/entities/actor.dart';

import '../providers.dart';

/*
* Actor Provider Example
{
  '505342': <Actor>[],
  '505343': <Actor>[],
  '505344': <Actor>[]
}
*/

final actorByMovieProvider =
    StateNotifierProvider<ActorByMovieMapNotifier, Map<String, List<Actor>>>(
        (ref) {
  final actorRepository = ref.watch(actorsRepositoryProvider);
  return ActorByMovieMapNotifier(getActors: actorRepository.getActorsByMovie);
});

typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorByMovieMapNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getActors;
  ActorByMovieMapNotifier({required this.getActors}) : super({});

  Future<void> loadActor(String moviedId) async {
    if (state[moviedId] != null) return;

    final List<Actor> actors = await getActors(moviedId);

    state = {...state, moviedId: actors};
  }
}
