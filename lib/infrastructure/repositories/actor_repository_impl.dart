import 'package:moviepedia_app/domain/datasources/actor_datasource.dart';
import 'package:moviepedia_app/domain/entities/actor.dart';
import 'package:moviepedia_app/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl extends ActorRepository {
  final ActorDatasource datasource;
  ActorRepositoryImpl(this.datasource);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return datasource.getActorsByMovie(movieId);
  }
}
