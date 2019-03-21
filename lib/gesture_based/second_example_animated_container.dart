import 'package:flutter/material.dart';

class SecondExampleAnimatedContainer extends StatelessWidget {
	SecondExampleAnimatedContainer({
		    Key key,
		    @required this.containerHeight,
		    @required double screenWidth,
		    @required this.controller}) :

				color = ColorTween(
					begin: Color(0xFFD0B32D),
					end: Color(0xFFD02D2D),
				).animate(
					CurvedAnimation(
							parent: controller,
							curve: Interval(
								0.0, 1.0,
								curve: Curves.ease,
							))
				),

				borderRadius = BorderRadiusTween(
					begin: BorderRadius.circular(32.0),
					end: BorderRadius.circular(0.0),
				).animate(
						CurvedAnimation(
							parent: controller,
							curve: Interval(
									0.150, 0.750,
									curve: Curves.ease
							),
						)
				),

				width = Tween<double>(
					begin: 200.0,
					end: screenWidth,
				).animate(
						CurvedAnimation(
							parent: controller,
							curve: Interval(
									0.250, 0.900,
									curve: Curves.ease
							),
						)
				),

				super(key: key);

	final AnimationController controller;
	final Animation<Color> color;
	final Animation<BorderRadius> borderRadius;
	final Animation<double> width;
	final double containerHeight;

	Widget _buildAnimation(BuildContext context, Widget child) {
		return Container(
			height: containerHeight,
			width: width.value,
			decoration: BoxDecoration(
				color: color.value,
				borderRadius: borderRadius.value,
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
