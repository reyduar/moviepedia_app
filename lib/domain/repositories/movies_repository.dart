import 'package:moviepedia_app/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getMoviesShowtimes({int page = 1});
}
