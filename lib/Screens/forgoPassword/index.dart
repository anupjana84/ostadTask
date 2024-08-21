import 'package:apiinntrigation/Api/ApiCallViaGetX/forgot_password_controller.dart';
import 'package:apiinntrigation/Api/api_call.dart';
import 'package:apiinntrigation/Api/index.dart';

import 'package:apiinntrigation/HelperMethod/imdex.dart';

import 'package:apiinntrigation/Models/response_model.dart';
import 'package:apiinntrigation/Screens/pinVarified/index.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:apiinntrigation/GlobaWidget/Background/index.dart';

import 'package:apiinntrigation/Utility/app_color.dart';
import 'package:apiinntrigation/Utility/constants.dart';
import 'package:get/get.dart';

class FogotPasswordScreen extends StatefulWidget {
  const FogotPasswordScreen({super.key});

  @override
  State<FogotPasswordScreen> createState() => _FogotPasswordScreenState();
}

class _FogotPasswordScreenState extends State<FogotPasswordScreen> {
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
                      "Your Email Address",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      "A 6 digit varification pin will send to your email address",
                      style: Theme.of(context).textTheme.titleSmall,
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
                    const SizedBox(height: 12),
                    GetBuilder<ForgotPasswordController>(
                      builder: (forgotPasswordController) {
                        return Visibility(
                          visible: forgotPasswordController.isLoding == false,
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
                              _next();
                            },
                            child:
                                const Icon(Icons.arrow_circle_right_outlined),
                          ),
                        );
                      },
                    ),
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
                                      color: AppColors.themeColor),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = _goTo,
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

  _next() {
    if (_formKey.currentState!.validate()) {
      _save();
    }
  }

  Future<void> _save() async {
    final ForgotPasswordController forgotPasswordController =
        Get.find<ForgotPasswordController>();
    final url =
        "${Api.baseUrl}/RecoverVerifyEmail/${_emailTextController.text.trim()}";
    final bool result = await forgotPasswordController.submit(url);
    if (result) {
      Get.off(
        () => const PinVarificationScreen(),
      );
    } else {
      if (mounted) {
        // showSnackMessage(context, singInController.errorMessage, true);
      }
    }
  }

  Future<void> _submit() async {
    isLoding = true;
    setState(() {});
    final api =
        "${Api.baseUrl}/RecoverVerifyEmail/${_emailTextController.text.trim()}";

    final NetworkResponse response = await ApiCall.getApiCall(api);

    isLoding = false;

    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
      _clearFormField();
      if (mounted) {
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => PinVarificationScreen(
        //       email: response.responseData['data']['accepted'][0],
        //     ),
        //   ),
        // );
      }
    } else {
      if (mounted) {
        showSnackMessage(
            context, response.errorMessage ?? ' Email Send fail', true);
      }
    }
  }

  void _goTo() {
    Navigator.pop(context);
  }

  void _clearFormField() {
    _emailTextController.clear();
    _passwordTextController.clear();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }
}
