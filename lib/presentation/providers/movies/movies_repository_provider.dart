import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviepedia_app/infrastructure/datasources/moviedb_datasource.dart';
import 'package:moviepedia_app/infrastructure/repositories/movie_repository_impl.dart';

// Este repositorio es inmutable; su objetivo es proporcionar a los demas provider todas las implementaciones
final movieRepositoryProvider = Provider((ref) {
  // final language = ref.watch(languageProvider);
  return MovieReposioryImpl(MoviedbDatasource());
});
