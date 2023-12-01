import 'package:flutter/material.dart';
import 'package:musicee_app/screens/welcome_screen.dart';
import 'package:musicee_app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.colorBG,
        textTheme: GoogleFonts.robotoCondensedTextTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle: GoogleFonts.robotoCondensed(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            textStyle: GoogleFonts.robotoCondensed(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        primarySwatch: AppColors.swatchPrimary,
      ),
      home: const WelcomeScreen(),
    );
  }
}
