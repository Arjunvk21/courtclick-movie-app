import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ComingSoonSkeleton extends StatelessWidget {
  const ComingSoonSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: EdgeInsets.zero,
      itemCount: 4,
      itemBuilder: (context, index) {
        return const _ComingSoonSkeletonCard();
      },
    );
  }
}

class _ComingSoonSkeletonCard extends StatelessWidget {
  const _ComingSoonSkeletonCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      margin: const EdgeInsets.only(top: 14, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Movie image
          _SkeletonBox(width: double.infinity, height: 195),

          // Remind Me / Share
          SizedBox(
            height: 78,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    _SkeletonCircle(size: 25),
                    SizedBox(height: 8),
                    _SkeletonBox(width: 48, height: 9),
                  ],
                ),

                const SizedBox(width: 28),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    _SkeletonCircle(size: 25),
                    SizedBox(height: 8),
                    _SkeletonBox(width: 32, height: 9),
                  ],
                ),

                const SizedBox(width: 24),
              ],
            ),
          ),

          // Release date
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: _SkeletonBox(width: 120, height: 10),
          ),

          const SizedBox(height: 10),

          // Title
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: _SkeletonBox(width: 180, height: 19),
          ),

          const SizedBox(height: 9),

          // Description
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SkeletonBox(width: double.infinity, height: 11),
                SizedBox(height: 5),
                _SkeletonBox(width: double.infinity, height: 11),
                SizedBox(height: 5),
                _SkeletonBox(width: 220, height: 11),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Genres
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: _SkeletonBox(width: 250, height: 9),
          ),

          const SizedBox(height: 4),
        ],
      ),
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  final double width;
  final double height;

  const _SkeletonBox({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF252525),
      highlightColor: const Color(0xFF414141),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xFF252525),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

class _SkeletonCircle extends StatelessWidget {
  final double size;

  const _SkeletonCircle({required this.size});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF252525),
      highlightColor: const Color(0xFF414141),
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: Color(0xFF252525),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
