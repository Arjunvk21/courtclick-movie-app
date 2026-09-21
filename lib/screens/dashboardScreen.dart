import 'package:cached_network_image/cached_network_image.dart';
import 'package:courtclick_movie_app/blocs/dashboard/dashboardBloc.dart';
import 'package:courtclick_movie_app/blocs/dashboard/dashboardEvent.dart';
import 'package:courtclick_movie_app/blocs/dashboard/dashboardState.dart';
import 'package:courtclick_movie_app/core/network/dioClient.dart';
import 'package:courtclick_movie_app/customWidgets/customBottomNavBar.dart';
import 'package:courtclick_movie_app/customWidgets/dashboardSkeleton.dart';
import 'package:courtclick_movie_app/models/movieModel.dart';
import 'package:courtclick_movie_app/repository/movieRepository.dart';
import 'package:courtclick_movie_app/screens/searchScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardBloc(
        movieRepository: MovieRepository(dioClient: DioClient()),
      )..add(FetchDashboardMovies()),
      child: const DashboardView(),
    );
  }
}

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int selectedBottomIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,

      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardInitial || state is DashboardLoading) {
            return const DashboardSkeleton();
          }

          if (state is DashboardError) {
            return _ErrorView(
              onRetry: () {
                context.read<DashboardBloc>().add(FetchDashboardMovies());
              },
            );
          }

          if (state is DashboardEmpty) {
            return const Center(
              child: Text(
                'No movies available',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          if (state is DashboardSuccess) {
            return _HomeContent(state: state);
          }

          return const SizedBox();
        },
      ),

      bottomNavigationBar: const CustomBottomNavigation(selectedIndex: 0),
    );
  }
}

class _HomeContent extends StatelessWidget {
  final DashboardSuccess state;

  const _HomeContent({required this.state});

  @override
  Widget build(BuildContext context) {
    final heroMovie = state.trendingMovies.isNotEmpty
        ? state.trendingMovies.first
        : state.popularMovies.isNotEmpty
        ? state.popularMovies.first
        : null;

    return RefreshIndicator(
      color: Colors.white,
      backgroundColor: Colors.black,
      onRefresh: () async {
        context.read<DashboardBloc>().add(FetchDashboardMovies());
      },
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          // =========================
          // HEADER
          // =========================

          // SliverToBoxAdapter(
          //   child: Padding(
          //     padding: const EdgeInsets.only(
          //       top: 45,
          //       left: 38,
          //       right: 20,
          //       bottom: 8,
          //     ),
          //     child: const Text(
          //       'HOME',
          //       style: TextStyle(
          //         color: Color(0xFF8E8E8E),
          //         fontSize: 26,
          //         fontWeight: FontWeight.w400,
          //         letterSpacing: 0.2,
          //       ),
          //     ),
          //   ),
          // ),
          if (heroMovie != null) ...[
            SliverToBoxAdapter(child: HeroMovie(movie: heroMovie)),

            const SliverToBoxAdapter(child: HeroActions()),
          ],

          SliverToBoxAdapter(
            child: PreviewSection(
              movies: state.trendingMovies.take(5).toList(),
            ),
          ),

          SliverToBoxAdapter(
            child: MovieSection(
              title: 'Continue Watching for Emanalo',
              movies: state.popularMovies,
              cardWidth: 108,
              cardHeight: 150,
            ),
          ),

          SliverToBoxAdapter(
            child: MovieSection(
              title: 'Popular on Netflix',
              movies: state.popularMovies,
              cardWidth: 100,
              cardHeight: 150,
              isLoadingMore: state.isLoadingPopular,
              onLoadMore: () {
                context.read<DashboardBloc>().add(LoadMorePopular());
              },
            ),
          ),

          SliverToBoxAdapter(
            child: MovieSection(
              title: 'Trending Now',
              movies: state.trendingMovies,
              cardWidth: 100,
              cardHeight: 150,
              isLoadingMore: state.isLoadingTrending,
              onLoadMore: () {
                context.read<DashboardBloc>().add(LoadMoreTrending());
              },
            ),
          ),

          SliverToBoxAdapter(
            child: MovieSection(
              title: 'Top 10 in Nigeria Today',
              movies: state.topRatedMovies,
              cardWidth: 100,
              cardHeight: 150,
              showTop10: true,
              isLoadingMore: state.isLoadingTopRated,
              onLoadMore: () {
                context.read<DashboardBloc>().add(LoadMoreTopRated());
              },
            ),
          ),

          SliverToBoxAdapter(
            child: MovieSection(
              title: 'My List',
              movies: state.popularMovies,
              cardWidth: 100,
              cardHeight: 150,
            ),
          ),

          SliverToBoxAdapter(
            child: MovieSection(
              title: 'African Movies',
              movies: state.nowPlayingMovies,
              cardWidth: 100,
              cardHeight: 150,
              isLoadingMore: state.isLoadingNowPlaying,
              onLoadMore: () {
                context.read<DashboardBloc>().add(LoadMoreNowPlaying());
              },
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 90)),
        ],
      ),
    );
  }
}

