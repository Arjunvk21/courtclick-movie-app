# CourtClick Movie App

A Flutter movie application built for the CourtClick Flutter Developer Machine Test.

The app is inspired by the Netflix-style movie browsing experience and uses the TMDB API for the movie-related screens.

## What is included

- Home/Dashboard with movie categories
- Trending movies
- Popular movies
- Now Playing movies
- Top Rated movies
- Movie search
- Search debounce
- Coming Soon movies
- Coming Soon pagination
- Pull to refresh
- Skeleton loading
- Downloads screen
- More screen
- Profile screen
- Reusable bottom navigation
- TMDB image loading and caching

## Tech used

- Flutter / Dart
- BLoC for state management
- Dio for API calls
- TMDB API
- cached_network_image
- flutter_svg
- shimmer
- rxdart
- equatable
- get_it

## Project structure

The project is divided into a few main parts:

```text
lib/
├── blocs/
│   ├── dashboard/
│   ├── search/
│   └── comingSoon/
│
├── core/
│   ├── constants/
│   └── network/
│
├── customWidgets/
│
├── models/
│
├── repository/
│
├── screens/
│   ├── dashboard/
│   ├── search/
│   ├── comingSoon/
│   ├── downloads/
│   ├── more/
│   └── profile/
│
└── main.dart