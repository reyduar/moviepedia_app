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
    ref.read(popularMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final showtimesMovies = ref.watch(showtimesMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    if (slideShowMovies.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    //* Implementamos este CustomScrollView para poder separar el CustomAppbar de la lista del SingleChildScrollView
    return CustomScrollView(slivers: [
      //* Ahora implmentamos el CustomAppbar en el SliverAppBar para que sea flotante
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          title: CustomAppbar(),
        ),
      ),
      SliverList(delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Column(
            children: [
              // const CustomAppbar(),
              MoviesSlideshow(movies: slideShowMovies),
              // En cartelera
              MovieHorizontalListView(
                title: 'Showtime',
                subTitle: 'Monday 20',
                movies: showtimesMovies,
                loadNextPage: () {
                  ref.read(showtimesMoviesProvider.notifier).loadNextPage();
                },
              ),
              // Populares
              MovieHorizontalListView(
                title: 'Popular',
                subTitle: 'Best reviews',
                movies: popularMovies,
                loadNextPage: () {
                  ref.read(popularMoviesProvider.notifier).loadNextPage();
                },
              ),
              // Estrenos
              MovieHorizontalListView(
                title: 'Upcoming',
                subTitle: 'Upcoming Movies',
                movies: showtimesMovies,
                loadNextPage: () {
                  ref.read(popularMoviesProvider.notifier).loadNextPage();
                },
              ),
              // Recomendados
              MovieHorizontalListView(
                title: 'Recommended',
                subTitle: 'Based on your favorites',
                movies: showtimesMovies,
                loadNextPage: () {
                  ref.read(showtimesMoviesProvider.notifier).loadNextPage();
                },
              ),
              const SizedBox(
                height: 50,
              )
            ],
          );
        },
      ))
    ]);
  }
}

//* Example of list
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

//* Ejemplo de un Single child scroll view para evitar para mostrar diferentes widgets en columnas
// SingleChildScrollView(
//       child: Column(
//         children: [
//           const CustomAppbar(),
//           MoviesSlideshow(movies: slideShowMovies),
//           // En cartelera
//           MovieHorizontalListView(
//             title: 'Showtime',
//             subTitle: 'Monday 20',
//             movies: showtimesMovies,
//             loadNextPage: () {
//               ref.read(showtimesMoviesProvider.notifier).loadNextPage();
//             },
//           ),
//           // Estrenos
//           MovieHorizontalListView(
//             title: 'Upcoming',
//             subTitle: 'Upcoming Movies',
//             movies: showtimesMovies,
//             loadNextPage: () {
//               ref.read(showtimesMoviesProvider.notifier).loadNextPage();
//             },
//           ),
//           // Populares
//           MovieHorizontalListView(
//             title: 'Popular',
//             subTitle: 'Best reviews',
//             movies: showtimesMovies,
//             loadNextPage: () {
//               ref.read(showtimesMoviesProvider.notifier).loadNextPage();
//             },
//           ),
//           // Recomendados
//           MovieHorizontalListView(
//             title: 'Recommended',
//             subTitle: 'Based on your favorites',
//             movies: showtimesMovies,
//             loadNextPage: () {
//               ref.read(showtimesMoviesProvider.notifier).loadNextPage();
//             },
//           ),
//           const SizedBox(
//             height: 50,
//           )
//         ],
//       ),
//     );
