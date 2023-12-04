import 'package:flutter/material.dart';
import 'package:musicee_app/screens/welcome_screen.dart';
import 'package:musicee_app/utils/color_manager.dart';
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
        scaffoldBackgroundColor: ColorManager.colorBG,
        textTheme: GoogleFonts.robotoCondensedTextTheme(),
        appBarTheme: AppBarTheme(
            titleTextStyle: GoogleFonts.robotoCondensed(
              color: ColorManager.colorAppBarText,
              fontSize: 25,
            ),
            iconTheme: const IconThemeData(
              color: ColorManager.colorAppBarText,
            )),
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
        primarySwatch: ColorManager.swatchPrimary,
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.red,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          floatingLabelStyle: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}
