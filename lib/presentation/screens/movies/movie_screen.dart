import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviepedia_app/config/helpers/human_formats.dart';
import 'package:moviepedia_app/domain/entities/movie.dart';
import 'package:moviepedia_app/presentation/providers/providers.dart';

import '../../providers/movies/movie_detail_provider.dart';
import '../../widgets/widgets.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';
  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(movieDetailsProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorByMovieProvider.notifier).loadActor(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final movies = ref.watch(movieDetailsProvider);
    final Movie? movie = movies[widget.movieId];

    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: movie),
          _CustomSliverList(movie: movie),
        ],
      ),
    );
  }
}

class _CustomSliverList extends StatelessWidget {
  final Movie movie;
  const _CustomSliverList({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* Titulo, OverView y Rating
            _TitleAndOverview(movie: movie, size: size, textStyles: textStyles),

            //* Generos de la película
            _Genres(movie: movie),
            // Actores
            ActorsByMovie(movieId: movie.id.toString()),
            //* Videos de la película (si tiene)
            VideosFromMovie(movieId: movie.id),
            //* Películas similares
            SimilarMovies(movieId: movie.id),
          ],
        );
      }, childCount: 1),
    );
  }
}

final isFavoriteProvider =
    FutureProvider.family.autoDispose((ref, int movieId) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return localStorageRepository.isMovieFavorite(movieId);
});

class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;
  const _CustomSliverAppBar({
    required this.movie,
  });

  @override
  Widget build(BuildContext context, ref) {
    // MediaQuery para obtener las dimensiones del dispositivo
    final size = MediaQuery.of(context).size;

    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
            onPressed: () async {
              await ref
                  .read(favoriteMoviesProvider.notifier)
                  .toggleFavorite(movie);
              // invalidamos para que confirme el click al boton
              ref.invalidate(isFavoriteProvider(movie.id));
            },
            icon: isFavoriteFuture.when(
                data: (isFavorite) => isFavorite
                    ? const Icon(Icons.favorite_rounded, color: Colors.red)
                    : const Icon(Icons.favorite_border),
                error: (_, __) => throw UnimplementedError(),
                loading: () => const CircularProgressIndicator())),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        // title: Text(
        //   movie.title,
        //   style: const TextStyle(fontSize: 20),
        //   textAlign: TextAlign.center,
        // ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();

                  return FadeIn(child: child);
                },
              ),
            ),
            const _CustomGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.0, 0.2],
              colors: [Colors.black87, Colors.transparent],
            ),
            const _CustomGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.7, 1.0],
              colors: [Colors.transparent, Colors.black87],
            ),
            const _CustomGradient(
              begin: Alignment.topLeft,
              stops: [0.0, 0.3],
              colors: [Colors.black87, Colors.transparent],
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;

  const _CustomGradient(
      {this.begin = Alignment.centerLeft,
      this.end = Alignment.centerLeft,
      required this.stops,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            stops: stops,
            colors: colors,
          ),
        ),
      ),
    );
  }
}

class _Genres extends StatelessWidget {
  const _Genres({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: double.infinity,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            ...movie.genreIds.map((gender) => Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Chip(
                    label: Text(gender),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class _TitleAndOverview extends StatelessWidget {
  const _TitleAndOverview({
    required this.movie,
    required this.size,
    required this.textStyles,
  });
  final Movie movie;
  final Size size;
  final TextTheme textStyles;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              movie.posterPath,
              width: size.width * 0.3,
            ),
          ),
          const SizedBox(width: 10),
          // Descripción
          SizedBox(
            width: (size.width - 40) * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title, style: textStyles.titleLarge),
                Text(movie.overview),
                const SizedBox(height: 10),
                MovieRating(voteAverage: movie.voteAverage),
                Row(
                  children: [
                    const Text('Estreno:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 5),
                    Text(HumanFormats.shortDate(movie.releaseDate))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
