import 'package:flutter/material.dart';
import 'package:musicee_app/screens/welcome_screen.dart';
import 'package:musicee_app/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: AppColors.swatchPrimary,
      ),
      home: const WelcomeScreen(),
    );
  }
}
