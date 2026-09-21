import 'package:courtclick_movie_app/blocs/dashboard/dashboardEvent.dart';
import 'package:courtclick_movie_app/blocs/dashboard/dashboardState.dart';
import 'package:courtclick_movie_app/repository/movieRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final MovieRepository movieRepository;

  DashboardBloc({required this.movieRepository}) : super(DashboardInitial()) {
    on<FetchDashboardMovies>(_fetchDashboardMovies);
  }

  Future<void> _fetchDashboardMovies(
    FetchDashboardMovies event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());

    try {
      final results = await Future.wait([
        movieRepository.getTrendingMovies(),
        movieRepository.getPopularMovies(),
        movieRepository.getNowPlayingMovies(),
        movieRepository.getTopRatedMovies(),
      ]);

      final trendingMovies = results[0];
      final popularMovies = results[1];
      final nowPlayingMovies = results[2];
      final topRatedMovies = results[3];

      if (trendingMovies.isEmpty &&
          popularMovies.isEmpty &&
          nowPlayingMovies.isEmpty &&
          topRatedMovies.isEmpty) {
        emit(DashboardEmpty());
        return;
      }

      emit(
        DashboardSuccess(
          trendingMovies: trendingMovies,
          popularMovies: popularMovies,
          nowPlayingMovies: nowPlayingMovies,
          topRatedMovies: topRatedMovies,
        ),
      );
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }
}
