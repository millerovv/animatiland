import 'package:animatiland/multiple_color_transition/animated_rating.dart';
import 'package:flutter/material.dart';

class ThirdExamplePage extends StatefulWidget {
  @override
  _ThirdExamplePageState createState() => _ThirdExamplePageState();
}

class _ThirdExamplePageState extends State<ThirdExamplePage> with SingleTickerProviderStateMixin {
	AnimationController controller;

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
	    onTap: () => controller.forward(),
	    onDoubleTap: () => controller.reset(),
      child: Scaffold(
	    backgroundColor: Theme.of(context).primaryColor,
	    appBar: AppBar(),
	    body: Container(
		    child: Center(
			    child: AnimatedRating(controller: controller, targetRating: 7.3),
		    ),
	    ),
      ),
    );
  }
}
