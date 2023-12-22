import 'package:go_router/go_router.dart';

import '../../presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
    GoRoute(
        path: '/home/:page',
        name: HomeScreen.name,
        builder: (context, state) {
          String pageIndex = state.pathParameters['page'] ?? '0';
          if (int.parse(pageIndex) > 2 || int.parse(pageIndex) < 0) {
            pageIndex = '0';
          }
          return HomeScreen(pageIndex: int.parse(pageIndex));
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
      path: '/',
      redirect: (_, __) => 'home/0',
    ),
    GoRoute(
      path: '/settings',
      name: SettingsScreen.name,
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
