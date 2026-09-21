import 'package:courtclick_movie_app/blocs/search/searchBloc.dart';
import 'package:courtclick_movie_app/blocs/search/searchEvent.dart';
import 'package:courtclick_movie_app/blocs/search/searchState.dart';
import 'package:courtclick_movie_app/core/network/dioClient.dart';
import 'package:courtclick_movie_app/models/movieModel.dart';
import 'package:courtclick_movie_app/repository/movieRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          SearchBloc(movieRepository: MovieRepository(dioClient: DioClient())),
      child: const SearchView(),
    );
  }
}

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Movies')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                context.read<SearchBloc>().add(SearchMovieChanged(value));
              },
              decoration: InputDecoration(
                hintText: 'Search movies...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchInitial) {
                    return const Center(child: Text('Search for a movie'));
                  }

                  if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is SearchEmpty) {
                    return const Center(child: Text('No movies found'));
                  }

                  if (state is SearchError) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Something went wrong'),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {
                              // Search will be triggered again
                              // when the user types.
                            },
                            child: const Text('Try Again'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is SearchSuccess) {
                    return _SearchResults(movies: state.movies);
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchResults extends StatelessWidget {
  final List<MovieModel> movies;

  const _SearchResults({required this.movies});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _MoviePoster(movie: movie),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title ?? 'Unknown',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(movie.releaseDate ?? 'Unknown date'),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        const Icon(Icons.star, size: 18),
                        const SizedBox(width: 4),
                        Text(movie.voteAverage.toStringAsFixed(1)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final MovieModel movie;

  const _MoviePoster({required this.movie});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      height: 120,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: movie.posterUrl != null
            ? Image.network(
                movie.posterUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.movie);
                },
              )
            : const Icon(Icons.movie),
      ),
    );
  }
}
