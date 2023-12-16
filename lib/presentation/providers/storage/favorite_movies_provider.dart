import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviepedia_app/domain/entities/movie.dart';
import 'package:moviepedia_app/domain/repositories/local_storage_repository.dart';

import '../providers.dart';

final favoriteMoviesProvider =
    StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return StorageMoviesNotifier(localStorageRepository: localStorageRepository);
});

/*
 {
  1234: Movie,
  1235: Movie,
  1236: Movie
 } 
 */

class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  final LocalStorageRepository localStorageRepository;
  StorageMoviesNotifier({required this.localStorageRepository}) : super({});

  Future<void> loadNextPage() async {
    final movies =
        await localStorageRepository.loadMovies(offset: page * 10); // limit: 20
    page++;
    final tempMoviesMap = <int, Movie>{};
    for (final movie in movies) {
      tempMoviesMap[movie.id] = movie;
    }

    state = {...state, ...tempMoviesMap};
  }
}
