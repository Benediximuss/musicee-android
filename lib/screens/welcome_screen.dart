import 'package:flutter/material.dart';
import 'package:musicee_app/screens/sign_up_screen.dart';
import 'package:musicee_app/screens/sign_in_screen.dart';
import 'package:musicee_app/utils/asset_manager.dart';

import '../services/auth/auth_manager.dart';
import '../utils/color_manager.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 60.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                AssetManager.logoWelcomeScreen,
                width: 300,
                height: 300,
              ),
              const Text(
                'Your gateway to a world of music!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 120),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text('Create account'),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignInScreen()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    side: const BorderSide(
                      width: 2,
                      color: ColorManager.colorPrimary,
                    ),
                  ),
                  child: const Text('Sign In'),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Check Token'),
                onPressed: () {
                  print(AuthManager.hasToken() ? 'Has token' : 'No token');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
