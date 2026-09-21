import 'package:cached_network_image/cached_network_image.dart';
import 'package:courtclick_movie_app/blocs/search/searchBloc.dart';
import 'package:courtclick_movie_app/blocs/search/searchEvent.dart';
import 'package:courtclick_movie_app/blocs/search/searchState.dart';
import 'package:courtclick_movie_app/core/network/dioClient.dart';
import 'package:courtclick_movie_app/customWidgets/customBottomNavBar.dart';
import 'package:courtclick_movie_app/models/movieModel.dart';
import 'package:courtclick_movie_app/repository/movieRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

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

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  List<MovieModel?>? _topSearchMovies;
  bool _loadingTopSearches = false;

  Future<void> _loadTopSearches() async {
    setState(() {
      _loadingTopSearches = true;
    });

    final repository = MovieRepository(dioClient: DioClient());

    const titles = [
      'Citation',
      'Oloture',
      'The Setup',
      'Breaking Bad',
      'Ozark',
      'The Governor',
      'Your Excellency',
    ];

    try {
      final responses = await Future.wait(
        titles.map((title) => repository.searchMovies(title, page: 1)),
      );

      if (!mounted) return;

      setState(() {
        _topSearchMovies = responses.map((response) {
          if (response.results.isEmpty) {
            return null;
          }

          return response.results.firstWhere(
            (movie) => movie.posterPath != null || movie.backdropPath != null,
            orElse: () => response.results.first,
          );
        }).toList();

        _loadingTopSearches = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _topSearchMovies = [];
        _loadingTopSearches = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _loadTopSearches();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // ============================================
            // SEARCH BAR
            // ============================================

            Padding(
              padding: const EdgeInsets.only(top: 44),
              child: Container(
                width: double.infinity,
                height: 57,
                color: const Color(0xFF484848),
                child: Row(
                  children: [
                    const SizedBox(width: 27),

                    const Icon(
                      Icons.search,
                      color: Color(0xFFBDBDBD),
                      size: 25,
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: TextField(
                        controller: _searchController,

                        onChanged: (value) {
                          setState(() {});

                          context.read<SearchBloc>().add(
                            SearchMovieChanged(value),
                          );
                        },

                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),

                        cursorColor: Colors.white,

                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isCollapsed: true,
                          hintText: 'Search for a show, movie, genre, e.t.c.',
                          hintStyle: TextStyle(
                            color: Color(0xFFC7C7C7),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),

                    // CLEAR
                    if (_searchController.text.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          _searchController.clear();

                          context.read<SearchBloc>().add(
                            SearchMovieChanged(''),
                          );

                          setState(() {});

                          _loadTopSearches();
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Icon(
                            Icons.close,
                            color: Color(0xFFC7C7C7),
                            size: 21,
                          ),
                        ),
                      ),

                    // MICROPHONE
                    SvgPicture.asset(
                      'assets/images/mic_icon.svg',
                      width: 24,
                      height: 24,
                    ),

                    const SizedBox(width: 27),
                  ],
                ),
              ),
            ),

            // ============================================
            // CONTENT
            // ============================================
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }

                  if (state is SearchError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  if (state is SearchEmpty) {
                    return const Center(
                      child: Text(
                        'No results found',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    );
                  }

                  if (state is SearchSuccess) {
                    return _SearchResults(movies: state.movies);
                  }

                  if (_loadingTopSearches) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }

                  return _TopSearches(movies: _topSearchMovies ?? []);
                },
              ),
            ),
          ],
        ),
      ),

      // ============================================
      // BOTTOM NAVIGATION
      // ============================================
      bottomNavigationBar: const CustomBottomNavigation(selectedIndex: 1),
    );
  }
}

class _TopSearches extends StatelessWidget {
  final List<MovieModel?> movies;

  const _TopSearches({required this.movies});

