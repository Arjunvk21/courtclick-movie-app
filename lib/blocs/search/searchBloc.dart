import 'dart:async';

import 'package:courtclick_movie_app/blocs/search/searchEvent.dart';
import 'package:courtclick_movie_app/blocs/search/searchState.dart';
import 'package:courtclick_movie_app/repository/movieRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final MovieRepository movieRepository;

  SearchBloc({required this.movieRepository}) : super(SearchInitial()) {
    on<SearchMovieChanged>(
      _searchMovie,
      transformer: _debounce(const Duration(milliseconds: 400)),
    );
  }

  EventTransformer<T> _debounce<T>(Duration duration) {
    return (events, mapper) {
      return events.debounceTime(duration).switchMap(mapper);
    };
  }

  Future<void> _searchMovie(
    SearchMovieChanged event,
    Emitter<SearchState> emit,
  ) async {
    final query = event.query.trim();

    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    try {
      final movies = await movieRepository.searchMovies(query);

      if (movies.isEmpty) {
        emit(SearchEmpty());
        return;
      }

      emit(SearchSuccess(movies));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}
