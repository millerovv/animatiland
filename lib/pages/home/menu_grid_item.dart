import 'package:animatiland/routing/app_router.dart';
import 'package:flutter/material.dart';

enum MenuGridItem { staggered, gestures, stars, fractal, loadedList }

extension MunuGridItemExt on MenuGridItem {

  String get name {
    switch (this) {
      case MenuGridItem.staggered:
        return 'Staggered';
      case MenuGridItem.gestures:
        return 'Gestures';
      case MenuGridItem.stars:
        return 'Rating';
      case MenuGridItem.fractal:
        return 'Fractal';
      case MenuGridItem.loadedList:
        return 'Loaded List';
      default:
        return '';
    }
  }

  IconData get icon {
    switch (this) {
      case MenuGridItem.staggered:
        return Icons.directions;
      case MenuGridItem.gestures:
        return Icons.gesture;
      case MenuGridItem.stars:
        return Icons.star;
      case MenuGridItem.fractal:
        return Icons.arrow_downward;
      case MenuGridItem.loadedList:
        return Icons.list;
      default:
        return null;
    }
  }

  String get route {
    switch (this) {
      case MenuGridItem.staggered:
        return AppRoutePaths.staggeredAnimationPage;
      case MenuGridItem.gestures:
        return AppRoutePaths.gestureBasedAnimationPage;
      case MenuGridItem.stars:
        return AppRoutePaths.starsPage;
      case MenuGridItem.fractal:
        return AppRoutePaths.fractalPage;
      case MenuGridItem.loadedList:
        return AppRoutePaths.loadedListPage;
      default:
        return AppRoutePaths.homePage;
    }
  }
}
