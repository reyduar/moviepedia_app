import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moviepedia_app/presentation/providers/storage/favorite_movies_provider.dart';
import 'package:moviepedia_app/presentation/screens/widgets/widgets.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLastPage = false;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;

    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;
    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();

    if (favoriteMovies.isEmpty) {
      final colors = Theme.of(context).colorScheme;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.heart_broken,
              size: 100,
              color: colors.primary,
            ),
            Text(
              'No favorites were found!!!',
              style: TextStyle(fontSize: 30, color: colors.primary),
            ),
            const SizedBox(height: 20),
            const Text(
              'You don not have any favorite movies yet.',
              style: TextStyle(fontSize: 20, color: Colors.black45),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.go('/home/0');
              },
              child: const Text('Go Back'),
            )
          ],
        ),
      );
    }

    return Scaffold(
        body: MovieMasonry(loadNextPage: loadNextPage, movies: favoriteMovies));
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