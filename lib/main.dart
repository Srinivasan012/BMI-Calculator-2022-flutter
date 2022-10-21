import 'package:bmi_calculator/theme/theme_Constan.dart';
import 'package:flutter/material.dart';
import './mainPage.dart';
import './theme/theme_manager.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(bmiApp());
}

class bmiApp extends StatefulWidget {
  const bmiApp({super.key});

  @override
  State<bmiApp> createState() => _bmiAppState();
}

ThemeManager themeManager = ThemeManager();

class _bmiAppState extends State<bmiApp> {
  @override
  void dispose() {
    themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeManager.themeMode,
      home: bmiApp1(),
    );
  }
}
