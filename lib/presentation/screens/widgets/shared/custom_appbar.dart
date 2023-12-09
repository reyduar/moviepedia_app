import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviepedia_app/presentation/delegates/search_movie_delegate.dart';
import 'package:moviepedia_app/presentation/providers/movies/movies_repository_provider.dart';

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
                    showSearch(
                        context: context,
                        delegate: SearchMovieDelegate(
                          searchMovie: movieRepository.searchMovies,
                        ));
                  },
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
          ),
        ));
  }
}
