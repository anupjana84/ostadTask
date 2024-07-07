import 'dart:async';

import 'package:apiinntrigation/Api/index.dart';
import 'package:apiinntrigation/Api/api_call.dart';
import 'package:apiinntrigation/GlobaWidget/Background/index.dart';
import 'package:apiinntrigation/HelperMethod/imdex.dart';
import 'package:apiinntrigation/Models/response_model.dart';
import 'package:apiinntrigation/Utility/app_color.dart';
import 'package:apiinntrigation/Utility/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _fNameTextController = TextEditingController();
  final TextEditingController _lNameTextController = TextEditingController();
  final TextEditingController _phoneTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
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
                      height: 120,
                    ),
                    Text(
                      "Join With Us",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailTextController,
                      decoration: const InputDecoration(hintText: "email"),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter Email address";
                        }
                        if (AppConstants.emailCheck.hasMatch(value!) == false) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: _fNameTextController,
                      decoration: const InputDecoration(hintText: "First Name"),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter Your Name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: _lNameTextController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(hintText: "Last Name"),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter Your Name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _phoneTextController,
                      decoration: const InputDecoration(hintText: "Mobile"),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter Mobile No";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _passwordTextController,
                      decoration: const InputDecoration(hintText: "password"),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter Your Password";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
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
                          _register();
                        },
                        child: const Icon(
                          Icons.arrow_circle_right_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    signText(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      _registerApiCall();
    }
  }

  Future<void> _registerApiCall() async {
    isLoding = true;

    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> registerData = {
      "email": _emailTextController.text.trim(),
      "firstName": _fNameTextController.text.trim(),
      "lastName": _lNameTextController.text.trim(),
      "mobile": _phoneTextController.text.trim(),
      "password": _passwordTextController.text.trim(),
      "photo": ""
    };

    final NetworkResponse response =
        await ApiCall.postApiCall(Api.register, body: registerData);

    isLoding = false;

    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
      _clearFormField();

      if (mounted) {
        showSnackMessage(context, 'Registration Successfull', false);
        Timer(const Duration(seconds: 2), () {
          Navigator.pop(context);
        });
      }
    } else {
      if (mounted) {
        showSnackMessage(
            context, response.errorMessage ?? 'Registration Fail', true);
      }
    }
  }

  Center signText() {
    return Center(
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4,
          ),
          text: "Have account? ",
          children: [
            TextSpan(
              text: 'Sign In',
              style: const TextStyle(color: AppColors.cardColorOne),
              recognizer: TapGestureRecognizer()..onTap = _goToSignInButton,
            )
          ],
        ),
      ),
    );
  }

  void _goToSignInButton() {
    Navigator.pop(context);
  }

  void _clearFormField() {
    _emailTextController.clear();
    _fNameTextController.clear();
    _lNameTextController.clear();
    _phoneTextController.clear();
    _passwordTextController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTextController.dispose();
    _fNameTextController.dispose();
    _lNameTextController.dispose();
    _phoneTextController.dispose();
    _passwordTextController.dispose();
  }
}
