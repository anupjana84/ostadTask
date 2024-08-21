import 'package:apiinntrigation/Api/ApiCallViaGetX/verify_pin_controller.dart';
import 'package:apiinntrigation/Api/api_call.dart';
import 'package:apiinntrigation/Api/auth_controller_getx.dart';
import 'package:apiinntrigation/Api/index.dart';

import 'package:apiinntrigation/HelperMethod/imdex.dart';

import 'package:apiinntrigation/Models/response_model.dart';
import 'package:apiinntrigation/Screens/ResetPasswod/index.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:apiinntrigation/GlobaWidget/Background/index.dart';

import 'package:apiinntrigation/Utility/app_color.dart';
import 'package:get/get.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

class PinVarificationScreen extends StatefulWidget {
  //final String email;

  const PinVarificationScreen({
    super.key,
    // required this.email,
  });

  @override
  State<PinVarificationScreen> createState() => _PinVarificationScreenState();
}

class _PinVarificationScreenState extends State<PinVarificationScreen> {
  final TextEditingController _pinVarificationController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoding = false;
  String pin = '';
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
                    PinCodeTextField(
                        appContext: context,
                        obscureText: false,
                        animationType: AnimationType.slide,
                        keyboardType: TextInputType.number,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.circle,
                          activeColor: AppColors.cardColorTwo,
                        ),
                        controller: _pinVarificationController,
                        animationCurve: Curves.bounceIn,
                        onChanged: (value) {
                          pin = value;
                          setState(() {});
                        },
                        length: 6),
                    const SizedBox(height: 12),
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
                    //       _save();
                    //     },
                    //     child: const Icon(Icons.arrow_circle_right_outlined),
                    //   ),
                    // ),
                    GetBuilder<VerifyPinController>(
                      builder: (verifyPinController) {
                        return Visibility(
                          visible: verifyPinController.isLoding == false,
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
                              _save();
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

  Future<void> _save() async {
    final VerifyPinController verifyPinController =
        Get.find<VerifyPinController>();
    final AuthControllerGetx authControllerGetx =
        Get.find<AuthControllerGetx>();

    print(_pinVarificationController.text);
    final url =
        "${Api.baseUrl}/RecoverVerifyOTP/${authControllerGetx.getEmail()}/${_pinVarificationController.text.trim()}";
    final bool result = await verifyPinController.submit(url);

    if (result) {
      authControllerGetx.setopt(_pinVarificationController.text.trim());
      Get.off(
        () => ResetPassordScreen(),
      );
    } else {
      if (mounted) {
        showSnackMessage(context, "otp worng", true);
      }
    }
  }

  // Future<void> _submit() async {
  //   final VerifyPinController verifyPinController =
  //       Get.find<VerifyPinController>();
  //   final AuthControllerGetx authControllerGetx =
  //       Get.find<AuthControllerGetx>();
  //   isLoding = true;
  //   setState(() {});
  //   final api =
  //       "${Api.baseUrl}/RecoverVerifyOTP/${authControllerGetx.getEmail()}/${_pinVarificationController.text.trim()}";

  //   final NetworkResponse response = await ApiCall.getApiCall(api);

  //   isLoding = false;

  //   if (mounted) {
  //     setState(() {});
  //   }

  //   if (response.isSuccess) {
  //     // _clearFormField();

  //     if (mounted) {
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => ResetPassordScreen(
  //               // email: widget.email,
  //               // otp: _pinVarificationController.text.trim()
  //               ),
  //         ),
  //       );
  //     }
  //   } else {
  //     if (mounted) {
  //       showSnackMessage(
  //           context, response.errorMessage ?? ' Email Send fail', true);
  //     }
  //   }
  // }

  void _goTo() {
    Navigator.pop(context);
  }

  // @override
  // void dispose() {
  //   _pinVarificationController.dispose();
  //   super.dispose();
  //   //
  // }
}
