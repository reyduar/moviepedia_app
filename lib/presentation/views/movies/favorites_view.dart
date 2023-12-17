import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviepedia_app/presentation/providers/storage/favorite_movies_provider.dart';
import 'package:moviepedia_app/presentation/screens/widgets/widgets.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  @override
  void initState() {
    super.initState();
    ref.read(favoriteMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();

    return Scaffold(body: MovieMasonry(movies: favoriteMovies));
  }
}


// ListView.builder(
//       itemCount: favoriteMovies.length,
//       itemBuilder: (context, index) {
//         final movie = favoriteMovies[index];
//         return ListTile(
//           title: Text(movie.title),
//         );
//       },
//     )