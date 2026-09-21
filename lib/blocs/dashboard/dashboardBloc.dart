import 'package:courtclick_movie_app/blocs/dashboard/dashboardEvent.dart';
import 'package:courtclick_movie_app/blocs/dashboard/dashboardState.dart';
import 'package:courtclick_movie_app/repository/movieRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final MovieRepository movieRepository;

  DashboardBloc({required this.movieRepository}) : super(DashboardInitial()) {
    on<FetchDashboardMovies>(_fetchDashboardMovies);

    on<LoadMoreTrending>(_loadMoreTrending);
    on<LoadMorePopular>(_loadMorePopular);
    on<LoadMoreNowPlaying>(_loadMoreNowPlaying);
    on<LoadMoreTopRated>(_loadMoreTopRated);
  }

  // ============================================================
  // INITIAL LOAD
  // ============================================================

  Future<void> _fetchDashboardMovies(
    FetchDashboardMovies event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());

    try {
      final results = await Future.wait([
        movieRepository.getTrendingMovies(page: 1),
        movieRepository.getPopularMovies(page: 1),
        movieRepository.getNowPlayingMovies(page: 1),
        movieRepository.getTopRatedMovies(page: 1),
      ]);

      final trendingResponse = results[0];
      final popularResponse = results[1];
      final nowPlayingResponse = results[2];
      final topRatedResponse = results[3];

      if (trendingResponse.results.isEmpty &&
          popularResponse.results.isEmpty &&
          nowPlayingResponse.results.isEmpty &&
          topRatedResponse.results.isEmpty) {
        emit(DashboardEmpty());
        return;
      }

      emit(
        DashboardSuccess(
          trendingMovies: trendingResponse.results,
          popularMovies: popularResponse.results,
          nowPlayingMovies: nowPlayingResponse.results,
          topRatedMovies: topRatedResponse.results,

          trendingPage: trendingResponse.page,
          trendingTotalPages: trendingResponse.totalPages,

          popularPage: popularResponse.page,
          popularTotalPages: popularResponse.totalPages,

          nowPlayingPage: nowPlayingResponse.page,
          nowPlayingTotalPages: nowPlayingResponse.totalPages,

          topRatedPage: topRatedResponse.page,
          topRatedTotalPages: topRatedResponse.totalPages,
        ),
      );
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }

  // ============================================================
  // LOAD MORE TRENDING
  // ============================================================

  Future<void> _loadMoreTrending(
    LoadMoreTrending event,
    Emitter<DashboardState> emit,
  ) async {
    final currentState = state;

    if (currentState is! DashboardSuccess) {
      return;
    }

    if (currentState.isLoadingTrending) {
      return;
    }

    if (currentState.trendingPage >= currentState.trendingTotalPages) {
      return;
    }

    emit(currentState.copyWith(isLoadingTrending: true));

    try {
      final nextPage = currentState.trendingPage + 1;

      final response = await movieRepository.getTrendingMovies(page: nextPage);

      emit(
        currentState.copyWith(
          trendingMovies: [...currentState.trendingMovies, ...response.results],
          trendingPage: response.page,
          trendingTotalPages: response.totalPages,
          isLoadingTrending: false,
        ),
      );
    } catch (e) {
      emit(currentState.copyWith(isLoadingTrending: false));
    }
  }

  // ============================================================
  // LOAD MORE POPULAR
  // ============================================================

  Future<void> _loadMorePopular(
    LoadMorePopular event,
    Emitter<DashboardState> emit,
  ) async {
    final currentState = state;

    if (currentState is! DashboardSuccess) {
      return;
    }

    if (currentState.isLoadingPopular) {
      return;
    }

    if (currentState.popularPage >= currentState.popularTotalPages) {
      return;
    }

    emit(currentState.copyWith(isLoadingPopular: true));

    try {
      final nextPage = currentState.popularPage + 1;

      final response = await movieRepository.getPopularMovies(page: nextPage);

      emit(
        currentState.copyWith(
          popularMovies: [...currentState.popularMovies, ...response.results],
          popularPage: response.page,
          popularTotalPages: response.totalPages,
          isLoadingPopular: false,
        ),
      );
    } catch (e) {
      emit(currentState.copyWith(isLoadingPopular: false));
    }
  }

  // ============================================================
  // LOAD MORE NOW PLAYING
  // ============================================================

  Future<void> _loadMoreNowPlaying(
    LoadMoreNowPlaying event,
    Emitter<DashboardState> emit,
  ) async {
    final currentState = state;

    if (currentState is! DashboardSuccess) {
      return;
    }

    if (currentState.isLoadingNowPlaying) {
      return;
    }

    if (currentState.nowPlayingPage >= currentState.nowPlayingTotalPages) {
      return;
    }

    emit(currentState.copyWith(isLoadingNowPlaying: true));

    try {
      final nextPage = currentState.nowPlayingPage + 1;

      final response = await movieRepository.getNowPlayingMovies(
        page: nextPage,
      );

      emit(
        currentState.copyWith(
          nowPlayingMovies: [
            ...currentState.nowPlayingMovies,
            ...response.results,
          ],
          nowPlayingPage: response.page,
          nowPlayingTotalPages: response.totalPages,
          isLoadingNowPlaying: false,
        ),
      );
    } catch (e) {
      emit(currentState.copyWith(isLoadingNowPlaying: false));
    }
  }

  // ============================================================
  // LOAD MORE TOP RATED
  // ============================================================

  Future<void> _loadMoreTopRated(
    LoadMoreTopRated event,
    Emitter<DashboardState> emit,
  ) async {
    final currentState = state;

    if (currentState is! DashboardSuccess) {
      return;
    }

    if (currentState.isLoadingTopRated) {
      return;
    }

    if (currentState.topRatedPage >= currentState.topRatedTotalPages) {
      return;
    }

    emit(currentState.copyWith(isLoadingTopRated: true));

    try {
      final nextPage = currentState.topRatedPage + 1;

      final response = await movieRepository.getTopRatedMovies(page: nextPage);

      emit(
        currentState.copyWith(
          topRatedMovies: [...currentState.topRatedMovies, ...response.results],
          topRatedPage: response.page,
          topRatedTotalPages: response.totalPages,
          isLoadingTopRated: false,
        ),
      );
    } catch (e) {
      emit(currentState.copyWith(isLoadingTopRated: false));
    }
  }
}
