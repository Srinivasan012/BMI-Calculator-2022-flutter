import 'package:bmi_calculator/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gaimon/gaimon.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './calculatorFunction.dart';
import 'dart:async';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import './theme/animated_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Gender { male, female }

class bmiApp1 extends StatefulWidget {
  @override
  State<bmiApp1> createState() => _bmiApp1State();
}

class _bmiApp1State extends State<bmiApp1> {
  int height = 180;
  int weight = 60;
  int age = 22;
  num bmi = 0;
  String bmiResults = "Result";
  String resultEmoji = "🫀";

  Timer? timer;
  Gender gender = Gender.male;

  int switchIndex = 0;
  Color gColor1 = Color.fromARGB(255, 58, 145, 232);
  Color gColor2 = Colors.pink;
  bool isCardView = false;
  var themeIcon = Icon(Icons.nights_stay);
  bool themeValue = false;
  Color tColor1 = Color.fromARGB(255, 0, 0, 0);

  void genderColor({required Gender selectedGender}) {
    setState(() {
      if (selectedGender == Gender.male) {
        gColor1 = Color.fromARGB(255, 58, 145, 232);
        gColor2 = Colors.pink;
      } else {
        gColor2 = Color.fromARGB(255, 58, 145, 232);
        gColor1 = Colors.pink;
      }
    });
  }

  @override
  void initState() {
    getUsertheme();
    super.initState();
  }

  void themeChange() async {
    themeValue = !themeValue;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('repeat', themeValue);
    themeManager.toggleTheme(themeValue);
  }

