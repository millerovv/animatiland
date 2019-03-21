import 'package:animatiland/staggered/animated_rect.dart';
import 'package:flutter/material.dart';

class FirstExamplePage extends StatefulWidget {
  @override
  _FirstExamplePageState createState() => _FirstExamplePageState();
}

class _FirstExamplePageState extends State<FirstExamplePage> with SingleTickerProviderStateMixin {
	AnimationController controller;

	@override
  void initState() {
		super.initState();
    controller = AnimationController(duration: Duration(milliseconds: 5000), vsync: this)
		..addStatusListener((status) {
			if (status == AnimationStatus.completed) {
				controller.reverse();
			} else if (status == AnimationStatus.dismissed) {
				controller.forward();
			}
		});
		controller.forward();
  }

  @override
  void dispose() {
	  controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(),
	    body: Container(
		    child: Center(
			    child: AnimatedRect(controller: controller.view),
		    )
	    ),
    );
  }
}
