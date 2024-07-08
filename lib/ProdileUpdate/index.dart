import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:apiinntrigation/Api/index.dart';
import 'package:apiinntrigation/Api/api_call.dart';
import 'package:apiinntrigation/GlobaWidget/Background/index.dart';
import 'package:apiinntrigation/GlobaWidget/appBar/index.dart';
import 'package:apiinntrigation/HelperMethod/auth_helper.dart';
import 'package:apiinntrigation/HelperMethod/imdex.dart';
import 'package:apiinntrigation/Models/response_model.dart';
import 'package:apiinntrigation/Models/user_data.dart';
import 'package:apiinntrigation/Utility/app_color.dart';
import 'package:apiinntrigation/Utility/constants.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({super.key});

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _fNameTextController = TextEditingController();
  final TextEditingController _lNameTextController = TextEditingController();
  final TextEditingController _phoneTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  bool isLoding = false;
  XFile? _selectImage;
  @override
  void initState() {
    super.initState();
    final userData = AuthHelper.userData!;
    _emailTextController.text = userData.email ?? '';
    _fNameTextController.text = userData.firstName ?? "";
    _phoneTextController.text = userData.mobile ?? "";
    _lNameTextController.text = userData.mobile ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, true),
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
                      "Profile Update",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    _profileContainer(),
                    const SizedBox(height: 10),
                    TextFormField(
                      enabled: false,
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
                          _save();
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector _profileContainer() {
    return GestureDetector(
      onTap: () {
        _pickImage();
      },
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.00),
            color: Colors.grey[300]),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              width: 100,
              height: 50,
              decoration: const BoxDecoration(
                color: AppColors.cardColorOne,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.00),
                  bottomLeft: Radius.circular(10.00),
                ),
              ),
              child: const Text(
                'Photo',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
                child: Text(
              _selectImage?.name ?? 'No image selected',
              maxLines: 1,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ))
          ],
        ),
      ),
    );
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      _profileUpdateApiCall();
    }
  }

  Future<void> _profileUpdateApiCall() async {
    isLoding = true;
    String ebcodImage = AuthHelper.userData?.photo ?? "";

    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> requestData = {
      "email": _emailTextController.text.trim(),
      "firstName": _fNameTextController.text.trim(),
      "lastName": _lNameTextController.text.trim(),
      "mobile": _phoneTextController.text.trim(),
    };

    if (_passwordTextController.text.isNotEmpty) {
      requestData['password'] = _passwordTextController.text;
    }
    if (_selectImage != null) {
      File file = File(_selectImage!.path);
      ebcodImage = base64Encode(file.readAsBytesSync());
      requestData['photo'] = ebcodImage;
    }

    final NetworkResponse response =
        await ApiCall.postApiCall(Api.profileUpdate, body: requestData);

    isLoding = false;

    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess && response.responseData['status'] == 'success') {
      UserModel userModel = UserModel(
          email: _emailTextController.text,
          photo: ebcodImage,
          firstName: _fNameTextController.text.trim(),
          lastName: _lNameTextController.text.trim(),
          mobile: _phoneTextController.text.trim());
      await AuthHelper.userSave(userModel);
      if (mounted) {
        showSnackMessage(context, 'Profile Updated Successfully', false);
        Timer(const Duration(seconds: 2), () {
          Navigator.pop(context);
        });
      }
    } else {
      if (mounted) {
        showSnackMessage(
            context, response.errorMessage ?? 'Profile Updated Fail', true);
      }
    }
  }

  Future<void> _pickImage() async {
    final pickerImage = ImagePicker();
    final XFile? image =
        await pickerImage.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _selectImage = image;
      if (mounted) {
        setState(() {});
      }
    }
  }
}
