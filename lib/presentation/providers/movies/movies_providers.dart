import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviepedia_app/domain/entities/movie.dart';
import '../providers.dart';

final showtimesMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getMoviesShowtimes;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getMoviesPopular;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final upcomingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getMoviesUpcoming;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final toRatedMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getMoviesTopRated;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  bool isLoading = false;
  MovieCallback fetchMoreMovies;
  MoviesNotifier({
    required this.fetchMoreMovies,
  }) : super([]);

  Future<void> loadNextPage() async {
    // isLoading lo vamos a usar para que no disparen demasiados requets de un solo scroll, entonces carga una pagina por scroll
    if (isLoading) return;

    isLoading = true;

    // Hacemos el fetch de peliculas a la api
    currentPage++;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];

    // Le damos un tiempo para hacer un reset de la variable isLoading
    await Future.delayed(const Duration(microseconds: 300));
    isLoading = false;
  }
}
