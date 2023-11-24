import 'package:flutter/material.dart';
import 'package:musicee_app/theme.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Controllers for form fields
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Focus nodes for form fields
  final _usernameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  // Validation function
  bool _validateInputs() {
    if (_usernameController.text.isEmpty) {
      setState(() {
        _usernameFocus.requestFocus();
      });
      return false;
    } else if (_emailController.text.isEmpty) {
      setState(() {
        _emailFocus.requestFocus();
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
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBG,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                'Create Your Account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.colorPrimary,
                ),
              ),
              const SizedBox(height: 64),
              TextFormField(
                controller: _usernameController,
                focusNode: _usernameFocus,
                decoration: InputDecoration(
                  labelText: 'Username',
                  icon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _usernameController.text.isEmpty
                          ? Colors.red
                          : AppColors.swatchPrimary.shade700,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                focusNode: _emailFocus,
                decoration: InputDecoration(
                  labelText: 'Email',
                  icon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _emailController.text.isEmpty
                          ? Colors.red
                          : AppColors.swatchPrimary.shade700,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                focusNode: _passwordFocus,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  icon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _passwordController.text.isEmpty
                          ? Colors.red
                          : AppColors.swatchPrimary.shade700,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 64),
              SizedBox(
                width: 400,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Validate inputs before submitting
                    if (_validateInputs()) {
                      // sign-up logic
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text(
                    'Create account',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
