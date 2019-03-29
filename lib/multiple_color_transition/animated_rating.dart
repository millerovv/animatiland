import 'package:flutter/material.dart';

const Map<String, Color> kRatingColors = {
  'green': Color(0xFF06D177),
  'light_green': Color(0xFFB5D106),
  'yellow': Color(0xFFD1CE06),
  'orange': Color(0xFFD18606),
  'red': Color(0xFFD13206),
};

class AnimatedRating extends StatefulWidget {
  final AnimationController controller;
  final double targetRating;

  AnimatedRating({Key key, this.controller, this.targetRating}) : super(key: key);

  @override
  _AnimatedRatingState createState() => _AnimatedRatingState();
}

class _AnimatedRatingState extends State<AnimatedRating> {
  int numberOfColorStages;
  int currentColorStage;
  double singleColorStageControllerValueInterval;
  int numberOfStarHalfs;
  Animation colorRed;
  Animation<Color> colorRedToOrange;
  Animation<Color> colorOrangeToYellow;
  Animation<Color> colorYellowToLightGreen;
  Animation<Color> colorLightGreenToGreen;
  List<Animation> animationStages = [];

  @override
  void initState() {
    super.initState();
    currentColorStage = 0;
    numberOfColorStages = _calculateNumberOfColorTransitionStages(widget.targetRating);
    singleColorStageControllerValueInterval = (numberOfColorStages > 0) ? 1.0 / numberOfColorStages : 1.0;
    numberOfStarHalfs = _calculateNumberOfStarTransitionStages(widget.targetRating);
    _initColorAnimations();
    debugPrint("numberOfStages = $numberOfColorStages");
    debugPrint("singleStageControllerValueInterval = $singleColorStageControllerValueInterval");
    widget.controller.addListener(() {
      int newStage = _calculateAnimationStage(widget.controller.value);
      if (newStage != currentColorStage) {
        setState(() {
          currentColorStage = newStage;
          debugPrint("on ${widget.controller.value} setState currentStage = $currentColorStage");
        });
      }
    });

    widget.controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        currentColorStage = 0;
      }
      debugPrint(status.toString());
    });
  }

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            5,
                (index) =>
                Padding(
                  // index = 0 1 2 3 4
                  padding: EdgeInsets.symmetric(horizontal: 2.0),
                  child: AnimatedOpacity(
//                      opacity: (index <= currentColorStage) ? 1.0 : 0.0,
                      opacity: 1.0,
                      duration: Duration(milliseconds: widget.controller.duration.inMilliseconds ~/ 2),
                      child: _getStarIcon(index),
                  ),
                ),
          )),
    );
  }

  Widget _getStarIcon(int index) {
    return (index <= numberOfColorStages) ? Icon(
      Icons.star,
      color: animationStages[currentColorStage].value,
      size: 48.0,
    ) : Icon(
      Icons.star_half,
      color: animationStages[currentColorStage].value,
      size: 48.0,
    );
  }

  @override
  Widget build(BuildContext context) {
//    return AnimatedBuilder(
//      builder: _buildAnimation,
//      animation: widget.controller,
//    );
  return Container(
    child: _getStars(),
  );
  }

  int _calculateNumberOfColorTransitionStages(double rating) {
    if (rating >= 7.5) {
      return 4; // Red -> Orange, Orange -> Yellow, Yellow -> Light Green, Light Green -> Green
    } else if (rating >= 6.5) {
      return 3; // Red -> Orange, Orange -> Yellow, Yellow -> Light Green
    } else if (rating >= 5.5) {
      return 2; // Red -> Orange, Orange -> Yellow
    } else if (rating >= 4.5) {
      return 1; // Red -> Orange
    } else {
      return 0; // Red -> Red?
    }
  }

  int _calculateNumberOfStarTransitionStages(double rating) {
    return rating.floor() + 1;
  }

  int _calculateAnimationStage(double controllerValue) {
    if (numberOfColorStages == 0 && controllerValue < singleColorStageControllerValueInterval) {
      return 0;
    } else if (numberOfColorStages > 0 && controllerValue < singleColorStageControllerValueInterval) {
      return 1;
    } else if (numberOfColorStages > 1 && controllerValue < singleColorStageControllerValueInterval * 2) {
      return 2;
    } else if (numberOfColorStages > 2 && controllerValue < singleColorStageControllerValueInterval * 3) {
      return 3;
    } else if (numberOfColorStages > 3 && controllerValue < singleColorStageControllerValueInterval * 4) {
      return 4;
    } else {
      return currentColorStage;
    }
  }

  void _initColorAnimations() {
    animationStages.add(colorRed = ConstantTween(kRatingColors['red']).animate(widget.controller));

    void initRedToOrange() =>
        animationStages.add(colorRedToOrange = ColorTween(
          begin: kRatingColors['red'],
          end: kRatingColors['orange'],
        ).animate(
          CurvedAnimation(
            parent: widget.controller,
            curve: Interval(
              0.0,
              singleColorStageControllerValueInterval,
              curve: Curves.easeInCubic,
            ),
          ),
        ));

    void initOrangeToYellow() =>
        animationStages.add(colorOrangeToYellow = ColorTween(
          begin: kRatingColors['orange'],
          end: kRatingColors['yellow'],
        ).animate(
          CurvedAnimation(
            parent: widget.controller,
            curve: Interval(
              singleColorStageControllerValueInterval,
              singleColorStageControllerValueInterval * 2,
              curve: Curves.easeInCubic,
            ),
          ),
        ));

    void initYellowToLightGreen() =>
        animationStages.add(colorYellowToLightGreen = ColorTween(
          begin: kRatingColors['yellow'],
          end: kRatingColors['light_green'],
        ).animate(
          CurvedAnimation(
            parent: widget.controller,
            curve: Interval(
              singleColorStageControllerValueInterval * 2,
              singleColorStageControllerValueInterval * 3,
              curve: Curves.easeInCubic,
            ),
          ),
        ));

    void initLightGreenToGreen() =>
        animationStages.add(colorLightGreenToGreen = ColorTween(
          begin: kRatingColors['light_green'],
          end: kRatingColors['green'],
        ).animate(
          CurvedAnimation(
            parent: widget.controller,
            curve: Interval(
              singleColorStageControllerValueInterval * 3,
              singleColorStageControllerValueInterval * 4,
              curve: Curves.easeInCubic,
            ),
          ),
        ));

    switch (numberOfColorStages) {
      case 0:
        break;
      case 1:
        initRedToOrange();
        break;
      case 2:
        initRedToOrange();
        initOrangeToYellow();
        break;
      case 3:
        initRedToOrange();
        initOrangeToYellow();
        initYellowToLightGreen();
        break;
      case 4:
        initRedToOrange();
        initOrangeToYellow();
        initYellowToLightGreen();
        initLightGreenToGreen();
    }
  }
}

