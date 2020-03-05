import 'package:animatiland/pages/staggered_animation_page/staggerred_animated_rect.dart';
import 'package:flutter/material.dart';

class StaggeredAnimationPage extends StatefulWidget {
  @override
  _StaggeredAnimationPageState createState() => _StaggeredAnimationPageState();
}

class _StaggeredAnimationPageState extends State<StaggeredAnimationPage> with SingleTickerProviderStateMixin {
	AnimationController controller;

	@override
  void initState() {
		super.initState();
    controller = AnimationController(duration: const Duration(milliseconds: 5000), vsync: this)
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
			    child: StaggeredAnimatedRect(controller: controller.view),
		    )
	    ),
    );
  }
}
