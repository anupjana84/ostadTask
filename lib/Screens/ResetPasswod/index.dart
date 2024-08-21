import 'dart:async';

import 'package:apiinntrigation/Api/ApiCallViaGetX/reset_password_controller.dart';
import 'package:apiinntrigation/Api/api_call.dart';
import 'package:apiinntrigation/Api/index.dart';

import 'package:apiinntrigation/HelperMethod/imdex.dart';

import 'package:apiinntrigation/Models/response_model.dart';

import 'package:apiinntrigation/Screens/login/index.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:apiinntrigation/GlobaWidget/Background/index.dart';

import 'package:apiinntrigation/Utility/app_color.dart';
import 'package:get/get.dart';

class ResetPassordScreen extends StatefulWidget {
  //final String email;
  //final String otp;
  //const ResetPassordScreen({super.key, required this.email, required this.otp});

  @override
  State<ResetPassordScreen> createState() => _ResetPassordScreenState();
}

class _ResetPassordScreenState extends State<ResetPassordScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _cpasswordTextController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoding = false;
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$').hasMatch(value)) {
      return 'Password must contain both letters and numbers';
    }
    return null;
  }

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
                      "Set Password",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Text(
                      "Minimum length password 8 character with Letter and number combine",
                      style: TextStyle(fontSize: 14.00),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                        obscureText: true,
                        controller: _passwordTextController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(hintText: "password"),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: _validatePassword),
                    const SizedBox(height: 10),
                    TextFormField(
                      obscureText: true,
                      controller: _cpasswordTextController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration:
                          const InputDecoration(hintText: 'Confirmpassword'),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your password';
                        } else if (value != _passwordTextController.text) {
                          return 'Password does not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    GetBuilder<ResetPasswordController>(
                      builder: (resetPasswordController) {
                        return Visibility(
                          visible: resetPasswordController.isLoding == false,
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
                              _submit();
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
                    //       _submit();
                    //     },
                    //     child: const Text(
                    //       "Confirm",
                    //       style: TextStyle(color: Colors.white),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        Center(
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.8),
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.4,
                              ),
                              text: " Have account? ",
                              children: [
                                TextSpan(
                                  text: 'Sign In',
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

  _submit() {
    if (_formKey.currentState!.validate()) {
      _save();
    }
  }

  Future<void> _save() async {
    final ResetPasswordController resetPasswordController =
        Get.find<ResetPasswordController>();
    final bool result = await resetPasswordController.submit(
      _passwordTextController.text,
    );
    if (result) {
      if (mounted) {
        showSnackMessage(context, 'PASSWORD RESET SUCCESSFULLY', false);
      }
      Timer(const Duration(seconds: 2), () {
        Get.off(
          () => const LoginScreen(),
        );
      });
    } else {
      if (mounted) {
        showSnackMessage(context, "SOMTHING WORNG", true);
      }
    }
  }

  // Future<void> _save() async {
  //   isLoding = true;
  //   setState(() {});
  //   Map<String, dynamic> data = {
  //     // 'email': widget.email,
  //     // 'OTP': widget.otp,
  //     //'password': _cpasswordTextController.text,
  //   };

  //   final NetworkResponse response =
  //       await ApiCall.postApiCall(Api.recoverResetPass, body: data);

  //   isLoding = false;

  //   if (mounted) {
  //     setState(() {});
  //   }

  //   if (response.isSuccess) {
  //     _clearFormField();

  //     if (mounted) {
  //       showSnackMessage(context, 'Password updated Successfully', false);
  //       Timer(const Duration(seconds: 2), () {
  //         Navigator.pushAndRemoveUntil(
  //             context,
  //             MaterialPageRoute(builder: (context) => const LoginScreen()),
  //             (route) => false);
  //       });
  //     }
  //   } else {
  //     if (mounted) {
  //       showSnackMessage(
  //           context, response.errorMessage ?? 'Credential wrong', true);
  //     }
  //   }
  // }

  void _goToSignInButton() {
    context;
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false);
  }

  void _clearFormField() {
    _passwordTextController.clear();
    _cpasswordTextController.clear();
  }

  @override
  void dispose() {
    _passwordTextController.dispose();
    _cpasswordTextController.dispose();
    super.dispose();
  }
}
