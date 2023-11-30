import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviepedia_app/presentation/providers/movies/movies_providers.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moviepedia'),
      ),
      body: const _HomeView(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(showtimesMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final showtimesMovies = ref.watch(showtimesMoviesProvider);
    if (showtimesMovies.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
        itemCount: showtimesMovies.length,
        itemBuilder: (context, index) {
          final movie = showtimesMovies[index];
          return ListTile(title: Text(movie.title));
        });
  }
}
