import 'dart:math';

class CalculatorFunction {
  CalculatorFunction({required this.height, required this.weight});
  final int height;
  final int weight;

  late double _bmi;

  num calculateBmi() {
    _bmi = weight / pow(height / 100, 2);
    return _bmi;
  }

  String getResults() {
    if (_bmi > 30) {
      return "Obese";
    } else if (_bmi > 25) {
      return "Overweight";
    } else if (_bmi > 18) {
      return "Normal";
    } else if (_bmi > 15 && _bmi < 18) {
      return "Underweight";
    } else {
      return " Severe \n" + "Underweight";
    }
  }

  String getEmojiResults() {
    if (_bmi > 30) {
      return "👨‍⚕️";
    } else if (_bmi > 25) {
      return "❤️‍🩹";
    } else if (_bmi > 18) {
      return "💪";
    } else if (_bmi > 15 && _bmi < 18) {
      return "❗";
    } else {
      return "👩‍⚕️";
    }
  }
}
