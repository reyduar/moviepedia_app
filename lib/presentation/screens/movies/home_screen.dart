import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviepedia_app/presentation/screens/widgets/widgets.dart';
import '../../providers/providers.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavbar(),
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
    // final showtimesMovies = ref.watch(showtimesMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    if (slideShowMovies.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return Column(
      children: [
        const CustomAppbar(),
        MoviesSlideshow(movies: slideShowMovies)
      ],
    );
  }
}

// Example of list
       // Expanded(
        //   child: ListView.builder(
        //     itemCount: showtimesMovies.length,
        //     itemBuilder: (context, index) {
        //       final movie = showtimesMovies[index];
        //       return ListTile(
        //         title: Text(movie.title),
        //         subtitle: Text(movie.overview),
        //       );
        //     },
        //   ),
        // ),