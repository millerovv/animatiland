import 'package:animatiland/gesture_based/second_example_animated_container.dart';
import 'package:flutter/material.dart';

class SecondExamplePage extends StatefulWidget {
	@override
	_SecondExamplePageState createState() => _SecondExamplePageState();
}

class _SecondExamplePageState extends State<SecondExamplePage> with SingleTickerProviderStateMixin {
	AnimationController controller;
	double screenHeight;
	double screenWidth;
	double containerHeight = 200;

	@override
	void initState() {
		super.initState();
		controller = AnimationController(duration: Duration(milliseconds: 1600), vsync: this);
	}

	@override
	void dispose() {
		controller?.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		screenHeight = MediaQuery.of(context).size.height;
		screenWidth = MediaQuery.of(context).size.width;
		return Scaffold(
			backgroundColor: Theme.of(context).primaryColor,
			appBar: AppBar(),
			body: GestureDetector(
				  onVerticalDragStart: (details) {
					  controller.forward();
				  },
				  onVerticalDragEnd: (details) {
					  controller.reverse();
				  },
				  onVerticalDragUpdate: (details) {
					  setState(() {
						  if (containerHeight + details.delta.dy <= screenHeight && containerHeight + details.delta.dy >= 0) {
							  containerHeight += details.delta.dy;
						  }
					  });
				  },
				  onDoubleTap: () {
					  setState(() {
						  containerHeight = 200;
					  });
					  controller.reset();
				  },
			  child: Center(
			    child: SecondExampleAnimatedContainer(
				    containerHeight: containerHeight,
				    screenWidth: screenWidth,
				    controller: controller,
			    ),
			  ),
			)
		);
	}
}
