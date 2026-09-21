import 'package:courtclick_movie_app/models/movieModel.dart';

abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardSuccess extends DashboardState {
  final List<MovieModel> trendingMovies;
  final List<MovieModel> popularMovies;
  final List<MovieModel> nowPlayingMovies;
  final List<MovieModel> topRatedMovies;

  DashboardSuccess({
    required this.trendingMovies,
    required this.popularMovies,
    required this.nowPlayingMovies,
    required this.topRatedMovies,
  });
}

class DashboardEmpty extends DashboardState {}

class DashboardError extends DashboardState {
  final String message;

  DashboardError(this.message);
}
