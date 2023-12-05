import 'package:moviepedia_app/domain/entities/actor.dart';

abstract class ActorRepository {
  Future<List<Actor>> getActorsByMovie(String movieId);
}
