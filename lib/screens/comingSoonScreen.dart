import 'package:cached_network_image/cached_network_image.dart';
import 'package:courtclick_movie_app/blocs/comingSoon/comingSoonBloc.dart';
import 'package:courtclick_movie_app/blocs/comingSoon/comingSoonEvent.dart';
import 'package:courtclick_movie_app/blocs/comingSoon/comingSoonState.dart';
import 'package:courtclick_movie_app/core/network/dioClient.dart';
import 'package:courtclick_movie_app/customWidgets/comingSoonSkeleton.dart';
import 'package:courtclick_movie_app/customWidgets/customBottomNavBar.dart';
import 'package:courtclick_movie_app/models/movieModel.dart';
import 'package:courtclick_movie_app/repository/movieRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ComingSoonBloc(
        movieRepository: MovieRepository(dioClient: DioClient()),
      )..add(FetchComingSoonMovies()),
      child: const ComingSoonView(),
    );
  }
}

class ComingSoonView extends StatelessWidget {
  const ComingSoonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20, top: 18, bottom: 14),
                child: Text(
                  'COMING SOON',
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                    color: Color(0xFF8E8E8E),
                  ),
                ),
              ),
            ),

            Expanded(
              child: BlocBuilder<ComingSoonBloc, ComingSoonState>(
                builder: (context, state) {
                  if (state is ComingSoonLoading) {
                    return const ComingSoonSkeleton();
                  }

                  if (state is ComingSoonError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  if (state is ComingSoonEmpty) {
                    return const Center(
                      child: Text(
                        'No upcoming movies',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  if (state is ComingSoonSuccess) {
                    return _ComingSoonContent(
                      movies: state.movies,
                      isLoadingMore: state.isLoadingMore,
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: const CustomBottomNavigation(selectedIndex: 2),
    );
  }
}

class _ComingSoonNotifications extends StatelessWidget {
  const _ComingSoonNotifications();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 10, bottom: 16),
          child: Row(
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 14,
                ),
              ),

              const SizedBox(width: 7),

              const Text(
                'Notifications',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),

        Container(
          width: double.infinity,
          color: const Color(0xFF464646),
          padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8),
          child: Column(
            children: [
              _NotificationItem(
                title: 'El Chapo',
                date: 'Nov 6',
                imageUrl: 'https://image.tmdb.org/t/p/w500/placeholder.jpg',
              ),

              const SizedBox(height: 8),

              _NotificationItem(
                title: 'Peaky Blinders',
                date: 'Nov 6',
                imageUrl: 'https://image.tmdb.org/t/p/w500/placeholder.jpg',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final String title;
  final String date;
  final String imageUrl;

  const _NotificationItem({
    required this.title,
    required this.date,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      height: 65,
      color: const Color(0xFF424242),
      child: Row(
        children: [
          // Movie thumbnail
          SizedBox(
            width: 136,
            height: 65,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) {
                return Container(color: const Color(0xFF252525));
              },
              errorWidget: (context, url, error) {
                return Container(
                  color: const Color(0xFF252525),
                  child: const Icon(
                    Icons.movie,
                    color: Colors.white54,
                    size: 25,
                  ),
                );
              },
            ),
          ),

          const SizedBox(width: 17),

          // Text
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'New Arrival',
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),

                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),

                Text(
                  date,
                  style: const TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w400,
                    fontSize: 8,
                    color: Color(0xFFBDBDBD),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),
        ],
      ),
    );
  }
}

class _ComingSoonList extends StatelessWidget {
  final List<MovieModel> movies;
  final bool isLoadingMore;

  const _ComingSoonList({required this.movies, required this.isLoadingMore});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels >=
            notification.metrics.maxScrollExtent - 500) {
          context.read<ComingSoonBloc>().add(LoadMoreComingSoonMovies());
        }

        return false;
      },
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: movies.length + (isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= movies.length) {
            return const Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              ),
            );
          }

          return _ComingSoonCard(movie: movies[index]);
        },
      ),
    );
  }
}

class _ComingSoonContent extends StatelessWidget {
  final List<MovieModel> movies;
  final bool isLoadingMore;

  const _ComingSoonContent({required this.movies, required this.isLoadingMore});

  @override
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.white,
      backgroundColor: Colors.black,

      onRefresh: () async {
        final bloc = context.read<ComingSoonBloc>();

        bloc.add(RefreshComingSoonMovies());

        await bloc.stream.firstWhere(
          (state) =>
              state is ComingSoonSuccess ||
              state is ComingSoonError ||
              state is ComingSoonEmpty,
        );
      },

      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.pixels >=
              notification.metrics.maxScrollExtent - 500) {
            context.read<ComingSoonBloc>().add(LoadMoreComingSoonMovies());
          }

          return false;
        },

        child: ListView.builder(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          padding: EdgeInsets.zero,

          itemCount: movies.length + (isLoadingMore ? 1 : 0) + 1,

          itemBuilder: (context, index) {
            // Notifications
            if (index == 0) {
              return const _ComingSoonNotifications();
            }

            final movieIndex = index - 1;

            // Loading more
            if (movieIndex >= movies.length) {
              return const Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
              );
            }

            // Movie
            return _ComingSoonCard(movie: movies[movieIndex]);
          },
        ),
      ),
    );
  }
}

class _ComingSoonCard extends StatelessWidget {
  final MovieModel movie;

  const _ComingSoonCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      margin: const EdgeInsets.only(top: 14, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==========================================
          // LARGE IMAGE
          // ==========================================

          SizedBox(
            width: double.infinity,
            height: 195,
            child: movie.backdropUrl != null
                ? CachedNetworkImage(
                    imageUrl: movie.backdropUrl!,
                    fit: BoxFit.cover,
                    placeholder: (_, __) {
                      return Container(color: const Color(0xFF222222));
                    },
                    errorWidget: (_, __, ___) {
                      return Container(
                        color: const Color(0xFF222222),
                        child: const Icon(
                          Icons.movie,
                          color: Colors.white54,
                          size: 40,
                        ),
                      );
                    },
                  )
                : Container(color: const Color(0xFF222222)),
          ),

          SizedBox(
            height: 78,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _ComingSoonAction(
                  icon: Icons.notifications,
                  label: 'Remind Me',
                  onTap: () {},
                ),

                const SizedBox(width: 28),

                _ComingSoonAction(
                  icon: Icons.share,
                  label: 'Share',
                  onTap: () {},
                ),

                const SizedBox(width: 24),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              _comingText(movie.releaseDate),
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'SF Pro Display',
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              movie.title ?? 'Untitled',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w700,
                fontSize: 18.66,
                height: 13.95 / 18.66,
                letterSpacing: -0.05,
                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 7),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              movie.overview ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w400,
                fontSize: 11.14,
                height: 14.17 / 11.14,
                letterSpacing: -0.03,
                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 9),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'Steamy  •  Soapy  •  Slow Burn  •  '
              'Suspenseful  •  Teen  •  Mystery',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'SF Pro Display',
                fontSize: 9,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(height: 4),
        ],
      ),
    );
  }

  String _comingText(String? releaseDate) {
    if (releaseDate == null || releaseDate.isEmpty) {
      return 'Coming Soon';
    }

    final date = DateTime.tryParse(releaseDate);

    if (date == null) {
      return 'Coming Soon';
    }

    final month = _month(date.month);

    return 'Season 1 Coming ${month} ${date.day}';
  }

  String _month(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return months[month - 1];
  }
}

class _ComingSoonAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ComingSoonAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 52,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 25),

            const SizedBox(height: 5),

            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'SF Pro Display',
                fontSize: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
