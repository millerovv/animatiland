import 'package:animatiland/animated_appbar.dart';
import 'package:flutter/material.dart';

const Map<String, IconData> gridContent = {
  'Example 1': Icons.language,
  'Example 2': Icons.face,
  'Example 3': Icons.radio,
  'Example 4': Icons.airplanemode_active,
  'Example 5': Icons.android,
  'Example 6': Icons.add,
};

const List<String> routes = ['/example1', '/example2'];

class HomePage extends StatefulWidget {
  final double screenHeight;

  HomePage({Key key, @required this.screenHeight}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController appBarAnimationController;

  int nextRoutIndex = -1;

  @override
  void initState() {
    super.initState();
    appBarAnimationController = AnimationController(duration: Duration(milliseconds: 500), vsync: this)
    ..addListener(() {
      // Without this setState Scaffold body wouldn't let appBar to push it's boundaries
      setState(() {});
    })
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushNamed(context, routes[nextRoutIndex]).then((value) {
          appBarAnimationController.reset();
        });
      }
    });
  }

  @override
  void dispose() {
    appBarAnimationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AnimatedAppbar(
          title: 'Animatiland',
          controller: appBarAnimationController,
          screenHeight: MediaQuery.of(context).size.height),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          physics: NeverScrollableScrollPhysics(),
          children: List<Widget>.generate(gridContent.length, (index) {
            var gridContentKeys = gridContent.keys.toList();
            return FlatButton(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(gridContent[gridContentKeys[index]]),
                  SizedBox(height: 8.0),
                  Text(gridContentKeys[index]),
                ],
              ),
              onPressed: () {
                nextRoutIndex = index;
                if (appBarAnimationController.status != AnimationStatus.forward) {
                  appBarAnimationController.forward();
                }
              },
            );
          }),
        ),
      ),
    );
  }
}
