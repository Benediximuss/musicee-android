import 'package:flutter/material.dart';
import 'package:musicee_app/api/api_service.dart';
import 'package:musicee_app/models/sign_in_model.dart';
import 'package:musicee_app/screens/home_screen.dart';
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

  // UI Logic
  bool _hidePassword = true;
  bool _showEmailError = false;
  bool _loginFailed = false;
  bool _isLoading = false;

  String _errorMessage = '';

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
    }

    if (!_isValidEmail(_emailController.text)) {
      setState(() {
        _showEmailError = true;
        _emailFocus.requestFocus();
      });
      return false;
    } else {
      setState(() {
        _showEmailError = false;
      });
    }

    if (_passwordController.text.isEmpty) {
      setState(() {
        _showEmailError == false;
        _passwordFocus.requestFocus();
      });
      return false;
    } else {
      setState(() {
        FocusManager.instance.primaryFocus?.unfocus();
      });
      return true;
    }
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
      child: Stack(
        children: [
          Scaffold(
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
                    // const SizedBox(height: 64),
                    const Flexible(
                      flex: 2,
                      child: SizedBox(
                        height: 100,
                      ),
                    ),
                    TextFormField(
                      controller: _emailController,
                      focusNode: _emailFocus,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        errorText: _showEmailError
                            ? 'Please enter a valid email address!'
                            : null,
                        errorStyle: const TextStyle(fontSize: 16),
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
                        border:
                            ThemeManager.buildFormOutline(_passwordController),
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
                    Flexible(
                      flex: 5,
                      child: Container(
                        margin:
                            const EdgeInsets.fromLTRB(50.0, 12.0, 0.0, 36.0),
                        child: Visibility(
                          visible: _loginFailed,
                          child: Text(
                            _errorMessage,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red.shade700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_validateInputs()) {
                            _signInLogic();
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
          if (_isLoading)
            const Opacity(
              opacity: 0.8,
              child: ModalBarrier(
                dismissible: false,
                color: Colors.black,
              ),
            ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  void _signInLogic() {
    setState(() {
      _isLoading = true;
    });

    final requestModel = SignInRequestModel(
      email: _emailController.text,
      password: _passwordController.text,
    );

    APIService.login(requestModel).then(
      (value) {
        setState(() {
          _isLoading = false;
        });

        if (value.error.isNotEmpty) {
          setState(() {
            _loginFailed = true;
            _errorMessage = value.error;
          });
        } else {
          // setState(() {
          //   _hidePassword = true;
          //   _showEmailError = false;
          //   _loginFailed = false;
          //   _isLoading = false;
          //   _errorMessage = '';
          //   _emailController.clear();
          //   _passwordController.clear();
          // });

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      },
    ).catchError((error) {
      setState(() {
        _isLoading = false;
        _loginFailed = true;
        _errorMessage = error;
      });
    });
  }
}
