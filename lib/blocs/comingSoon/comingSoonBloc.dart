import 'package:courtclick_movie_app/blocs/comingSoon/comingSoonEvent.dart';
import 'package:courtclick_movie_app/blocs/comingSoon/comingSoonState.dart';
import 'package:courtclick_movie_app/repository/movieRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComingSoonBloc
    extends Bloc<ComingSoonEvent, ComingSoonState> {
  final MovieRepository movieRepository;

  ComingSoonBloc({
    required this.movieRepository,
  }) : super(ComingSoonInitial()) {
    on<FetchComingSoonMovies>(_fetchComingSoonMovies);
    on<LoadMoreComingSoonMovies>(_loadMoreComingSoonMovies);
  }

  Future<void> _fetchComingSoonMovies(
    FetchComingSoonMovies event,
    Emitter<ComingSoonState> emit,
  ) async {
    emit(ComingSoonLoading());

    try {
      final response = await movieRepository.getUpcomingMovies(
        page: 1,
      );

      if (response.results.isEmpty) {
        emit(ComingSoonEmpty());
        return;
      }

      emit(
        ComingSoonSuccess(
          movies: response.results,
          currentPage: response.page,
          totalPages: response.totalPages,
        ),
      );
    } catch (e) {
      emit(
        ComingSoonError(
          e.toString(),
        ),
      );
    }
  }

  Future<void> _loadMoreComingSoonMovies(
    LoadMoreComingSoonMovies event,
    Emitter<ComingSoonState> emit,
  ) async {
    final currentState = state;

    if (currentState is! ComingSoonSuccess) {
      return;
    }

    if (currentState.isLoadingMore) {
      return;
    }

    if (currentState.currentPage >= currentState.totalPages) {
      return;
    }

    emit(
      ComingSoonSuccess(
        movies: currentState.movies,
        currentPage: currentState.currentPage,
        totalPages: currentState.totalPages,
        isLoadingMore: true,
      ),
    );

    try {
      final nextPage = currentState.currentPage + 1;

      final response = await movieRepository.getUpcomingMovies(
        page: nextPage,
      );

      final updatedMovies = [
        ...currentState.movies,
        ...response.results,
      ];

      emit(
        ComingSoonSuccess(
          movies: updatedMovies,
          currentPage: response.page,
          totalPages: response.totalPages,
        ),
      );
    } catch (e) {
      emit(
        ComingSoonSuccess(
          movies: currentState.movies,
          currentPage: currentState.currentPage,
          totalPages: currentState.totalPages,
        ),
      );
    }
  }
}