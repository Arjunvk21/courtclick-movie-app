import 'package:courtclick_movie_app/core/constants/apiConstants.dart';

class MovieModel {
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double popularity;
  final String? posterPath;
  final String? releaseDate;
  final String? title;
  final double voteAverage;
  final int voteCount;
  final String? mediaType;

  MovieModel({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
    required this.mediaType,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      adult: json['adult'] ?? false,
      backdropPath: json['backdrop_path'],
      genreIds: List<int>.from(json['genre_ids'] ?? []),
      id: json['id'] ?? 0,
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'] ?? json['original_name'],
      overview: json['overview'],
      popularity: (json['popularity'] ?? 0).toDouble(),
      posterPath: json['poster_path'],

      // Movie uses release_date.
      // TV uses first_air_date.
      releaseDate: json['release_date'] ?? json['first_air_date'],

      // Movie uses title.
      // TV uses name.
      title: json['title'] ?? json['name'],

      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
      mediaType: json['media_type'],
    );
  }

  String? get posterUrl {
    if (posterPath == null || posterPath!.isEmpty) {
      return null;
    }

    return '${ApiConstants.imageBaseUrl}$posterPath';
  }

  String? get backdropUrl {
    if (backdropPath == null || backdropPath!.isEmpty) {
      return null;
    }

    return '${ApiConstants.imageBaseUrl}$backdropPath';
  }
}
