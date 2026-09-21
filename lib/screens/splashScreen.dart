import 'dart:async';

import 'package:courtclick_movie_app/screens/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Transform.scale(
          scaleX: 1.05,
          child: SvgPicture.asset('assets/images/netflix_logo.svg', width: 130),
        ),
      ),
    );
  }
}

// import 'dart:async';

// import 'package:courtclick_movie_app/screens/profileScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();

//     Timer(const Duration(seconds: 2), () {
//       if (!mounted) return;

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const ProfileScreen()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: Transform.scale(
//           scaleX: 1.05,
//           child: SvgPicture.asset('assets/images/netflix_logo.svg'),
//         ),
//       ),
//     );
//   }
// }
