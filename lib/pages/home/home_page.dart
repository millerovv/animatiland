import 'package:animatiland/pages/home/animated_appbar.dart';
import 'package:animatiland/pages/home/menu_grid_item.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  static const Duration appBarAnimationDuration = Duration(milliseconds: 500);

  AnimationController _appBarAnimationController;
  MenuGridItem _selectedMenuItem;

  @override
  void initState() {
    super.initState();
    _appBarAnimationController = AnimationController(duration: appBarAnimationDuration, vsync: this)
      ..addListener(() => setState(() {}))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _onAppBarAnimationComplete();
        }
      });
  }

  @override
  void dispose() {
    _appBarAnimationController?.dispose();
    super.dispose();
  }

  Future<void> _onAppBarAnimationComplete() async {
    await Navigator.pushNamed(context, _selectedMenuItem.route);
    _appBarAnimationController.reset();
  }

  void _onMenuGridItemTap(MenuGridItem item) {
    if (_appBarAnimationController.status != AnimationStatus.forward) {
      _appBarAnimationController.forward();
    }

    _selectedMenuItem = item;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AnimatedAppbar(title: 'Animatiland', controller: _appBarAnimationController, screenHeight: MediaQuery.of(context).size.height),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          physics: const NeverScrollableScrollPhysics(),
          children: List<Widget>.generate(MenuGridItem.values.length, (index) {
            final MenuGridItem item = MenuGridItem.values[index];
            return FlatButton(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(item.icon),
                  const SizedBox(height: 8.0),
                  Text(item.name),
                ],
              ),
              onPressed: () => _onMenuGridItemTap(item),
            );
          }),
        ),
      ),
    );
  }
}
