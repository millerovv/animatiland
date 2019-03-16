import 'package:flutter/material.dart';

const Map<String, IconData> gridContent = {
  'Example 1': Icons.language,
  'Example 2': Icons.face,
  'Example 3': Icons.radio,
  'Example 4': Icons.airplanemode_active,
  'Example 5': Icons.android,
  'Example 6': Icons.add,
};

const List<String> routes = ['/example1'];

class HomePage extends StatefulWidget {
  final double screenHeight;

  HomePage({Key key, @required this.screenHeight}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  Animation<double> appBarHeight;
  Animation<double> appBarTitlePosY;
  AnimationController appBarAnimationController;

  int nextRoutIndex = -1;

  @override
  void initState() {
    super.initState();
    appBarAnimationController = AnimationController(duration: Duration(milliseconds: 500), vsync: this)
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushNamed(context, routes[nextRoutIndex]).then((value) {
          appBarAnimationController.reset();
        });
      }
    });

    appBarHeight = Tween<double>(begin: 80, end: widget.screenHeight).animate(
      CurvedAnimation(
        parent: appBarAnimationController,
        curve: Interval(
          0.0,
          1,
          curve: Curves.ease,
        ),
      ),
    )..addListener(() {
      setState(() {});
    });

    appBarTitlePosY = Tween<double>(begin: 80 / 2, end: -30).animate(
      CurvedAnimation(
        parent: appBarAnimationController,
        curve: Interval(
          0.6,
          1,
          curve: Curves.ease,
        ),
      ),
    )..addListener(() {
      setState(() {});
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appBarHeight.value),
        child: Container(
          height: appBarHeight.value,
          color: Theme.of(context).primaryColor,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: appBarTitlePosY.value,
                left: MediaQuery.of(context).size.width / 2.8,
                child: Text('Animatiland',
                    style: Theme.of(context).textTheme.title.copyWith(color: Colors.white),
                    textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
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
