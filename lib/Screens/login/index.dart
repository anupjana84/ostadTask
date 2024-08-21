import 'package:apiinntrigation/Api/ApiCallViaGetX/singin.dart';

import 'package:apiinntrigation/HelperMethod/imdex.dart';

import 'package:apiinntrigation/Screens/bottomNavigation/index.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:apiinntrigation/GlobaWidget/Background/index.dart';
import 'package:apiinntrigation/Screens/forgoPassword/index.dart';
import 'package:apiinntrigation/Screens/register/index.dart';
import 'package:apiinntrigation/Utility/app_color.dart';
import 'package:apiinntrigation/Utility/constants.dart';

import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoding = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24.00),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
                    Text(
                      "Get Started With",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _emailTextController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(hintText: "email"),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your email address';
                        }
                        if (AppConstants.emailCheck.hasMatch(value!) == false) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      obscureText: true,
                      controller: _passwordTextController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(hintText: 'Password'),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    GetBuilder<SignInController>(
                      builder: (singInController) {
                        return Visibility(
                          visible: singInController.isLoding == false,
                          replacement:
                              const Center(child: CircularProgressIndicator()),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.cardColorOne,
                              fixedSize: const Size(double.maxFinite, 45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () {
                              _signIn(singInController);
                            },
                            child:
                                const Icon(Icons.arrow_circle_right_outlined),
                          ),
                        );
                      },
                    ),
                    // Visibility(
                    //   visible: isLoding == false,
                    //   replacement:
                    //       const Center(child: CircularProgressIndicator()),
                    //   child: ElevatedButton(
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: AppColors.cardColorOne,
                    //       fixedSize: const Size(double.maxFinite, 45),
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(10.0),
                    //       ),
                    //     ),
                    //     onPressed: () {
                    //       _signIn();
                    //     },
                    //     child: const Icon(Icons.arrow_circle_right_outlined),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        TextButton(
                          onPressed: _gotToForgotPassworScreen,
                          child: const Text('Forgot Password?'),
                        ),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.8),
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.4,
                              ),
                              text: "Don't Have account? ",
                              children: [
                                TextSpan(
                                  text: 'Sign Up',
                                  style: const TextStyle(
                                      color: AppColors.cardColorOne),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = _goToSignInButton,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signIn(SignInController singInController) async {
    if (_formKey.currentState!.validate()) {
      _login(singInController);
    }
  }

  Future<void> _login(SignInController singInController) async {
    final bool result = await singInController.signIn(
      _emailTextController.text.trim(),
      _passwordTextController.text,
    );
    if (result) {
      Get.off(
        () => const BottoNavigationScreen(),
      );
    } else {
      if (mounted) {
        showSnackMessage(context, singInController.errorMessage, true);
      }
    }
  }

  void _gotToForgotPassworScreen() {
    Get.to(() => const FogotPasswordScreen());
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => const FogotPasswordScreen(),
    //     ));
  }

  void _goToSignInButton() {
    Get.to(() => const SignUpScreen());
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => const SignUpScreen(),
    //     ));
  }

  void _clearFormField() {
    _emailTextController.clear();
    _passwordTextController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
  }
}
