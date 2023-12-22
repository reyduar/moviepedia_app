import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moviepedia_app/domain/entities/movie.dart';
import 'package:moviepedia_app/presentation/delegates/search_movie_delegate.dart';
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
                  'FilmSearch+',
                  style: titleStyle,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => showAboutDialog(context: context, children: [
                    const Text('FilmSearch+ v1.0 is a movie search app.'),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Copyright ©2024 Ariel Duarte'),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Powered by Flutter 3.'),
                  ]),
                  icon: const Icon(Icons.info_outline),
                ),
                const SizedBox(
                  width: 5,
                ),
                IconButton(
                  onPressed: () {
                    context.push('/settings');
                  },
                  icon: const Icon(Icons.settings),
                ),
                IconButton(
                  onPressed: () {
                    final searchMovies = ref.read(searchMoviesProvider);
                    final searchQuery = ref.read(searchQueryProvider);
                    showSearch<Movie?>(
                            query: searchQuery,
                            context: context,
                            delegate: SearchMovieDelegate(
                                initialMovies: searchMovies,
                                searchMovie: ref
                                    .read(searchMoviesProvider.notifier)
                                    .searchMoviesByQuery))
                        .then((movie) {
                      if (movie == null) return;
                      context.push('/home/0/movie/${movie.id}');
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
