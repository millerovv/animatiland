import 'package:animatiland/pages/stars_page/animated_stars.dart';
import 'package:flutter/material.dart';

class StarsPage extends StatefulWidget {
  @override
  _StarsPageState createState() => _StarsPageState();
}

class _StarsPageState extends State<StarsPage> with SingleTickerProviderStateMixin {
  AnimationController? controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: Duration(milliseconds: 1000), vsync: this);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller!.forward(),
      onDoubleTap: () => controller!.reset(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(child: Center(child: AnimatedStars(controller: controller, targetRating: 7.3))),
            Text('Tap to animate,\ndouble tap to reset', style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white), textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
}
