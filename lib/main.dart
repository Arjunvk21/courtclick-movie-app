import 'package:courtclick_movie_app/screens/splashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CourtClickApp());
}

class CourtClickApp extends StatelessWidget {
  const CourtClickApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CourtClick',
      home: const SplashScreen(),
    );
  }
}
