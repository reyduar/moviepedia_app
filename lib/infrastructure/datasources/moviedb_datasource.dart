import 'package:dio/dio.dart';
import 'package:moviepedia_app/config/constants/environment.dart';
import 'package:moviepedia_app/domain/datasources/movies_datasource.dart';
import '../../domain/entities/entities.dart';
import '../mappers/mappers.dart';
import '../models/models.dart';

class MoviedbDatasource extends MovieDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: Environment.apiUrl,
    queryParameters: {
      'api_key': Environment.dbkey,
      'language': 'es-MX',
    },
  ));

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final moviedbResponse = MovieDbResponse.fromJson(json);
    final movies = moviedbResponse.results
        .where((item) => item.posterPath != 'no-poster')
        .map((item) => MovieMapper.movieDBToEntity(item))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getMoviesShowtimes({int page = 1}) async {
    final response = await dio.get('/movie/now_playing', queryParameters: {
      'page': page,
    });

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getMoviesPopular({int page = 1}) async {
    final response = await dio.get('/movie/popular', queryParameters: {
      'page': page,
    });

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getMoviesTopRated({int page = 1}) async {
    final response = await dio.get('/movie/top_rated', queryParameters: {
      'page': page,
    });

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getMoviesUpcoming({int page = 1}) async {
    final response = await dio.get('/movie/upcoming', queryParameters: {
      'page': page,
    });

    return _jsonToMovies(response.data);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');
    if (response.statusCode != 200) {
      throw Exception('Error getting movie by id');
    }
    final movieDetails = MovieDetails.fromJson(response.data);

    final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails);

    return movie;
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) return [];
    final response = await dio.get('/search/movie',
        queryParameters: {'query': query, 'include_adult': true, 'page': 1});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getSimilarMovies(int movieId) async {
    final response = await dio.get('/movie/$movieId/similar');
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Video>> getYoutubeVideosById(int movieId) async {
    final response = await dio.get('/movie/$movieId/videos');
    final moviedbVideosReponse = MoviedbVideosResponse.fromJson(response.data);
    final videos = <Video>[];

    for (final moviedbVideo in moviedbVideosReponse.results) {
      if (moviedbVideo.site == 'YouTube') {
        final video = VideoMapper.moviedbVideoToEntity(moviedbVideo);
        videos.add(video);
      }
    }

    return videos;
  }
}
