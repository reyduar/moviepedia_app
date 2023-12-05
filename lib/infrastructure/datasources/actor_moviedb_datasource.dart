import 'package:dio/dio.dart';
import 'package:moviepedia_app/config/constants/environment.dart';
import 'package:moviepedia_app/domain/datasources/actor_datasource.dart';
import 'package:moviepedia_app/domain/entities/actor.dart';
import 'package:moviepedia_app/infrastructure/mappers/actor_mapper.dart';
import 'package:moviepedia_app/infrastructure/models/moviedb/credits_response.dart';

class ActorMovieDbDatasource extends ActorDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: Environment.apiUrl,
    queryParameters: {
      'api_key': Environment.dbkey,
      'language': 'es-MX',
    },
  ));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');
    final castResponse = CreditsResponse.fromJson(response.data);

    List<Actor> actors = castResponse.cast
        .map((cast) => ActorMapper.castToEntity(cast))
        .toList();

    return actors;
  }
}
