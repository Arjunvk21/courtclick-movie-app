import 'package:courtclick_movie_app/core/constants/apiConstants.dart';
import 'package:courtclick_movie_app/core/network/dioClient.dart';
import 'package:courtclick_movie_app/models/movieModel.dart';

class MovieRepository {
  final DioClient dioClient;

  MovieRepository({required this.dioClient});

  Future<List<MovieModel>> getPopularMovies() async {
    try {
      final response = await dioClient.dio.get(
        ApiConstants.popular,
        queryParameters: {'api_key': ApiConstants.tmdbApiKey, 'page': 1},
      );

      final List results = response.data['results'] ?? [];

      return results.map((movie) => MovieModel.fromJson(movie)).toList();
    } catch (e) {
      throw Exception('Failed to load popular movies');
    }
  }

  Future<List<MovieModel>> getTrendingMovies() async {
    try {
      final response = await dioClient.dio.get(
        ApiConstants.trending,
        queryParameters: {'api_key': ApiConstants.tmdbApiKey},
      );

      final List results = response.data['results'] ?? [];

      return results.map((movie) => MovieModel.fromJson(movie)).toList();
    } catch (e) {
      throw Exception('Failed to load trending movies');
    }
  }

  Future<List<MovieModel>> getNowPlayingMovies() async {
    try {
      final response = await dioClient.dio.get(
        ApiConstants.nowPlaying,
        queryParameters: {'api_key': ApiConstants.tmdbApiKey, 'page': 1},
      );

      final List results = response.data['results'] ?? [];

      return results.map((movie) => MovieModel.fromJson(movie)).toList();
    } catch (e) {
      throw Exception('Failed to load now playing movies');
    }
  }

  Future<List<MovieModel>> getTopRatedMovies() async {
    try {
      final response = await dioClient.dio.get(
        ApiConstants.topRated,
        queryParameters: {'api_key': ApiConstants.tmdbApiKey, 'page': 1},
      );

      final List results = response.data['results'] ?? [];

      return results.map((movie) => MovieModel.fromJson(movie)).toList();
    } catch (e) {
      throw Exception('Failed to load top rated movies');
    }
  }

  Future<List<MovieModel>> getUpcomingMovies() async {
    try {
      final response = await dioClient.dio.get(
        ApiConstants.upcoming,
        queryParameters: {'api_key': ApiConstants.tmdbApiKey, 'page': 1},
      );

      final List results = response.data['results'] ?? [];

      return results.map((movie) => MovieModel.fromJson(movie)).toList();
    } catch (e) {
      throw Exception('Failed to load upcoming movies');
    }
  }

  Future<List<MovieModel>> searchMovies(String query) async {
    try {
      final response = await dioClient.dio.get(
        ApiConstants.searchMovie,
        queryParameters: {
          'api_key': ApiConstants.tmdbApiKey,
          'query': query,
          'page': 1,
        },
      );

      final List results = response.data['results'] ?? [];

      return results.map((movie) => MovieModel.fromJson(movie)).toList();
    } catch (e) {
      throw Exception('Failed to search movies');
    }
  }
}
