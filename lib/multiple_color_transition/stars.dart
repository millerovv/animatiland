import 'dart:math';

import 'package:flutter/material.dart';

class StarsPainter extends CustomPainter {
	// Upper half star X points
	static const double secondPointXOffset = 4.55;
	static const double thirdPointXOffset = 1.45;
	static const double forthPointXOffset = 1.45;
	static const double fifthPointXOffset = 4.55;

	// Upper half star Y points
	static const double secondPointYOffset = 0;
	static const double thirdPointYOffset = -4.5;
	static const double forthPointYOffset = 4.5;
	static const double fifthPointYOffset = 0;

	// Bottom half star X points
	static const double sixthPointXOffset = 3.71;
	static const double seventhPointXOffset = -1.42;
	static const double eighthPointXOffset = 3.71;
	static const double ninthPointXOffset = 3.71;
	static const double tenthPointXOffset = -1.42;

	// Bottom half star Y points
	static const double sixthPointYOffset = 2.64;
	static const double seventhPointYOffset = 4.36;
	static const double eighthPointYOffset = -2.7;
	static const double ninthPointYOffset = 2.7;
	static const double tenthPointYOffset = -4.36;

	static const List<double> upperHalfXOffsets = [
		secondPointXOffset, thirdPointXOffset, forthPointXOffset, fifthPointXOffset];

	static const List<double> bottomHalfXOffsets = [
		sixthPointXOffset, seventhPointXOffset, eighthPointXOffset, ninthPointXOffset, tenthPointXOffset];

	static const List<double> upperHalfYOffsets = [
		secondPointYOffset, thirdPointYOffset, forthPointYOffset, fifthPointYOffset];

	static const List<double> bottomHalfYOffsets = [
		sixthPointYOffset, seventhPointYOffset, eighthPointYOffset, ninthPointYOffset, tenthPointYOffset];


	final double fullWidth = 76.0;
	double targetPercent;
	double targetWidth;
	double currentPercent;
	double currentMaxWidth;
	Color color;

	StarsPainter({@required this.targetPercent, @required this.currentPercent, this.color: Colors.white}) {
		targetWidth = fullWidth / 100.0 * targetPercent;
		currentMaxWidth = fullWidth / 100.0 * currentPercent;
		debugPrint("targetWidth = $targetWidth; currentMaxWidth = $currentMaxWidth");
	}

	@override
	void paint(Canvas canvas, Size size) {
		SizeUtil.size = size;

		final paint = Paint()
			..style = PaintingStyle.stroke
			..strokeWidth = 1.0
			..color = color;

		double startX = size.width / 2 - targetWidth / 2;
		double startY = size.height / 2;

		double maxXOffset = startX + currentMaxWidth;

		debugPrint("starting X = $startX");
		debugPrint("starting Y = $startY");
		debugPrint("maxXOffset = $maxXOffset");

		double currentX = startX;
		double currentY = startY;

		_drawStar(canvas, paint, currentX, currentY, maxXOffset);
	}

	@override
	bool shouldRepaint(CustomPainter oldDelegate) => false;

	void _drawStar(Canvas canvas, Paint paint, double x, double y, double maxXOffset) {
		double firstPointX = x;
		double firstPointY = y;
		debugPrint("\ndrawStarForCurrentXY: X = $x. Y = $y");

		double lastUpperPointX;
		double lastUpperPointY;
		var path = Path();

		// Upper half star points
		path.moveTo(x, y);
		int upperPointIndex = 0;
		while (upperPointIndex < 4 && x + upperHalfXOffsets[upperPointIndex] <= maxXOffset) {
			x += upperHalfXOffsets[upperPointIndex];
			y += upperHalfYOffsets[upperPointIndex];
			debugPrint("on upperPointIndex = $upperPointIndex changing currentXY to X = $x, Y = $y; Offset (x, y) = "
					"(${upperHalfXOffsets[upperPointIndex]}, (${upperHalfYOffsets[upperPointIndex]})");
			path.lineTo(x, y);
			upperPointIndex++;
		}
		if (upperPointIndex < 4) {
			double nextUndrawnPointX = x += upperHalfXOffsets[upperPointIndex];
			double nextUndrawnPointY = y += upperHalfYOffsets[upperPointIndex];
			x = x += (maxXOffset - x);
			double tang = nextUndrawnPointY / nextUndrawnPointX;
			y = (upperHalfYOffsets[upperPointIndex] == 0.0) ? y : tang * x;
			path.lineTo(x, y);
		}
		lastUpperPointX = x;
		lastUpperPointY = y;

		//Bottom half star points
		x = firstPointX;
		y = firstPointY;
		path.moveTo(x, y);
		int bottomPointIndex = 0;
		while (bottomPointIndex < 5 && x + bottomHalfXOffsets[bottomPointIndex] <= maxXOffset) {
			x += bottomHalfXOffsets[bottomPointIndex];
			y += bottomHalfYOffsets[bottomPointIndex];
			debugPrint("on bottomPointIndex = $bottomPointIndex changing currentXY to X = $x, Y = $y; Offset (x, y) = "
					"(${bottomHalfXOffsets[bottomPointIndex]}, (${bottomHalfYOffsets[bottomPointIndex]})");
			path.lineTo(x, y);
			bottomPointIndex++;
		}
		if (bottomPointIndex < 5) {
			double nextUndrawnPointX = x += bottomHalfXOffsets[upperPointIndex];
			double nextUndrawnPointY = y += bottomHalfYOffsets[upperPointIndex];
			x = x += (maxXOffset - x);
			double tang = nextUndrawnPointY / nextUndrawnPointX;
			y = (upperHalfYOffsets[upperPointIndex] == 0.0) ? y : tang * x;
			path.lineTo(x, y);
		}
		path.lineTo(lastUpperPointX, lastUpperPointY);

		canvas.drawPath(path, paint);
	}
}

class SizeUtil {
	static const double designWidth = 76;
	static const double designHeight = 11.5;

	//logic size in device
	static Size _logicSize;

	//device pixel radio.

	static get width {
		return _logicSize.width;
	}

	static get height {
		return _logicSize.height;
	}

	static set size(size) {
		_logicSize = size;
	}

	//@param w is the design w;
	static double getAxisX(double w) {
		return (w * width) / designWidth;
	}

// the y direction
	static double getAxisY(double h) {
		return (h * height) / designHeight;
	}

	// diagonal direction value with design size s.
	static double getAxisBoth(double s) {
		return s *
				sqrt((width * width + height * height) /
						(designWidth * designWidth + designHeight * designHeight));
	}
}