import 'package:courtclick_movie_app/models/movieModel.dart';

abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardSuccess extends DashboardState {
  final List<MovieModel> trendingMovies;
  final List<MovieModel> popularMovies;
  final List<MovieModel> nowPlayingMovies;
  final List<MovieModel> topRatedMovies;

  final int trendingPage;
  final int trendingTotalPages;

  final int popularPage;
  final int popularTotalPages;

  final int nowPlayingPage;
  final int nowPlayingTotalPages;

  final int topRatedPage;
  final int topRatedTotalPages;

  final bool isLoadingTrending;
  final bool isLoadingPopular;
  final bool isLoadingNowPlaying;
  final bool isLoadingTopRated;

  DashboardSuccess({
    required this.trendingMovies,
    required this.popularMovies,
    required this.nowPlayingMovies,
    required this.topRatedMovies,
    required this.trendingPage,
    required this.trendingTotalPages,
    required this.popularPage,
    required this.popularTotalPages,
    required this.nowPlayingPage,
    required this.nowPlayingTotalPages,
    required this.topRatedPage,
    required this.topRatedTotalPages,
    this.isLoadingTrending = false,
    this.isLoadingPopular = false,
    this.isLoadingNowPlaying = false,
    this.isLoadingTopRated = false,
  });

  DashboardSuccess copyWith({
    List<MovieModel>? trendingMovies,
    List<MovieModel>? popularMovies,
    List<MovieModel>? nowPlayingMovies,
    List<MovieModel>? topRatedMovies,

    int? trendingPage,
    int? trendingTotalPages,

    int? popularPage,
    int? popularTotalPages,

    int? nowPlayingPage,
    int? nowPlayingTotalPages,

    int? topRatedPage,
    int? topRatedTotalPages,

    bool? isLoadingTrending,
    bool? isLoadingPopular,
    bool? isLoadingNowPlaying,
    bool? isLoadingTopRated,
  }) {
    return DashboardSuccess(
      trendingMovies: trendingMovies ?? this.trendingMovies,
      popularMovies: popularMovies ?? this.popularMovies,
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,

      trendingPage: trendingPage ?? this.trendingPage,
      trendingTotalPages: trendingTotalPages ?? this.trendingTotalPages,

      popularPage: popularPage ?? this.popularPage,
      popularTotalPages: popularTotalPages ?? this.popularTotalPages,

      nowPlayingPage: nowPlayingPage ?? this.nowPlayingPage,
      nowPlayingTotalPages: nowPlayingTotalPages ?? this.nowPlayingTotalPages,

      topRatedPage: topRatedPage ?? this.topRatedPage,
      topRatedTotalPages: topRatedTotalPages ?? this.topRatedTotalPages,

      isLoadingTrending: isLoadingTrending ?? this.isLoadingTrending,

      isLoadingPopular: isLoadingPopular ?? this.isLoadingPopular,

      isLoadingNowPlaying: isLoadingNowPlaying ?? this.isLoadingNowPlaying,

      isLoadingTopRated: isLoadingTopRated ?? this.isLoadingTopRated,
    );
  }
}

class DashboardEmpty extends DashboardState {}

class DashboardError extends DashboardState {
  final String message;

  DashboardError(this.message);
}
