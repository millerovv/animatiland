import 'package:animatiland/pages/fractal_page/fractal_page.dart';
import 'package:animatiland/pages/gesture_based_animation_page/gesture_based_animation_page.dart';
import 'package:animatiland/pages/home/home_page.dart';
import 'package:animatiland/pages/staggered_animation_page/staggered_animation_page.dart';
import 'package:animatiland/pages/stars_page/stars_page.dart';
import 'package:flutter/material.dart';

class AppRoutePaths {
  static const String homePage = 'homePage';
  static const String staggeredAnimationPage = 'staggeredAnimationPage';
  static const String gestureBasedAnimationPage = 'gestureBasedAnimationPage';
  static const String starsPage = 'starsPage';
  static const String fractalPage = 'fractalPage';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutePaths.homePage:
        return MaterialPageRoute(
          builder: (_) => HomePage(),
          settings: const RouteSettings(name: AppRoutePaths.homePage),
        );
      case AppRoutePaths.staggeredAnimationPage:
        return MaterialPageRoute(
          builder: (_) => StaggeredAnimationPage(),
          settings: const RouteSettings(name: AppRoutePaths.staggeredAnimationPage),
        );
      case AppRoutePaths.gestureBasedAnimationPage:
        return MaterialPageRoute(
          builder: (_) => GestureBasedAnimationPage(),
          settings: const RouteSettings(name: AppRoutePaths.gestureBasedAnimationPage),
        );
      case AppRoutePaths.starsPage:
        return MaterialPageRoute(
          builder: (_) => StarsPage(),
          settings: const RouteSettings(name: AppRoutePaths.starsPage),
        );
      case AppRoutePaths.fractalPage:
        return MaterialPageRoute(
          builder: (_) => FractalPage(),
          settings: const RouteSettings(name: AppRoutePaths.fractalPage),
        );
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
