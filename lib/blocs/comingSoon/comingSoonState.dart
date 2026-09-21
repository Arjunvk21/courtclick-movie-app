import 'package:courtclick_movie_app/models/movieModel.dart';

abstract class ComingSoonState {}

class ComingSoonInitial extends ComingSoonState {}

class ComingSoonLoading extends ComingSoonState {}

class ComingSoonSuccess extends ComingSoonState {
  final List<MovieModel> movies;
  final int currentPage;
  final int totalPages;
  final bool isLoadingMore;

  ComingSoonSuccess({
    required this.movies,
    required this.currentPage,
    required this.totalPages,
    this.isLoadingMore = false,
  });
}

class ComingSoonEmpty extends ComingSoonState {}

class ComingSoonError extends ComingSoonState {
  final String message;

  ComingSoonError(this.message);
}