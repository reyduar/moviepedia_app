import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:moviepedia_app/config/helpers/human_formats.dart';
import 'package:moviepedia_app/domain/entities/movie.dart';

typedef SearchMovieCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate {
  final SearchMovieCallback searchMovie;

  SearchMovieDelegate({required this.searchMovie});

  @override
  String? get searchFieldLabel => 'Search movie by name';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      // if (query.isNotEmpty)
      FadeIn(
        duration: const Duration(milliseconds: 300),
        animate: query.isNotEmpty,
        child: IconButton(
          onPressed: () => query = '',
          icon: const Icon(Icons.clear),
        ),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('Results!!');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: searchMovie(query),
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        if (movies.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return _MovieSearchResults(
                movie: movie,
                onMovieSelected: close,
              );
            });
      },
    );
  }
}

class _MovieSearchResults extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;
  const _MovieSearchResults(
      {required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                movie.posterPath,
                width: size.width * 0.2,
              ),
            ),

            const SizedBox(width: 10),

            // Descripción
            SizedBox(
              width: (size.width - 40) * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: textStyles.titleMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    movie.overview,
                    style: textStyles.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  Row(
                    children: [
                      Icon(Icons.star_half_rounded,
                          size: 15, color: Colors.yellow.shade800),
                      const SizedBox(width: 5),
                      Text(
                        HumanFormats.number(movie.voteAverage, 1),
                        style: textStyles.bodyMedium!
                            .copyWith(color: Colors.yellow.shade800),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
