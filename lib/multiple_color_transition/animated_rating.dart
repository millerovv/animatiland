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
  final Color targetColor;
  final double targetRating;

  AnimatedRating({Key key, this.controller, this.targetColor, this.targetRating}) : super(key: key);

  @override
  _AnimatedRatingState createState() => _AnimatedRatingState();
}

class _AnimatedRatingState extends State<AnimatedRating> {
  Animation<Color> colorRedToOrange;
  Animation<Color> colorOrangeToYellow;
  Animation<Color> colorYellowToLightGreen;
  Animation<Color> colorLightGreenToGreen;

  @override
  void initState() {
    super.initState();
    _initColorAnimations();
  }

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            5,
            (index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.0),
                  child: Icon(
                    Icons.star,
                    color: widget.targetColor,
                    size: 48.0,
                  ),
                ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: widget.controller,
    );
  }

  int _calculateNumberOfColorTransitionStages(double rating) {
    if (rating >= 7.5) {
      return 4;
    } else if (rating >= 6.5) {
      return 3;
    } else if (rating >= 5.5) {
      return 2;
    } else if (rating >= 4.5) {
      return 1;
    } else {
      return 0;
    }
  }

  void _initColorAnimations() {
    colorRedToOrange = ColorTween(
      begin: kRatingColors['red'],
      end: kRatingColors['orange'],
    ).animate(widget.controller);
  }
}
