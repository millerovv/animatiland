import 'package:flutter/material.dart';

class AnimatedRect extends StatelessWidget {
	AnimatedRect({ Key key, this.controller }) :

				opacity = Tween<double>(
					begin: 0.0,
					end: 1.0,
				).animate(
					CurvedAnimation(
						parent: controller,
						curve: Interval(
							0.0, 0.200,
							curve: Curves.easeInCubic,
						),
					),
				),

				width = Tween<double>(
					begin: 0.0,
					end: 200.0,
				).animate(
					CurvedAnimation(
						parent: controller,
						curve: Interval(
							0.0, 0.200,
							curve: Curves.easeInCubic,
						),
					),
				),

				height = Tween<double>(
						begin: 0.0,
						end: 200.0
				).animate(
					CurvedAnimation(
						parent: controller,
						curve: Interval(
							0.0, 0.200,
							curve: Curves.easeInCubic,
						),
					),
				),

				firstRotateAngle = Tween<double>(
					begin: 0.0,
					end: 3.14 * 1.5,
				).animate(
					CurvedAnimation(
							parent: controller,
							curve: Interval(
									0.100, 0.600,
									curve: Curves.easeInOutBack
							),
					)
				),

				scale = Tween<double>(
					begin: 1,
					end: 5,
				).animate(
						CurvedAnimation(
							parent: controller,
							curve: Interval(
									0.600, 0.900,
									curve: Curves.bounceIn
							),
						)
				),

				borderRadius = BorderRadiusTween(
					begin: BorderRadius.circular(0.0),
					end: BorderRadius.circular(100.0),
				).animate(
						CurvedAnimation(
							parent: controller,
							curve: Interval(
									0.100, 0.600,
									curve: Curves.easeInOutBack
							),
						)
				),

				colorRedYellow = ColorTween(
					begin: Color(0xFFD02D2D),
					end: Color(0xFFD0B32D),
				).animate(
					CurvedAnimation(
						parent: controller,
						curve: Interval(
							0.200, 0.600,
							curve: Curves.easeInCubic,
						),
					),
				),

			super(key: key);

	
	final Animation<double> controller;
	final Animation<double> width;
	final Animation<double> height;
	final Animation<double> opacity;
	final Animation<double> firstRotateAngle;
	final Animation<double> scale;
	final Animation<BorderRadius> borderRadius;
	final Animation<Color> colorRedYellow;

	Widget _buildAnimation(BuildContext context, Widget child) {
		return Container(
			child: Transform.scale(
				scale: scale.value,
			  child: Transform.rotate(
			  	angle: firstRotateAngle.value,
			    child: Container(
			    	width: width.value,
			    	height: height.value,
			    	decoration: BoxDecoration(
			  		  color: colorRedYellow.value,
			  		   borderRadius: borderRadius.value,
			    	),
			    ),
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