import 'package:flutter/material.dart';
import 'package:musicee_app/screens/sign_up_screen.dart';
import 'package:musicee_app/screens/sign_in_screen.dart';
import 'package:musicee_app/theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBG,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              'assets/img/app-logo3.png',
              width: 300,
              height: 300,
            ),
            const SizedBox(height: 0),
            const Text(
              'Your gateway to a world of music!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 128),
            SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Add navigation logic for sign up
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.colorPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text('Create account', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 26),
            SizedBox(
              width: 300,
              height: 50,
              child: OutlinedButton(
                onPressed: () {
                  // Add navigation logic for sign in
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.colorPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  side: const BorderSide(width: 2, color: AppColors.colorPrimary),
                ),
                child: const Text('Sign In', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 64),
          ],
        ),
      ),
    );
  }
}
