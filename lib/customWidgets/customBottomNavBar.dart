import 'package:courtclick_movie_app/screens/comingSoonScreen.dart';
import 'package:courtclick_movie_app/screens/dashboardScreen.dart';
import 'package:courtclick_movie_app/screens/downloadsScreen.dart';
import 'package:courtclick_movie_app/screens/moreScreen.dart';
import 'package:courtclick_movie_app/screens/searchScreen.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int selectedIndex;

  const CustomBottomNavigation({super.key, required this.selectedIndex});

  void _navigate(BuildContext context, int index) {
    if (index == selectedIndex) {
      return;
    }

    Widget screen;

    switch (index) {
      case 0:
        screen = const DashboardScreen();
        break;

      case 1:
        screen = const SearchScreen();
        break;

      case 2:
        screen = const ComingSoonScreen();
        break;

      case 3:
        screen = const DownloadsScreen();
        break;

      case 4:
        screen = const MoreScreen();
        break;

      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

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
            _BottomNavItem(
              icon: Icons.home_outlined,
              label: 'Home',
              selected: selectedIndex == 0,
              onTap: () => _navigate(context, 0),
            ),

            _BottomNavItem(
              icon: Icons.search,
              label: 'Search',
              selected: selectedIndex == 1,
              onTap: () => _navigate(context, 1),
            ),

            _BottomNavItem(
              icon: Icons.video_library_outlined,
              label: 'Coming Soon',
              selected: selectedIndex == 2,
              badgeCount: 4,
              onTap: () => _navigate(context, 2),
            ),

            _BottomNavItem(
              icon: Icons.download_outlined,
              label: 'Downloads',
              selected: selectedIndex == 3,
              onTap: () => _navigate(context, 3),
            ),

            _BottomNavItem(
              icon: Icons.menu,
              label: 'More',
              selected: selectedIndex == 4,
              onTap: () => _navigate(context, 4),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final int? badgeCount;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    this.badgeCount,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 65,
        height: 58,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 28,
              height: 27,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Center(
                    child: Icon(
                      icon,
                      size: 22,
                      color: selected ? Colors.white : const Color(0xFF777777),
                    ),
                  ),

                  if (badgeCount != null && badgeCount! > 0)
                    Positioned(
                      right: -2,
                      top: -5,
                      child: Container(
                        width: 15,
                        height: 15,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          badgeCount! > 99 ? '99+' : badgeCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 2),

            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: TextStyle(
                color: selected ? Colors.white : const Color(0xFF777777),
                fontSize: 7,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
