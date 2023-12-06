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

  @override
  Future<List<Movie>> getMoviesPopular({int page = 1}) {
    return datasource.getMoviesPopular(page: page);
  }

  @override
  Future<List<Movie>> getMoviesTopRated({int page = 1}) {
    return datasource.getMoviesTopRated(page: page);
  }

  @override
  Future<List<Movie>> getMoviesUpcoming({int page = 1}) {
    return datasource.getMoviesUpcoming(page: page);
  }

  @override
  Future<Movie> getMovieById(String id) {
    return datasource.getMovieById(id);
  }

  @override
  Future<List<Movie>> searchMovies(String query) {
    return datasource.searchMovies(query);
  }
}
