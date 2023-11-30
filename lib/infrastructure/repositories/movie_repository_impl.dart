import 'package:moviepedia_app/domain/entities/movie.dart';
import 'package:moviepedia_app/domain/repositories/movies_repository.dart';
import 'package:moviepedia_app/infrastructure/datasources/moviedb_datasource.dart';

class MovieReposioryImpl extends MovieRepository {
  final MoviedbDatasource datasource;
  MovieReposioryImpl(this.datasource);
  @override
  Future<List<Movie>> getMoviesShowtimes({int page = 1}) {
    return datasource.getMoviesShowtimes(page: page);
  }
}
