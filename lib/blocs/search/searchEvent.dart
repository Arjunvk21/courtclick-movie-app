abstract class SearchEvent {}

class SearchMovieChanged extends SearchEvent {
  final String query;

  SearchMovieChanged(this.query);
}
