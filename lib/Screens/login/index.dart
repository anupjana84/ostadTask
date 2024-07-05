import 'package:apiinntrigation/Api/api_call.dart';
import 'package:apiinntrigation/Api/index.dart';
import 'package:apiinntrigation/HelperMethod/auth_helper.dart';
import 'package:apiinntrigation/HelperMethod/imdex.dart';
import 'package:apiinntrigation/Models/auth_data.dart';
import 'package:apiinntrigation/Models/response_model.dart';
import 'package:apiinntrigation/Screens/bottomNavigation/index.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:apiinntrigation/GlobaWidget/Background/index.dart';
import 'package:apiinntrigation/Screens/forgoPassword/index.dart';
import 'package:apiinntrigation/Screens/register/index.dart';
import 'package:apiinntrigation/Utility/app_color.dart';
import 'package:apiinntrigation/Utility/constants.dart';

class SingInScreen extends StatefulWidget {
  const SingInScreen({super.key});

  @override
  State<SingInScreen> createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
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
                    Visibility(
                      visible: isLoding == false,
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
                          _signIn();
                        },
                        child: const Icon(Icons.arrow_circle_right_outlined),
                      ),
                    ),
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
                                      color: AppColors.themeColor),
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

  _signIn() {
    if (_formKey.currentState!.validate()) {
      _login();
    }
  }

  Future<void> _login() async {
    isLoding = true;
    setState(() {});
    Map<String, dynamic> loginData = {
      'email': _emailTextController.text.trim(),
      'password': _passwordTextController.text,
    };

    final NetworkResponse response =
        await ApiCall.postApiCall(Api.login1, body: loginData);

    isLoding = false;

    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
      _clearFormField();
      AuthModel authModel = AuthModel.fromJson(response.responseData);

      await AuthHelper.userSave(authModel.userModel!);
      await AuthHelper.tokenSave(authModel.token!);
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BottoNavigationScreen(),
          ),
        );
      }
    } else {
      if (mounted) {
        showSnackMessage(
            context, response.errorMessage ?? 'Credential wrong', true);
      }
    }
  }

  void _gotToForgotPassworScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const FogotPasswordScreen(),
        ));
  }

  void _goToSignInButton() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
        ));
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
