import 'package:moviepedia_app/domain/datasources/local_storage_datasource.dart';
import 'package:moviepedia_app/domain/entities/movie.dart';

class IsarDatasource extends LocalStorageDatasource {
  @override
  Future<bool> isMovieFavorite(int movieId) {
    // TODO: implement isMovieFavorite
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> loadMvoies({int limit = 10, offset = 0}) {
    // TODO: implement loadMvoies
    throw UnimplementedError();
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    // TODO: implement toggleFavorite
    throw UnimplementedError();
  }
}
