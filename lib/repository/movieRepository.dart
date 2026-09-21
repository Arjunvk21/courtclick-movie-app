import 'package:courtclick_movie_app/core/constants/apiConstants.dart';
import 'package:courtclick_movie_app/core/network/dioClient.dart';
import 'package:courtclick_movie_app/models/movieModel.dart';
import 'package:courtclick_movie_app/models/moviePageResponse.dart';

class MovieRepository {
  final DioClient dioClient;

  MovieRepository({required this.dioClient});

  // ============================================================
  // POPULAR
  // ============================================================

  Future<MoviePageResponse> getPopularMovies({int page = 1}) async {
    try {
      final response = await dioClient.dio.get(
        ApiConstants.popular,
        queryParameters: {'api_key': ApiConstants.tmdbApiKey, 'page': page},
      );

      return MoviePageResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load popular movies');
    }
  }

  // ============================================================
  // TRENDING
  // ============================================================

  Future<MoviePageResponse> getTrendingMovies({int page = 1}) async {
    try {
      final response = await dioClient.dio.get(
        ApiConstants.trending,
        queryParameters: {'api_key': ApiConstants.tmdbApiKey, 'page': page},
      );

      return MoviePageResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load trending movies');
    }
  }

  // ============================================================
  // NOW PLAYING
  // ============================================================

  Future<MoviePageResponse> getNowPlayingMovies({int page = 1}) async {
    try {
      final response = await dioClient.dio.get(
        ApiConstants.nowPlaying,
        queryParameters: {'api_key': ApiConstants.tmdbApiKey, 'page': page},
      );

      return MoviePageResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load now playing movies');
    }
  }

  // ============================================================
  // TOP RATED
  // ============================================================

  Future<MoviePageResponse> getTopRatedMovies({int page = 1}) async {
    try {
      final response = await dioClient.dio.get(
        ApiConstants.topRated,
        queryParameters: {'api_key': ApiConstants.tmdbApiKey, 'page': page},
      );

      return MoviePageResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load top rated movies');
    }
  }

  // ============================================================
  // UPCOMING
  // ============================================================

  Future<MoviePageResponse> getUpcomingMovies({int page = 1}) async {
    try {
      final response = await dioClient.dio.get(
        ApiConstants.upcoming,
        queryParameters: {'api_key': ApiConstants.tmdbApiKey, 'page': page},
      );

      return MoviePageResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load upcoming movies');
    }
  }

  // ============================================================
  // SEARCH
  // ============================================================

  Future<MoviePageResponse> searchMovies(String query, {int page = 1}) async {
    try {
      final response = await dioClient.dio.get(
        ApiConstants.searchMovie,
        queryParameters: {
          'api_key': ApiConstants.tmdbApiKey,
          'query': query,
          'page': page,
        },
      );

      return MoviePageResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to search movies');
    }
  }
}
