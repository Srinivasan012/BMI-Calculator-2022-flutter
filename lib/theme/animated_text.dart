import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/services.dart';

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
const colorizeColors1 = [
  Color.fromARGB(255, 234, 60, 115),
  Color.fromARGB(255, 243, 226, 33),
  Color.fromARGB(255, 59, 118, 255),
  Color.fromARGB(255, 244, 54, 187),
  Color.fromARGB(255, 59, 255, 79),
];

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
        ColorizeAnimatedText(
          "BMI Calculator",
          textStyle: colorizeTextStyle,
          colors: colorizeColors1,
        ),
      ],
      repeatForever: true,
      isRepeatingAnimation: true,
      onTap: () {
        HapticFeedback.vibrate();
      },
    );
  }
}
