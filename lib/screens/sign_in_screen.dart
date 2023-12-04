import 'package:flutter/material.dart';
import 'package:musicee_app/utils/theme_manager.dart';

import '../utils/color_manager.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // Controllers for form fields
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Focus nodes for form fields
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  bool _hidePassword = true;
  bool _showError = false;

  bool _isValidEmail(String input) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(input);
  }

  // Validation function
  bool _validateInputs() {
    if (_emailController.text.isEmpty) {
      setState(() {
        _emailFocus.requestFocus();
      });
      return false;
    } else if (!_isValidEmail(_emailController.text)) {
      setState(() {
        _showError = true;
      });
      return false;
    } else if (_passwordController.text.isEmpty) {
      setState(() {
        _passwordFocus.requestFocus();
      });
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    // Dispose controllers and focus nodes to avoid memory leaks
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Welcome Back!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.swatchPrimary.shade700,
                  ),
                ),
                const SizedBox(height: 64),
                TextFormField(
                  controller: _emailController,
                  focusNode: _emailFocus,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    errorText: _showError
                        ? 'Please enter a valid email address!'
                        : null,
                    icon: const Icon(Icons.email),
                    border: ThemeManager.buildFormOutline(_emailController),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  focusNode: _passwordFocus,
                  obscureText: _hidePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    icon: const Icon(Icons.lock),
                    border: ThemeManager.buildFormOutline(_passwordController),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _hidePassword = !_hidePassword;
                        });
                      },
                      icon: Icon(_hidePassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                ),
                const Flexible(
                  flex: 5,
                  child: SizedBox(
                    height: 45,
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.pop(context);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const HomeScreen()),
                      // );
                      // Validate inputs before submitting
                      if (_validateInputs()) {
                        // sign-up logic
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Text('Sign in'),
                  ),
                ),
                const Flexible(
                  flex: 2,
                  child: SizedBox(
                    height: 70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
