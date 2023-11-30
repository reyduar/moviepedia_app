import 'package:dio/dio.dart';
import 'package:moviepedia_app/config/constants/environment.dart';
import 'package:moviepedia_app/domain/datasources/movies_datasource.dart';
import 'package:moviepedia_app/domain/entities/movie.dart';
import 'package:moviepedia_app/infrastructure/datasources/models/moviedb/moviedb_response.dart';
import 'package:moviepedia_app/infrastructure/mappers/movie_mapper.dart';

class MoviedbDatasource extends MovieDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: Environment.apiUrl,
    queryParameters: {
      'api_key': Environment.dbkey,
      'language': 'es-MX',
    },
  ));
  @override
  Future<List<Movie>> getMoviesShowtimes({int page = 1}) async {
    final response = await dio.get('/movie/now_playing', queryParameters: {
      'page': page,
    });

    final moviedbResponse = MovieDbResponse.fromJson(response.data);
    final movies = moviedbResponse.results
        .where((item) => item.posterPath != 'no-poster')
        .map((item) => MovieMapper.movieDBToEntity(item))
        .toList();

    return movies;
  }
}