class HeroActions extends StatelessWidget {
  const HeroActions({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Stack(
        children: [
          // My List
          const Positioned(
            left: 54,
            top: 0,
            child: _HeroAction(icon: Icons.add, label: 'My List'),
          ),

          // Play
          Positioned(
            left: 137,
            top: 0,
            child: Container(
              width: 110.625,
              height: 45,
              decoration: BoxDecoration(
                color: const Color(0xFFC4C4C4),
                borderRadius: BorderRadius.circular(5.63),
              ),
              child: Stack(
                children: [
                  // PLAY ICON
                  const Positioned(
                    left: 7,
                    top: 5,
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.black,
                      size: 36,
                    ),
                  ),

                  // PLAY TEXT
                  const Positioned(
                    left: 50,
                    top: 7,
                    child: Text(
                      'Play',
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w600,
                        fontSize: 20.46,
                        height: 30 / 20.46,
                        letterSpacing: -0.06,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Info
          const Positioned(left: 289, top: 0, child: _InfoAction()),
        ],
      ),
    );
  }
}

class HeroMovie extends StatelessWidget {
  final MovieModel movie;

  const HeroMovie({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 415,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned(
            top: 0,
            left: -24.52,
            width: 424.0463,
            height: 415,
            child: movie.backdropUrl != null
                ? CachedNetworkImage(
                    imageUrl: movie.backdropUrl!,
                    width: 424.0463,
                    height: 415,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    errorWidget: (context, url, error) {
                      return Container(color: const Color(0xFF151515));
                    },
                  )
                : Container(color: const Color(0xFF151515)),
          ),

          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x15000000),
                    Color(0x22000000),
                    Color(0x70000000),
                    Colors.black,
                  ],
                  stops: [0.0, 0.35, 0.72, 1.0],
                ),
              ),
            ),
          ),

          Positioned(
            top: 35,
            left: 3,
            right: 15,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Netflix logo
                SvgPicture.asset(
                  'assets/images/logos_netflix-icon.svg',
                  width: 53,
                  height: 57,
                  fit: BoxFit.contain,
                ),

                const SizedBox(width: 10),

                // TV Shows
                const Text(
                  'TV Shows',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w400,
                    fontSize: 17.2,
                    height: 30.45 / 17.2,
                    letterSpacing: 0.76,
                    color: Colors.white,
                  ),
                ),

                const Spacer(),

                // Movies
                const Text(
                  'Movies',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w400,
                    fontSize: 17.2,
                    height: 30.45 / 17.2,
                    letterSpacing: 0.76,
                    color: Colors.white,
                  ),
                ),

                const Spacer(),

