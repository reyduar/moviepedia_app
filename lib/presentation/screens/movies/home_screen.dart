import 'package:flutter/material.dart';
import 'package:moviepedia_app/presentation/screens/widgets/widgets.dart';

import '../../views/views.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  final Widget childView;

  const HomeScreen({super.key, required this.childView});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: childView,
      bottomNavigationBar: CustomBottomNavbar(),
    );
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
