import 'package:flutter/material.dart';
import 'package:musicee_app/screens/home_screen.dart';
import 'package:musicee_app/screens/welcome_screen.dart';
import 'package:musicee_app/services/auth/auth_manager.dart';

class StartupScreen extends StatelessWidget {
  const StartupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthManager.init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (AuthManager.hasToken()) {
            return const HomeScreen();
          } else {
            return const WelcomeScreen();
          }
        } else {
          // You can return a loading indicator or any other widget while waiting
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