                // My List
                const Text(
                  'My List',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w400,
                    fontSize: 17.2,
                    height: 30.45 / 17.2,
                    letterSpacing: 0.76,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // =========================================================
          // RANK
          // =========================================================
          const Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.looks_3_outlined, color: Colors.white, size: 16),
                  SizedBox(width: 6),
                  Text(
                    '#2 in Nigeria Today',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroAction extends StatelessWidget {
  final IconData icon;
  final String label;

  const _HeroAction({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 41,
      height: 45,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Icon(
              icon,
              color: Colors.white,
              size: 24, // KEEP 24
            ),
          ),

          Positioned(
            top: 24,
            left: -10,
            right: -10,
            child: Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.visible,
              style: const TextStyle(
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w400,
                fontSize: 13.64,
                height: 20 / 13.64,
                letterSpacing: -0.04,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoAction extends StatelessWidget {
  const _InfoAction();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 45,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Icon(
              Icons.info_outline,
              color: Colors.white,
              size: 24, // KEEP 24
            ),
          ),

          const Positioned(
            top: 24,
            left: -10,
            right: -10,
            child: Text(
              'Info',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.visible,
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w400,
                fontSize: 13.64,
                height: 20 / 13.64,
                letterSpacing: -0.04,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PreviewSection extends StatelessWidget {
  final List<MovieModel> movies;

  const PreviewSection({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 28, bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              'Previews',
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

          const SizedBox(height: 27),

          SizedBox(
            height: 102,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 16),
              physics: const BouncingScrollPhysics(),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];

                return Container(
                  width: 102,
                  height: 102,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: ClipOval(
                    child: movie.posterUrl == null
                        ? Container(
                            color: const Color(0xFF202020),
                            child: const Icon(Icons.movie, color: Colors.white),
                          )
                        : CachedNetworkImage(
                            imageUrl: movie.posterUrl!,
                            width: 102,
                            height: 102,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) {
                              return Container(
                                color: const Color(0xFF202020),
                                child: const Icon(
                                  Icons.movie,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MovieSection extends StatelessWidget {
  final String title;
  final List<MovieModel> movies;
  final double cardWidth;
  final double cardHeight;
  final bool showTop10;
  final bool isLoadingMore;
  final VoidCallback onLoadMore;

  const MovieSection({
    super.key,
    required this.title,
    required this.movies,
    this.cardWidth = 100,
    this.cardHeight = 150,
    this.showTop10 = false,
    this.isLoadingMore = false,
    this.onLoadMore = _emptyCallback,
  });
  static void _emptyCallback() {}
  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 7),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          SizedBox(
            height: cardHeight,
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollUpdateNotification ||
                    notification is ScrollEndNotification) {
                  final position = notification.metrics;

                  if (position.pixels >= position.maxScrollExtent - 300) {
                    onLoadMore();
                  }
                }

                return false;
              },
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 16),
                physics: const BouncingScrollPhysics(),
                itemCount: movies.length + (isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index >= movies.length) {
                    return SizedBox(
                      width: 50,
                      child: Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }

                  return MovieCard(
                    movie: movies[index],
                    width: cardWidth,
                    height: cardHeight,
                    showTop10: showTop10,
                    rank: index + 1,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final MovieModel movie;
  final double width;
  final double height;
  final bool showTop10;
  final int rank;

  const MovieCard({
    super.key,
    required this.movie,
    required this.width,
    required this.height,
    this.showTop10 = false,
    this.rank = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.only(right: 5),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: movie.posterUrl == null
                ? Container(
                    width: width,
                    height: height,
                    color: const Color(0xFF202020),
                    child: const Icon(Icons.movie, color: Colors.white),
                  )
                : CachedNetworkImage(
                    imageUrl: movie.posterUrl!,
                    width: width,
                    height: height,
                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return Container(color: const Color(0xFF202020));
                    },
                    errorWidget: (context, url, error) {
                      return Container(
                        color: const Color(0xFF202020),
                        child: const Icon(Icons.movie, color: Colors.white),
                      );
                    },
                  ),
          ),

          if (showTop10)
            Positioned(
              left: 2,
              bottom: 0,
              child: Container(
                width: 24,
                height: 35,
                color: Colors.black87,
                alignment: Alignment.center,
                child: Text(
                  '$rank',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const _BottomNavigation({
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      decoration: const BoxDecoration(color: Color(0xFF050505)),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _BottomItem(
              icon: Icons.home_outlined,
              activeIcon: Icons.home,
              label: 'Home',
              selected: selectedIndex == 0,
              onTap: () => onChanged(0),
            ),

            _BottomItem(
              icon: Icons.search,
              activeIcon: Icons.search,
              label: 'Search',
              selected: selectedIndex == 1,
              onTap: () => onChanged(1),
            ),

            _BottomItem(
              icon: Icons.video_library_outlined,
              activeIcon: Icons.video_library,
              label: 'Coming Soon',
              selected: selectedIndex == 2,
              onTap: () => onChanged(2),
            ),

            _BottomItem(
              icon: Icons.download_outlined,
              activeIcon: Icons.download,
              label: 'Downloads',
              selected: selectedIndex == 3,
              onTap: () => onChanged(3),
            ),

            _BottomItem(
              icon: Icons.person_outline,
              activeIcon: Icons.person,
              label: 'My Netflix',
              selected: selectedIndex == 4,
              onTap: () => onChanged(4),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final VoidCallback onRetry;

  const _ErrorView({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 50),

            const SizedBox(height: 16),

            const Text(
              'Something went wrong',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Unable to load movies. Please try again.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: const Text(
                'Retry',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _BottomItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            selected ? activeIcon : icon,
            size: 18,
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
      ),
    );
  }
}

class LastWatchedSection extends StatelessWidget {
  final List<MovieModel> movies;

  const LastWatchedSection({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16, bottom: 8),
            child: Text(
              'Continue Watching for Emanalo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          SizedBox(
            height: 147,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 16),
              physics: const BouncingScrollPhysics(),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return LastWatchedCard(movie: movies[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class LastWatchedCard extends StatelessWidget {
  final MovieModel movie;

  const LastWatchedCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 187,
      height: 147,
      margin: const EdgeInsets.only(right: 13),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(3),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          SizedBox(
            width: 187,
            height: 88,
            child: movie.backdropUrl != null
                ? CachedNetworkImage(
                    imageUrl: movie.backdropUrl!,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    errorWidget: (context, url, error) {
                      return Container(color: const Color(0xFF202020));
                    },
                  )
                : Container(color: const Color(0xFF202020)),
          ),

          Expanded(
            child: Container(
              color: const Color(0xFF111111),
              child: Row(
                children: [
                  const SizedBox(width: 22),

                  // INFO
                  const Icon(Icons.info_outline, color: Colors.white, size: 39),

                  const Spacer(),

                  // MORE
                  const Icon(Icons.more_vert, color: Colors.white, size: 31),

                  const SizedBox(width: 28),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
