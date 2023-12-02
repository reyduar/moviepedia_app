import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviepedia_app/domain/entities/movie.dart';

import 'movies_providers.dart';

final moviesSlideshowProvider = Provider<List<Movie>>((ref) {
  final showtimeMovies = ref.watch(showtimesMoviesProvider);
  if (showtimeMovies.isEmpty) return [];

  return showtimeMovies.sublist(0, 6);
});
