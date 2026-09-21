import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DashboardSkeleton extends StatelessWidget {
  const DashboardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero skeleton
          _HeroSkeleton(),

          const SizedBox(height: 25),

          // Previews
          const _SectionTitleSkeleton(),

          const SizedBox(height: 15),

          SizedBox(
            height: 102,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 16),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (_, index) {
                return const Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: _CircleSkeleton(),
                );
              },
            ),
          ),

          const SizedBox(height: 25),

          // Movie sections
          const _MovieSectionSkeleton(),
          const _MovieSectionSkeleton(),
          const _MovieSectionSkeleton(),
          const _MovieSectionSkeleton(),
        ],
      ),
    );
  }
}

class _HeroSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _ShimmerBox(
      width: double.infinity,
      height: 415,
      borderRadius: BorderRadius.zero,
    );
  }
}

class _SectionTitleSkeleton extends StatelessWidget {
  const _SectionTitleSkeleton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: _ShimmerBox(
        width: 150,
        height: 20,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class _CircleSkeleton extends StatelessWidget {
  const _CircleSkeleton();

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: _ShimmerBox(
        width: 102,
        height: 102,
        borderRadius: BorderRadius.zero,
      ),
    );
  }
}

class _MovieSectionSkeleton extends StatelessWidget {
  const _MovieSectionSkeleton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: _ShimmerBox(
              width: 145,
              height: 14,
              borderRadius: BorderRadius.circular(3),
            ),
          ),

          const SizedBox(height: 8),

          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 16),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (_, index) {
                return const Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: _MovieCardSkeleton(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieCardSkeleton extends StatelessWidget {
  const _MovieCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return _ShimmerBox(
      width: 100,
      height: 150,
      borderRadius: BorderRadius.circular(2),
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;

  const _ShimmerBox({
    required this.width,
    required this.height,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF202020),
      highlightColor: const Color(0xFF383838),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xFF202020),
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}
