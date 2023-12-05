import 'package:flutter/material.dart';
import 'package:musicee_app/api/api_service.dart';
import 'package:musicee_app/models/sign_up_model.dart';
import 'package:musicee_app/utils/theme_manager.dart';
import '../utils/color_manager.dart';

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

  // UI Logic
  bool _hidePassword = true;
  bool _showEmailError = false;
  bool _signupFailed = false;
  bool _isLoading = false;

  String _errorMessage = '';

  // Email input validation
  bool _isValidEmail(String input) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(input);
  }

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
    } else if (!_isValidEmail(_emailController.text)) {
      setState(() {
        _showEmailError = true;
        _emailFocus.requestFocus();
      });
      return false;
    } else if (_passwordController.text.isEmpty) {
      setState(() {
        _passwordFocus.requestFocus();
      });
      return false;
    } else {
      setState(() {
        _showEmailError = false;
        FocusManager.instance.primaryFocus?.unfocus();
      });
      return true;
    }
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
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Stack(
        children: [
          Scaffold(
            //resizeToAvoidBottomInset: false,
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Create Your Account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.swatchPrimary.shade700,
                      ),
                    ),
                    // const SizedBox(height: 64),
                    const Flexible(
                      flex: 3,
                      child: SizedBox(
                        height: 100,
                      ),
                    ),
                    TextFormField(
                      controller: _usernameController,
                      focusNode: _usernameFocus,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        icon: const Icon(Icons.person),
                        border:
                            ThemeManager.buildFormOutline(_usernameController),
                      ),
                    ),
                    const SizedBox(height: 16),
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
                        height: 70,
                        margin: const EdgeInsets.fromLTRB(50.0, 12.0, 0.0, 0.0),
                        child: Visibility(
                          visible: _signupFailed,
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
                            _signUpLogic();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: const Text('Create an account'),
                      ),
                    ),
                    const Flexible(
                      flex: 1,
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

  void _signUpLogic() {
    setState(() {
      _isLoading = true;
    });

    final requestModel = SignUpRequestModel(
      username: _usernameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );

    APIService.signup(requestModel).then(
      (value) {
        setState(() {
          _isLoading = false;
        });

        if (value.error.isNotEmpty) {
          setState(() {
            _signupFailed = true;
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

          showDialog(
            context: context,
            barrierDismissible: false,
            barrierColor: Colors.black.withOpacity(0.8),
            builder: (context) => const SignUpDialog(),
          );
        }
      },
    ).catchError((error) {
      setState(() {
        _isLoading = false;
        _signupFailed = true;
        _errorMessage = error;
      });
    });
  }
}

class SignUpDialog extends StatelessWidget {
  const SignUpDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorManager.colorBG,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(24.0), // Adjust the radius as needed
      ),
      icon: const Icon(
        Icons.check_circle_rounded,
        color: Colors.green,
        size: 75,
      ),
      title: const Text(
        'Signup Successful',
        style: TextStyle(),
      ),
      content: const Text(
        'Welcome!',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24,
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: const DecoratedBox(
            decoration: BoxDecoration(
              color: ColorManager.colorPrimary,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
              child: Text(
                'OK',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.colorBG,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
