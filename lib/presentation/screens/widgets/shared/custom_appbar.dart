import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moviepedia_app/domain/entities/movie.dart';
import 'package:moviepedia_app/presentation/delegates/search_movie_delegate.dart';
import 'package:moviepedia_app/presentation/providers/movies/movies_repository_provider.dart';
import 'package:moviepedia_app/presentation/providers/search/search_movies_provider.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Icon(Icons.movie_outlined, color: colors.primary),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Showtime Movies',
                  style: titleStyle,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    final movieRepository = ref.read(movieRepositoryProvider);
                    final searchQuery = ref.read(searchQueryProvider);
                    showSearch<Movie?>(
                        query: searchQuery,
                        context: context,
                        delegate: SearchMovieDelegate(
                          searchMovie: (query) {
                            ref
                                .read(searchQueryProvider.notifier)
                                .update((state) => query);
                            return movieRepository.searchMovies(query);
                          },
                        )).then((movie) {
                      if (movie == null) return;
                      context.push('/movie/${movie.id}');
                    });
                  },
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
          ),
        ));
  }
}
