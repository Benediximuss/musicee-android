import 'package:flutter/material.dart';
import 'package:musicee_app/screens/startup_screen.dart';
import 'package:musicee_app/utils/theme_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.lightTheme,
      home: const StartupScreen(),
    );
  }
}
