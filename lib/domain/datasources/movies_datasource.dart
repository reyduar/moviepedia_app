import '../entities/entities.dart';

abstract class MovieDatasource {
  Future<List<Movie>> getMoviesShowtimes({int page = 1});
  Future<List<Movie>> getMoviesPopular({int page = 1});
  Future<List<Movie>> getMoviesUpcoming({int page = 1});
  Future<List<Movie>> getMoviesTopRated({int page = 1});
  Future<Movie> getMovieById(String id);
  Future<List<Movie>> searchMovies(String query);
  Future<List<Movie>> getSimilarMovies(int movieId);
  Future<List<Video>> getYoutubeVideosById(int movieId);
}
