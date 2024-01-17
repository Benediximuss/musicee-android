import 'package:flutter/material.dart';
import 'package:musicee_app/routes/routes.dart';
import 'package:musicee_app/models/sign_in_model.dart';
import 'package:musicee_app/services/auth/auth_manager.dart';
import 'package:musicee_app/utils/theme_manager.dart';
import 'package:musicee_app/widgets/loaders/loader_view.dart';
import '../utils/color_manager.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // Controllers for form fields
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // Focus nodes for form fields
  final _usernameFocus = FocusNode();
  final _passwordFocus = FocusNode();

  // UI Logic
  bool _hidePassword = true;
  bool _loginFailed = false;
  bool _isLoading = false;

  String _errorMessage = '';

  // Validation function
  bool _validateInputs() {
    if (_usernameController.text.isEmpty) {
      setState(() {
        _usernameFocus.requestFocus();
      });
      return false;
    }

    if (_passwordController.text.isEmpty) {
      setState(() {
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
    _usernameController.dispose();
    _passwordController.dispose();
    _usernameFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: LoaderView(
        condition: _isLoading,
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
                  const Flexible(
                    flex: 2,
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
                      margin: const EdgeInsets.fromLTRB(50.0, 12.0, 0.0, 36.0),
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
      ),
    );
  }

  void _signInLogic() {
    setState(() {
      _isLoading = true;
    });

    final requestModel = SignInRequestModel(
      username: _usernameController.text,
      password: _passwordController.text,
    );

    AuthManager.login(requestModel).then(
      (response) {
        setState(() {
          _isLoading = false;
        });

        if (response.error.isNotEmpty) {
          setState(() {
            _loginFailed = true;
            _errorMessage = response.error;
          });
        } else {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.homeScreen,
            (route) => false,
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
