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
        accentColor: Colors.pink,
      ),
      initialRoute: AppRoutePaths.homePage,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
