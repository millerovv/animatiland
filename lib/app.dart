import 'package:animatiland/staggered/first_example_page.dart';
import 'package:animatiland/home/home_page.dart';
import 'package:animatiland/gesture_based/second_example_page.dart';
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
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(screenHeight: MediaQuery.of(context).size.height),
        '/example1': (context) => FirstExamplePage(),
        '/example2': (context) => SecondExamplePage(),
      },
    );
  }
}
