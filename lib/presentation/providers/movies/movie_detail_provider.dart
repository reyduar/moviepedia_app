import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviepedia_app/domain/entities/movie.dart';
import 'package:moviepedia_app/presentation/providers/providers.dart';

final movieDetailsProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return MovieMapNotifier(getMovie: movieRepository.getMovieById);
});

typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovie;
  MovieMapNotifier({required this.getMovie}) : super({});

  Future<void> loadMovie(String moviedId) async {
    if (state[moviedId] != null) return;
    final movie = await getMovie(moviedId);

    state = {...state, moviedId: movie};
  }
}
