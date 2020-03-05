import 'dart:math' as math;
import 'package:flutter/material.dart';

class FractalPage extends StatefulWidget {
  @override
  _FractalPageState createState() => _FractalPageState();
}

class _FractalPageState extends State<FractalPage> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (_animationController.status == AnimationStatus.dismissed) {
          _animationController.forward();
        } else {
          _animationController.reset();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(),
        body: SafeArea(
          child: Center(
              child: AnimatedFractal(
            listenable: _animationController,
            height: 400,
            width: 150,
          )),
        ),
      ),
    );
  }
}

class AnimatedFractal extends AnimatedWidget {
  const AnimatedFractal({
    Key key,
    @required Animation listenable,
    this.height,
    this.width,
  })  : assert(listenable != null),
        super(key: key, listenable: listenable);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final Animation<double> fractalProgress = CurvedAnimation(parent: listenable, curve: Curves.easeOut);

    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 1.5)),
      height: height,
      width: width,
      child: CustomPaint(
        painter: FractalPainter(progress: fractalProgress.value),
      ),
    );
  }
}

class FractalPainter extends CustomPainter {
  FractalPainter({
    this.progress,
    this.defaultLineLength = 21.0,
    this.angle = math.pi / 5,
  });

  final double progress;
  final double defaultLineLength;
  final double angle;

  double maxHeight;
  double maxWidth;

  int iterations;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress == 0) {
      return;
    }

    maxHeight = size.height * progress;
    maxWidth = size.width;

    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 0.8
      ..color = Colors.white;

    final Path path = Path();
    path.moveTo(size.width / 2, 0);

    var firstLineLength = defaultLineLength / 2;
    if (firstLineLength > maxHeight) {
      firstLineLength = maxHeight;
    }

    Offset start = Offset(size.width / 2, firstLineLength);
    path.lineTo(start.dx, start.dy);

    iterations = ((maxHeight - defaultLineLength / 2) / (defaultLineLength * math.cos(angle) + defaultLineLength)).floor();
    if (defaultLineLength * math.cos(angle) + defaultLineLength > maxHeight) {
      iterations = 0;
    }

    _paintFractalLine(start, path, iterations);

    canvas.drawPath(path, paint);
  }

  void _paintFractalLine(Offset start, Path path, int i, [bool isLeftMax = false, bool isRightMax = false]) {
    var isThisLeftMax = isLeftMax;
    var isThisRightMax = isRightMax;

    var cos = math.cos(math.pi / 2 - angle);
    var sin = math.sin(math.pi / 2 - angle);

    path.moveTo(start.dx, start.dy);

    var lineLength = defaultLineLength;

    // true – if first part of branch doesn't fit in in maxHeight
    bool branchFirstPartHeightNotFit = false;

    // if this is last iteration, check if branch end y coordinate fits maxHeight
    // if not – shrink lineLength
    if (i == 0) {
      var ySpaceLeft = maxHeight - start.dy;
      if (ySpaceLeft < lineLength * math.cos(angle)) {
        lineLength = (maxHeight - start.dy) / sin;
        branchFirstPartHeightNotFit = true;
      }
    }

    var nextX1 = start.dx - lineLength * cos;
    var nextY1 = start.dy + lineLength * sin;

    if (nextX1 < 0) {
      nextX1 = 0;
      nextY1 = start.dy + start.dx * math.tan(math.pi / 2 - angle);
      isThisLeftMax = true;
    }

    var nextX2 = start.dx + lineLength * cos;
    var nextY2 = start.dy + lineLength * sin;

    if (nextX2 > maxWidth) {
      nextX2 = maxWidth;
      nextY2 = start.dy + (maxWidth - start.dx) * math.tan(math.pi / 2 - angle);
      isThisRightMax = true;
    }

    Offset nextPoint1 = Offset(nextX1, nextY1);
    Offset nextPoint2 = Offset(nextX2, nextY2);

    // Draw left part of branch first part
    path.lineTo(nextPoint1.dx, nextPoint1.dy);

    // Draw left part of branch second part
    if (!branchFirstPartHeightNotFit && !isThisLeftMax) {
      var branchSecondPartEndY = nextPoint1.dy + lineLength;

      if (i == 0) {
        branchSecondPartEndY = maxHeight;
      }

      nextPoint1 = Offset(nextPoint1.dx, branchSecondPartEndY);

      path.lineTo(nextPoint1.dx, nextPoint1.dy);
    }

    path.moveTo(start.dx, start.dy);

    // Draw right part of branch first part
    path.lineTo(nextPoint2.dx, nextPoint2.dy);

    // Draw right part of branch second part
    if (!branchFirstPartHeightNotFit && !isThisRightMax) {
      var branchSecondPartEndY = nextPoint2.dy + lineLength;

      if (i == 0) {
        branchSecondPartEndY = maxHeight;
      }

      nextPoint2 = Offset(nextPoint2.dx, branchSecondPartEndY);

      path.lineTo(nextPoint2.dx, nextPoint2.dy);
    }

    if (i > 0) {
      i--;
      if (!isThisLeftMax) {
        _paintFractalLine(nextPoint1, path, i);
      }
      if (!isThisRightMax) {
        _paintFractalLine(nextPoint2, path, i);
      }
    }
  }

  @override
  bool shouldRepaint(FractalPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.defaultLineLength != defaultLineLength || oldDelegate.angle != angle;
}
