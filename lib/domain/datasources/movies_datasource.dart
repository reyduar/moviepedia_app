import 'package:moviepedia_app/domain/entities/movie.dart';

abstract class MovieDatasource {
  Future<List<Movie>> getMoviesShowtimes({int page = 1});
}
