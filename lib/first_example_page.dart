import 'package:flutter/material.dart';

class FirstExamplePage extends StatefulWidget {
  @override
  _FirstExamplePageState createState() => _FirstExamplePageState();
}

class _FirstExamplePageState extends State<FirstExamplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(),
    );
  }
}
