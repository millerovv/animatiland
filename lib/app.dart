import 'package:animatiland/routing/app_router.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animatiland',
      theme: ThemeData(
        primaryColor: Colors.black,
        colorScheme: const ColorScheme(
            primary: Colors.black,
            primaryVariant: Colors.black,
            secondary: Colors.black,
            secondaryVariant: Colors.black,
            surface: Colors.white,
            background: Colors.black,
            error: Colors.red,
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onSurface: Colors.black,
            onBackground: Colors.black,
            onError: Colors.white,
            brightness: Brightness.light),
      ),
      initialRoute: AppRoutePaths.homePage,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
