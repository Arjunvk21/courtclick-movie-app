import 'package:courtclick_movie_app/screens/dashboardScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/netflix_logo.svg',
                  width: 138,
                  height: 37.1953125,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            Positioned(
              top: 62,
              right: 25,
              child: Icon(Icons.edit, color: Colors.white, size: 22),
            ),

            Positioned(
              top: 218,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProfileItem(
                        name: 'Emanalo',
                        imagePath: 'assets/images/blue_profile_card.svg',
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const DashboardScreen(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(width: 28),

                      ProfileItem(
                        name: 'Onyeka',
                        imagePath: 'assets/images/yellow_profile_card.svg',
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const DashboardScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProfileItem(
                        name: 'Thelma',
                        imagePath: 'assets/images/red_profile_card.svg',
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const DashboardScreen(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(width: 28),

                      ProfileItem(
                        name: 'Kids',
                        imagePath: 'assets/images/kids_profile_card.svg',
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const DashboardScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Add Profile
            Positioned(
              top: 535,
              left: 0,
              right: 150,
              child: Column(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      'assets/images/add_icon.svg',
                      width: 138,
                      height: 37.1953125,
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Add Profile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 13.25,
                      fontWeight: FontWeight.w400,
                      height: 27 / 13.25,
                      letterSpacing: 0.68,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              bottom: 8,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 120,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  final String name;
  final String imagePath;
  final VoidCallback onTap;

  const ProfileItem({
    super.key,
    required this.name,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 125,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: [
            SvgPicture.asset(
              imagePath,
              width: 100,
              height: 98,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 0),

            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w400,
                fontSize: 13.25,
                height: 27 / 13.25,
                letterSpacing: 0.68,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
