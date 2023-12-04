import 'package:moviepedia_app/domain/entities/movie.dart';

abstract class MovieDatasource {
  Future<List<Movie>> getMoviesShowtimes({int page = 1});
  Future<List<Movie>> getMoviesPopular({int page = 1});
  Future<List<Movie>> getMoviesUpcoming({int page = 1});
  Future<List<Movie>> getMoviesTopRated({int page = 1});
  Future<Movie> getMovieById(String id);
}
