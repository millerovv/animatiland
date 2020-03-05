import 'package:animatiland/routing/app_router.dart';
import 'package:flutter/material.dart';

enum MenuGridItem { staggered, gestures, stars, fractal }

extension MunuGridItemExt on MenuGridItem {
  String getItemName() {
    switch (this) {
      case MenuGridItem.staggered:
        return 'Staggered';
      case MenuGridItem.gestures:
        return 'Gestures';
      case MenuGridItem.stars:
        return 'Rating';
      case MenuGridItem.fractal:
        return 'Fractal';
      default:
        return '';
    }
  }

  IconData getItemIcon() {
    switch (this) {
      case MenuGridItem.staggered:
        return Icons.directions;
      case MenuGridItem.gestures:
        return Icons.gesture;
      case MenuGridItem.stars:
        return Icons.star;
      case MenuGridItem.fractal:
        return Icons.arrow_downward;
      default:
        return null;
    }
  }

  String getItemRoute() {
    switch (this) {
      case MenuGridItem.staggered:
        return AppRoutePaths.staggeredAnimationPage;
      case MenuGridItem.gestures:
        return AppRoutePaths.gestureBasedAnimationPage;
      case MenuGridItem.stars:
        return AppRoutePaths.starsPage;
      case MenuGridItem.fractal:
        return AppRoutePaths.fractalPage;
      default:
        return AppRoutePaths.homePage;
    }
  }
}
