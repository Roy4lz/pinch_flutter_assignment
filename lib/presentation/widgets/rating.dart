import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class Rating extends StatelessWidget {
  const Rating({Key? key, required this.trackWidth, required this.rating, required this.size, required this.fontSize, this.animation = true}) : super(key: key);

  final double trackWidth;
  final double rating;
  final double size;
  final double fontSize;
  final bool animation;

  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      appearance: CircularSliderAppearance(
        angleRange: 360,
        animationEnabled: animation,
        customColors: CustomSliderColors(
            trackColors:[Colors.transparent, Colors.transparent],
            progressBarColors: [const Color(0x794de2), const Color(0xff794de2)]
        ),
        infoProperties: InfoProperties(
          mainLabelStyle: TextStyle(
            shadows: const [
              Shadow(
                offset: Offset(1, 1),
                blurRadius: 6.0,
              ),
            ] ,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
          ),
          modifier: (double value) {
            return value.round().toString();
          }
        ),
        size: size,
        customWidths: CustomSliderWidths(progressBarWidth: trackWidth)
      ),
      min: 0,
      max: 100,
      initialValue: rating,
    );
  }
}