Widget _getStars() {
  return CustomPaint(
    painter: StarsPainter(targetPercent: 100, currentPercent: 100),
    child: Container(),
  );
}

class StarsPainter extends CustomPainter {
  // Upper half star points
  static const double secondPointXOffset = 4.55;
  static const double thirdPointXOffset = 1.45;
  static const double forthPointXOffset = 1.45;
  static const double fifthPointXOffset = 4.55;

  // Bottom half star points
  static const double sixthPointXOffset = 3.71;
  static const double seventhPointXOffset = -1.42;
  static const double eighthPointXOffset = 3.71;
  static const double ninthPointXOffset = -1.42;
  static const double tenthPointXOffset = 3.71;

  // Upper half star X points
  static const double secondPointYOffset = 0;
  static const double thirdPointYOffset = -4.5;
  static const double forthPointYOffset = 4.5;
  static const double fifthPointYOffset = 0;

  // Bottom half star points
  static const double sixthPointYOffset = 2.64;
  static const double seventhPointYOffset = 4.36;
  static const double eighthPointYOffset = -2.7;
  static const double ninthPointYOffset = -4.36;
  static const double tenthPointYOffset = -2.64;

  static const List<double> upperHalfXOffsets = [
    secondPointXOffset, thirdPointXOffset, forthPointXOffset, fifthPointXOffset];

  static const List<double> bottomHalfXOffsets = [
    sixthPointXOffset, seventhPointXOffset, eighthPointXOffset, ninthPointXOffset, tenthPointXOffset];

  static const List<double> upperHalfYOffsets = [
    secondPointYOffset, thirdPointYOffset, forthPointYOffset, fifthPointYOffset];

  static const List<double> bottomHalfYOffsets = [
    sixthPointYOffset, seventhPointYOffset, eighthPointYOffset, ninthPointYOffset, tenthPointXOffset];


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
    final paint = Paint();
    paint.color = color;

    debugPrint("sizeWidth = ${size.width}");
    debugPrint("sizeHeight = ${size.height}");

    double startX = size.width / 2 - targetWidth / 2;
    double startY = size.height / 2;

    debugPrint("x = $startX");
    debugPrint("y = $startY");

    double currentX = startX;
    double currentY = startY;

    void drawStarForCurrentXY() {
      var path = Path();
      path.moveTo(currentX, currentY);

      //TODO: Придумать нормальный цикл while прозодящий списки оффсетов до тех пор, пока не дойдет до currentMaxWidth
      // Upper half star points
      while (currentX <= currentMaxWidth) {
        currentX += 4.55;
        if (currentX <= currentMaxWidth) path.lineTo(currentX, currentY);
      }


      path.close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