  static const List<String> titles = [
    'Citation',
    'Oloture',
    'The Setup',
    'Breaking Bad',
    'Ozark',
    'The Governor',
    'Your Excellency',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10, top: 20, bottom: 17),
          child: Text(
            'Top Searches',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'SF Pro Display',
              fontWeight: FontWeight.w700,
              fontSize: 26.75,
              height: 20 / 26.75,
              letterSpacing: -0.07,
              color: Colors.white,
            ),
          ),
        ),

        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: titles.length,
            itemBuilder: (context, index) {
              return _TopSearchRow(
                title: titles[index],
                movie: index < movies.length ? movies[index] : null,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _TopSearchRow extends StatelessWidget {
  final String title;
  final MovieModel? movie;

  const _TopSearchRow({required this.title, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 375,
      height: 76,
      child: Container(
        width: 375,
        height: 76,
        decoration: const BoxDecoration(
          color: Color(0xFF464646),
          border: Border(bottom: BorderSide(color: Colors.black, width: 3)),
        ),
        child: Row(
          children: [
            // Movie image
            SizedBox(
              width: 157,
              height: 76,
              child: _TopSearchImage(movie: movie),
            ),

            const SizedBox(width: 20),

            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(
                Icons.play_circle_outline,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopSearchImage extends StatelessWidget {
  final MovieModel? movie;

  const _TopSearchImage({required this.movie});

  @override
  Widget build(BuildContext context) {
    final imageUrl = movie?.posterUrl ?? movie?.backdropUrl;

    if (imageUrl == null || imageUrl.isEmpty) {
      return _placeholder();
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: 157,
      height: 76,
      fit: BoxFit.cover,

      placeholder: (context, url) {
        return _placeholder();
      },

      errorWidget: (context, url, error) {
        // If poster failed, try backdrop.
        if (movie?.backdropUrl != null && movie!.backdropUrl != url) {
          return CachedNetworkImage(
            imageUrl: movie!.backdropUrl!,
            width: 157,
            height: 76,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) {
              return _placeholder();
            },
          );
        }

        return _placeholder();
      },
    );
  }

  Widget _placeholder() {
    return Container(
      width: 157,
      height: 76,
      color: const Color(0xFF252525),
      child: const Icon(Icons.movie, color: Colors.white54, size: 30),
    );
  }
}

class _SearchResults extends StatelessWidget {
  final List<MovieModel> movies;

  const _SearchResults({required this.movies});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return _SearchResultRow(movie: movies[index]);
      },
    );
  }
}

class _SearchResultRow extends StatelessWidget {
  final MovieModel movie;

  const _SearchResultRow({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 86,
      decoration: const BoxDecoration(
        color: Color(0xFF464646),
        border: Border(bottom: BorderSide(color: Colors.black, width: 3)),
      ),
      child: Row(
        children: [
          // IMAGE
          SizedBox(
            width: 157,
            height: 83,
            child: movie.backdropUrl != null
                ? CachedNetworkImage(
                    imageUrl: movie.backdropUrl!,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) {
                      return const Icon(Icons.movie, color: Colors.white54);
                    },
                  )
                : const Icon(Icons.movie, color: Colors.white54),
          ),

          const SizedBox(width: 20),

          // TITLE
          Expanded(
            child: Text(
              movie.title ?? 'Unknown',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          // PLAY
          const Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.play_circle_outline,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchBottomNavigation extends StatelessWidget {
  const _SearchBottomNavigation();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      color: const Color(0xFF111111),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _SearchNavItem(icon: Icons.home_outlined, label: 'Home'),

            _SearchNavItem(icon: Icons.search, label: 'Search', selected: true),

            _SearchNavItem(
              icon: Icons.video_library_outlined,
              label: 'Coming Soon',
            ),

            _SearchNavItem(icon: Icons.download_outlined, label: 'Downloads'),

            _SearchNavItem(icon: Icons.menu, label: 'More'),
          ],
        ),
      ),
    );
  }
}

class _SearchNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;

  const _SearchNavItem({
    required this.icon,
    required this.label,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 22,
          color: selected ? Colors.white : const Color(0xFF777777),
        ),

        const SizedBox(height: 2),

        Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : const Color(0xFF777777),
            fontSize: 7,
          ),
        ),
      ],
    );
  }
}
