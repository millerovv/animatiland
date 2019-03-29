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
		controller = AnimationController(duration: Duration(milliseconds: 600), vsync: this);
//			..addStatusListener((status) {
//				if (status == AnimationStatus.completed) {
//					controller.reverse();
//				} else if (status == AnimationStatus.dismissed) {
//					controller.forward();
//				}
//			});
//		controller.forward();
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
	    body: GestureDetector(
				onTap: (){debugPrint('onTap'); controller.forward();},
	      onDoubleTap: () => controller.reset(),
	      child: Container(
		    child: Center(
			    child: AnimatedRating(controller: controller, targetRating: 5.7),
		    ),
	      ),
	    ),
    );
  }
}
