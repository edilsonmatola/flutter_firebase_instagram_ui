import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../layout/mobile_screen_layout.dart';
import '../layout/responsive_screen_layout.dart';
import '../layout/web_screen_layout.dart';

import '../resources/auth_methods.dart';
import '../utils/colors_util.dart';
import '../utils/util.dart';
import '../widgets/text_field_input.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

// Clear of the controllers as soons as they are not needed (removes junk frame)
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  Future<void> _loginUser() async {
    setState(() {
      _isLoading = true;
    });
    // * Validating the inserted email and password
    final result = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (result == 'Successfully logged in!') {
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const ResponsiveScreenLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout(),
          ),
        ),
      );
    } else {
      //
      showSnackBar(content: result, context: context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignUpScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const SignUpScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
          ),
          width: double.infinity, //Full width of the device
          child: Column(
            children: [
              // Instagram Title
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(
                height: 64,
              ),
              // *Email field
              TextFieldInput(
                textEditingController: _emailController,
                hintText: 'Email',
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                isPassword: true,
                textEditingController: _passwordController,
                hintText: 'Password',
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 24,
              ),
              // * Login Button
              InkWell(
                onTap: _loginUser,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  decoration: const ShapeDecoration(
                    color: blueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                  ),
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: _isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text(
                          'Log in',
                        ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              /* Big spacement */
              Flexible(
                flex: 2,
                child: Container(),
              ),
              // TODO: Implementar TextButton instead of Containers
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "Don't have an account?",
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: navigateToSignUpScreen,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Sign up.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
