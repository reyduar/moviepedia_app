import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(showtimesMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(toRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    //* Espera que se carguen todos datos de las secciones
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();

    //* Renderiza el scroll view con los datos cargados
    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final showtimesMovies = ref.watch(showtimesMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final toRatedMovies = ref.watch(toRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);

    //* Implementamos este CustomScrollView para poder separar el CustomAppbar de la lista del SingleChildScrollView
    return Visibility(
      visible: !initialLoading,
      child: CustomScrollView(slivers: [
        //* Ahora implmentamos el CustomAppbar en el SliverAppBar para que sea flotante
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
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
                  movies: upcomingMovies,
                  loadNextPage: () {
                    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
                  },
                ),
                // Recomendados
                MovieHorizontalListView(
                  title: 'Recommended',
                  subTitle: 'Top Rated',
                  movies: toRatedMovies,
                  loadNextPage: () {
                    ref.read(toRatedMoviesProvider.notifier).loadNextPage();
                  },
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            );
          },
          childCount: 1,
        ))
      ]),
    );
  }
}
