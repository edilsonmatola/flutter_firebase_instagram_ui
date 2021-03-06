import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../layout/mobile_screen_layout.dart';
import '../layout/responsive_screen_layout.dart';
import '../layout/web_screen_layout.dart';
import '../resources/auth_methods.dart';
import '../utils/colors_util.dart';
import '../utils/util.dart';
import '../widgets/text_field_input.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _profileImage;
  bool _isLoading = false;

// Clear of the controllers as soons as they are not needed (removes junk frame)
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  Future<void> selectProfileImage() async {
    final profilePicture = await pickImage(ImageSource.gallery);
    setState(() {
      _profileImage = profilePicture;
    });
  }

  Future<void> signUpUser() async {
    setState(
      () {
        _isLoading = true;
      },
    );
    final result = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      profilePicture: _profileImage!,
    );

    if (result != 'Registered successfully.') {
      showSnackBar(content: result, context: context);
    } else {
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const ResponsiveScreenLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout(),
          ),
        ),
      );
    }

    setState(
      () {
        _isLoading = false;
      },
    );
  }

  void navigateToLoginScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
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
              // Circluar widget to accept and show selected file
              Stack(
                children: [
                  if (_profileImage != null)
                    CircleAvatar(
                      radius: 64,
                      backgroundImage: MemoryImage(
                        _profileImage!,
                      ),
                    )
                  else
                    CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage(
                        'https://icon-library.com/images/default-profile-icon/default-profile-icon-24.jpg',
                      ),
                    ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectProfileImage,
                      icon: const Icon(
                        Icons.add_a_photo,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              // TODO: Implementar helpers para textfields
              // TODO: Hide/Show password option
              // TODO: Criar issues em relacao as modificacoes que quero              // *Username field
              TextFieldInput(
                textEditingController: _usernameController,
                hintText: 'Username',
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 24,
              ),
              // *Email field
              TextFieldInput(
                textEditingController: _emailController,
                hintText: 'Email',
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                isPassword: true,
                textEditingController: _passwordController,
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 24,
              ),
              // Biography field
              TextFieldInput(
                textEditingController: _bioController,
                hintText: 'Enter yout bio Bio',
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 24,
              ),
              // Button
              InkWell(
                onTap: signUpUser,
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
                          child: const CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text(
                          'Sign up',
                        ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
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
                    onTap: navigateToLoginScreen,
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
