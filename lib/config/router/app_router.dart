import 'package:go_router/go_router.dart';
import 'package:moviepedia_app/presentation/views/views.dart';

import '../../presentation/screens/screens.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  ShellRoute(
      builder: (context, state, child) {
        return HomeScreen(
          childView: child,
        );
      },
      routes: [
        GoRoute(
            path: '/',
            builder: (context, state) {
              return const HomeView();
            },
            routes: [
              GoRoute(
                  path: 'movie/:id',
                  name: MovieScreen.name,
                  builder: (context, state) {
                    final idParam = state.pathParameters;
                    return MovieScreen(
                      movieId: idParam['id'] ?? 'no-id',
                    );
                  }),
            ]),
        GoRoute(
          path: '/favorites',
          builder: (context, state) {
            return const FavoritesView();
          },
        ),
      ]

      /** Configuracion simple rutas padre/hijo */
      // GoRoute(
      //     path: '/',
      //     name: HomeScreen.name,
      //     builder: (context, state) => const HomeScreen(
      //           childView: FavoritesView(),
      //         ),
      //     routes: [
      //       GoRoute(
      //           path: 'movie/:id',
      //           name: MovieScreen.name,
      //           builder: (context, state) {
      //             final idParam = state.pathParameters;
      //             return MovieScreen(
      //               movieId: idParam['id'] ?? 'no-id',
      //             );
      //           }),
      //     ]),
      )
]);