  Future getUsertheme() async {
    final prefs = await SharedPreferences.getInstance();
    themeValue = prefs.getBool('repeat')!;
    setState(() {
      themeIcon = themeValue
          ? Icon(
              Icons.sunny,
              color: Colors.amber,
            )
          : Icon(Icons.nights_stay, color: Color.fromARGB(221, 22, 22, 22));
      themeManager.toggleTheme(themeValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    var Appbar = AppBar(
      backgroundColor:
          themeValue ? Color.fromARGB(255, 18, 18, 18) : Colors.white,
      centerTitle: true,
      toolbarHeight: 40,
      title: animatedText(),
      actions: [
        IconButton(
            onPressed: () async {
              Gaimon.error();
              themeChange();
              getUsertheme();
            },
            icon: themeIcon)
      ],
    );
    return Scaffold(
      appBar: Appbar,
      body: Column(children: [
        Row(
          children: [
            GenderContainer(context, Appbar),
            ResultContainer(context, Appbar),
          ],
        ),
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              height: (MediaQuery.of(context).size.height -
                      Appbar.preferredSize.height) *
                  0.33,
              decoration: BoxDecoration(
                color: themeValue ? tColor1 : Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            Positioned(
              bottom: -23,
              left: 20,
              child: SfRadialGauge(
                enableLoadingAnimation: true,
                axes: <RadialAxis>[
                  RadialAxis(
                      showFirstLabel: false,
                      showAxisLine: true,
                      showLabels: true,
                      showTicks: true,
                      startAngle: 180,
                      endAngle: 360,
                      maximum: 40,
                      canScaleToFit: true,
                      radiusFactor: 0.92,
                      pointers: <GaugePointer>[
                        NeedlePointer(
                            // gradient: LinearGradient(colors: [
                            //   Colors.blue,
                            //   Colors.purple,
                            //   Colors.red,
                            //   Colors.green,
                            //   Colors.pink
                            // ]),
                            needleColor:
                                themeValue ? Colors.purple : Colors.black,
                            enableAnimation: true,
                            animationType: AnimationType.easeOutBack,
                            animationDuration: 1000,
                            needleEndWidth: 5,
                            needleLength: 0.8,
                            value: bmi.toDouble(),
                            knobStyle: const KnobStyle(knobRadius: 0)),
                      ],
                      ranges: <GaugeRange>[
                        GaugeRange(
                            startValue: 0,
                            endValue: 15,
                            startWidth: 0.45,
                            endWidth: 0.45,
                            sizeUnit: GaugeSizeUnit.factor,
                            color: const Color.fromARGB(255, 240, 240, 91)),
                        GaugeRange(
                            startValue: 15,
                            endValue: 18.5,
                            startWidth: 0.45,
                            endWidth: 0.45,
                            sizeUnit: GaugeSizeUnit.factor,
                            color: const Color.fromARGB(255, 242, 238, 5)),
                        GaugeRange(
                            startValue: 18.5,
                            endValue: 25,
                            startWidth: 0.45,
                            sizeUnit: GaugeSizeUnit.factor,
                            endWidth: 0.45,
                            color: const Color.fromARGB(255, 72, 231, 36)),
                        GaugeRange(
                            startValue: 25,
                            endValue: 30,
                            startWidth: 0.45,
                            sizeUnit: GaugeSizeUnit.factor,
                            endWidth: 0.45,
                            color: const Color.fromARGB(255, 234, 88, 59)),
                        GaugeRange(
                            startValue: 30,
                            endValue: 40,
                            startWidth: 0.45,
                            sizeUnit: GaugeSizeUnit.factor,
                            endWidth: 0.45,
                            color: const Color.fromARGB(255, 243, 44, 17)),
                      ]),
                  RadialAxis(
                    showLastLabel: true,
                    interval: 5,
                    showAxisLine: true,
                    showLabels: true,
                    showTicks: true,
                    startAngle: 182,
                    endAngle: 358,
                    maximum: 40,
                    radiusFactor: 0.92,
                    canScaleToFit: true,
                    pointers: <GaugePointer>[
                      MarkerPointer(
                          markerType: MarkerType.text,
                          text: 'UnderWeight',
                          value: 8,
                          textStyle: GaugeTextStyle(
                              color: themeValue ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: isCardView ? 14 : 18,
                              fontFamily: 'Times'),
                          offsetUnit: GaugeSizeUnit.factor,
                          markerOffset: -0.12),
                      MarkerPointer(
                          markerType: MarkerType.text,
                          text: 'Normal',
                          value: 20,
                          textStyle: GaugeTextStyle(
                              color: themeValue ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: isCardView ? 14 : 18,
                              fontFamily: 'Times'),
                          offsetUnit: GaugeSizeUnit.factor,
                          markerOffset: -0.12),
                      MarkerPointer(
                          markerType: MarkerType.text,
                          text: 'OverWeight',
                          value: 32,
                          textStyle: GaugeTextStyle(
                              color: themeValue ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: isCardView ? 14 : 18,
                              fontFamily: 'Times'),
                          offsetUnit: GaugeSizeUnit.factor,
                          markerOffset: -0.12)
                    ],
                  ),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 15, bottom: 8),
                height: 40,
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "BMI: ",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: themeValue ? Colors.white : Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: bmi.toStringAsFixed(1),
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: themeValue
                              ? Color.fromARGB(255, 255, 0, 85)
                              : Color.fromARGB(255, 0, 81, 255)),
                    )
                  ]),
                )),
          ],
        ),
        HeightContainer(context, Appbar),
        Row(
          children: [
            WeightContainer(context, Appbar),
            AgeContainer(context, Appbar),
          ],
        ),
        CalculateButton(context, Appbar),
      ]),
    );
  }

  Expanded GenderContainer(BuildContext context, AppBar Appbar) {
    return Expanded(
      flex: 4,
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 8, right: 8, left: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: themeValue ? tColor1 : Colors.white),
        height:
            (MediaQuery.of(context).size.height - Appbar.preferredSize.height) *
                0.12,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 2),
              child: const Text("Gender",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: ToggleSwitch(
                minWidth: 90.0,
                initialLabelIndex: switchIndex,
                cornerRadius: 20.0,
                activeFgColor: Colors.white,
                inactiveBgColor: Color.fromARGB(255, 39, 32, 32),
                inactiveFgColor: Colors.white,
                totalSwitches: 2,
                animate: true,
                animationDuration: 250,
                labels: ['Male', 'Female'],
                icons: [FontAwesomeIcons.mars, FontAwesomeIcons.venus],
                activeBgColors: [
                  [Color.fromARGB(255, 58, 145, 232)],
                  [Colors.pink]
                ],
                onToggle: (index) {
                  Gaimon.selection();
                  if (index == 0) {
                    switchIndex = index!;
                    gender = Gender.male;
                  } else {
                    switchIndex = index!;
                    gender = Gender.female;
                  }

                  genderColor(selectedGender: gender);
                  print('switched to: $index');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded ResultContainer(BuildContext context, AppBar Appbar) {
    return Expanded(
      flex: 3,
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 8, right: 8, left: 5),
        height:
            (MediaQuery.of(context).size.height - Appbar.preferredSize.height) *
                0.12,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: themeValue ? tColor1 : Colors.white),
        child: GestureDetector(
          onTap: () {
            HapticFeedback.mediumImpact();
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  content: Container(
                    width: 350,
                    child: InteractiveViewer(
                      maxScale: 5,
                      child: Image.asset(
                        fit: BoxFit.fill,
                        "images/bmi1.jpg",
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text(
                        'Close',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              },
            );
          },
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "$resultEmoji",
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: 10,
                ),
                // IconButton(onPressed: () {}, icon: Icon(Icons.insert_chart)),
                Container(
                  margin: const EdgeInsets.all(2),
                  child: Text(
                    '$bmiResults',
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                )
              ]),
        ),
      ),
    );
  }

  Container HeightContainer(BuildContext context, AppBar Appbar) {
    return Container(
      // ignore: sort_child_properties_last
      child: Column(children: [
        const Text(
          "Height",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 33, 100, 243)),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              height.toString(),
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text("cm",
                style: TextStyle(
                  fontSize: 15,
                ))
          ],
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 30)),
          child: Slider(
              value: height.toDouble(),
              min: 120,
              max: 220,
              activeColor: gColor1,
              inactiveColor: gColor2,
              onChanged: ((value) {
                setState(
                  () {
                    height = value.toInt();
                    HapticFeedback.vibrate();
                    // FeedbackType.impact;
                  },
                );
              })),
        )
      ]),
      height:
          (MediaQuery.of(context).size.height - Appbar.preferredSize.height) *
              0.18,
      margin: const EdgeInsets.only(left: 8, right: 8),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: themeValue ? tColor1 : Colors.white,
      ),
    );
  }

  Expanded WeightContainer(BuildContext context, AppBar Appbar) {
    return Expanded(
      child: Container(
        child: Column(children: [
          const Text(
            "Weight",
            style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 33, 100, 243)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Container(
                margin: EdgeInsets.all(2),
                child: Text(
                  "$weight",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
                ),
              ),
              Text("kg")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              CustomIconButton(
                fillcolor: gColor1,
                iconb: FontAwesomeIcons.minus,
                ontap: () {
                  setState(() {
                    if (weight > 1) {
                      weight--;
                      HapticFeedback.mediumImpact();
                    }
                  });
                },
                onlongpress: () {
                  timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
                    setState(() {
                      if (weight > 1) {
                        weight--;
                        HapticFeedback.vibrate();
                      }
                    });
                  });
                },
                onlongpressEnd: (details) {
                  timer?.cancel();
                },
              ),
              CustomIconButton(
                fillcolor: gColor1,
                iconb: FontAwesomeIcons.plus,
                ontap: () {
                  setState(() {
                    weight++;
                    HapticFeedback.mediumImpact();
                  });
                },
                onlongpress: () {
                  timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
                    setState(() {
                      weight++;
                      HapticFeedback.vibrate();
                    });
                  });
                },
                onlongpressEnd: (details) {
                  timer?.cancel();
                },
              ),
            ],
          )
        ]),
        margin: const EdgeInsets.all(10),
        height:
            (MediaQuery.of(context).size.height - Appbar.preferredSize.height) *
                0.16,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: themeValue ? tColor1 : Colors.white,
        ),
      ),
    );
  }

  Expanded AgeContainer(BuildContext context, AppBar Appbar) {
    return Expanded(
      child: Container(
        child: Column(children: [
          const Text(
            "Age",
            style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 33, 100, 243)),
          ),
          Container(
            margin: EdgeInsets.all(2),
            child: Text(
              "$age",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              CustomIconButton(
                fillcolor: gColor1,
                iconb: FontAwesomeIcons.minus,
                ontap: () {
                  setState(() {
                    if (age > 1) {
                      age--;
                      HapticFeedback.mediumImpact();
                    }
                  });
                },
                onlongpress: () {
                  timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
                    setState(() {
                      if (age > 1) {
                        age--;
                        HapticFeedback.vibrate();
                      }
                    });
                  });
                },
                onlongpressEnd: (details) {
                  timer?.cancel();
                },
              ),
              CustomIconButton(
                fillcolor: gColor1,
                iconb: FontAwesomeIcons.plus,
                ontap: () {
                  setState(() {
                    if (age > 0 && age < 300) {
                      age++;
                      HapticFeedback.mediumImpact();
                    }
                  });
                },
                onlongpress: () {
                  timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
                    setState(() {
                      if (age > 0 && age < 300) {
                        age++;
                        HapticFeedback.vibrate();
                      }
                    });
                  });
                },
                onlongpressEnd: (details) {
                  timer?.cancel();
                },
              ),
            ],
          )
        ]),
        margin: EdgeInsets.all(10),
        height:
            (MediaQuery.of(context).size.height - Appbar.preferredSize.height) *
                0.16,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: themeValue ? tColor1 : Colors.white,
        ),
      ),
    );
  }

  InkWell CalculateButton(BuildContext context, AppBar Appbar) {
    return InkWell(
      splashColor: Colors.blue,
      borderRadius: BorderRadius.circular(30),
      onTap: () {
        Gaimon.error();
        setState(() {
          CalculatorFunction calc =
              CalculatorFunction(height: height, weight: weight);
          bmi = calc.calculateBmi();
          bmiResults = calc.getResults();
          resultEmoji = calc.getEmojiResults();
        });
      },
      onLongPress: () {
        setState(() {
          bmi = 0;
          height = 180;
          weight = 60;
          age = 22;
          bmiResults = "Result";
          resultEmoji = "🫀";
          final snackBar = SnackBar(
            backgroundColor: themeValue
                ? Color.fromARGB(254, 205, 34, 236)
                : Color.fromARGB(241, 25, 126, 220),
            dismissDirection: DismissDirection.up,
            behavior: SnackBarBehavior.fixed,
            duration: Duration(seconds: 1),
            content: const Text(
              'BMI Resetted',
              textAlign: TextAlign.center,
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      },
      child: Container(
        child: Center(
            child: const Text(
          "Calculate",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
        )),
        margin: EdgeInsets.all(10),
        height:
            (MediaQuery.of(context).size.height - Appbar.preferredSize.height) *
                0.075,
        width: 230,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color:
                themeValue ? Colors.purple : Color.fromARGB(255, 92, 27, 231)),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  IconData iconb;
  void Function() ontap;
  void Function() onlongpress;
  void Function(LongPressEndDetails) onlongpressEnd;
  Color fillcolor;

  CustomIconButton(
      {required this.iconb,
      required this.ontap,
      required this.onlongpress,
      required this.onlongpressEnd,
      required this.fillcolor});

  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onlongpress,
      onLongPressEnd: onlongpressEnd,
      child: Container(
        margin: EdgeInsets.all(4.5),
        child: RawMaterialButton(
          child: Icon(
            iconb,
            color: Colors.white,
          ),
          onPressed: ontap,
          elevation: 6,
          constraints: BoxConstraints.tightFor(height: 50, width: 50),
          shape: CircleBorder(),
          fillColor: fillcolor,
        ),
      ),
    );
  }
}
