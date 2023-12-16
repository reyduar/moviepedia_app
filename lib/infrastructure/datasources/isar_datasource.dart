import 'package:isar/isar.dart';
import 'package:moviepedia_app/domain/datasources/local_storage_datasource.dart';
import 'package:moviepedia_app/domain/entities/movie.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatasource extends LocalStorageDatasource {
  late Future<Isar> db;

  IsarDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([MovieSchema],
          inspector: true, directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final isar = await db;
    final Movie? isMovieFavorite =
        await isar.movies.filter().idEqualTo(movieId).findFirst();
    return isMovieFavorite != null;
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {
    final isar = await db;
    return isar.movies.where().offset(offset).limit(limit).findAll();
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await db;
    final favoriteMovie =
        await isar.movies.filter().idEqualTo(movie.id).findFirst();
    if (favoriteMovie != null) {
      isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.isarId!));
    } else {
      isar.writeTxnSync(() => isar.movies.putSync(movie));
    }
  }
}
