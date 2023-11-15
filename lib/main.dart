import 'package:flutter/material.dart';
import 'package:musicee_app/SignUpPage.dart';
import 'package:musicee_app/SignInPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 255, 229, 230),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              'assets/img/app-logo3.png', // Update with your actual file path
              width: 300, // Adjust the size as needed
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
                  // Add navigation logic for sign in
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 233, 142, 141),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text('Create account',
                    style: TextStyle(fontSize: 16)),
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
                    MaterialPageRoute(builder: (context) => SignInPage()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 233, 142, 141),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  side: const BorderSide(
                      width: 2, color: Color.fromARGB(255, 233, 142, 141)),
                ),
                child: const Text(
                  'Sign In',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 64),
          ],
        ),
      ),
    );
  }
}
