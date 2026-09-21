import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SearchSkeleton extends StatelessWidget {
  final bool showTopSearches;

  const SearchSkeleton({super.key, this.showTopSearches = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTopSearches) ...[
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 20, bottom: 17),
            child: _SkeletonBox(width: 145, height: 27),
          ),

          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 7,
              itemBuilder: (context, index) {
                return const _TopSearchSkeletonRow();
              },
            ),
          ),
        ] else ...[
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 8,
              itemBuilder: (context, index) {
                return const _SearchResultSkeletonRow();
              },
            ),
          ),
        ],
      ],
    );
  }
}

class _TopSearchSkeletonRow extends StatelessWidget {
  const _TopSearchSkeletonRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 76,
      decoration: const BoxDecoration(
        color: Color(0xFF464646),
        border: Border(bottom: BorderSide(color: Colors.black, width: 3)),
      ),
      child: Row(
        children: [
          const _SkeletonBox(width: 157, height: 76),

          const SizedBox(width: 20),

          const _SkeletonBox(width: 110, height: 16),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: _SkeletonBox(
              width: 30,
              height: 30,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchResultSkeletonRow extends StatelessWidget {
  const _SearchResultSkeletonRow();

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
          const _SkeletonBox(width: 157, height: 83),

          const SizedBox(width: 20),

          const _SkeletonBox(width: 120, height: 16),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: _SkeletonBox(
              width: 30,
              height: 30,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ],
      ),
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;

  const _SkeletonBox({
    required this.width,
    required this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(2)),
  });

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
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}
