import 'package:courtclick_movie_app/models/movieModel.dart';

class MoviePageResponse {
  final int page;
  final int totalPages;
  final int totalResults;
  final List<MovieModel> results;

  MoviePageResponse({
    required this.page,
    required this.totalPages,
    required this.totalResults,
    required this.results,
  });

  factory MoviePageResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> results = json['results'] ?? [];

    return MoviePageResponse(
      page: json['page'] ?? 1,
      totalPages: json['total_pages'] ?? 1,
      totalResults: json['total_results'] ?? 0,
      results: results
          .map((movie) => MovieModel.fromJson(movie as Map<String, dynamic>))
          .toList(),
    );
  }
}
