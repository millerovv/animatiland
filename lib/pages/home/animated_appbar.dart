import 'package:flutter/material.dart';

class AnimatedAppbar extends StatelessWidget implements PreferredSizeWidget {
  AnimatedAppbar({Key? key, this.title, required this.controller, this.screenHeight}) :

        appBarHeight = Tween<double>(begin: 80, end: screenHeight).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              1,
              curve: Curves.ease,
            ),
          ),
        ),

        appBarTitleY = Tween<double>(begin: 80 / 2, end: -30).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.6,
              1,
              curve: Curves.ease,
            ),
          ),
        ),

        super(key: key);

  final String? title;
  final double? screenHeight;
  final AnimationController controller;
  final Animation<double> appBarHeight;
  final Animation<double> appBarTitleY;


  @override
  Size get preferredSize => Size.fromHeight(appBarHeight.value);

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        height: appBarHeight.value,
        color: Theme.of(context).primaryColor,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: appBarTitleY.value,
              left: MediaQuery.of(context).size.width / 2.8,
              child: Text(title!,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.white),
                  textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }


}
