import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Animatiland',
        ),
      ),
      body: Container(
        child: Center(
          child: Text('hello animatiland!'),
        ),
      ),
    );
  }
}
