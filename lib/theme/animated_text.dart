import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

const colorizeColors = [
  Colors.purple,
  Colors.blue,
  Colors.yellow,
  Colors.red,
];
const colorizeTextStyle = TextStyle(
  fontSize: 25.0,
  fontFamily: 'Horizon',
);

class animatedText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        ColorizeAnimatedText(
          "BMI Calculator",
          textStyle: colorizeTextStyle,
          colors: colorizeColors,
        ),
      ],
      isRepeatingAnimation: true,
      onTap: () {},
    );
  }
}
