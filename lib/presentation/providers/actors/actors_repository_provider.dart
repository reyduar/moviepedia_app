// Este repositorio es inmutable; su objetivo es proporcionar a los demas provider todas las implementaciones
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviepedia_app/infrastructure/datasources/actor_moviedb_datasource.dart';
import 'package:moviepedia_app/infrastructure/repositories/actor_repository_impl.dart';

final actorsRepositoryProvider = Provider((ref) {
  return ActorRepositoryImpl(ActorMovieDbDatasource());
});
