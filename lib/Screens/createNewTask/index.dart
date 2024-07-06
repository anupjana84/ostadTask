import 'package:apiinntrigation/Api/api_call.dart';
import 'package:apiinntrigation/Api/index.dart';

import 'package:apiinntrigation/HelperMethod/imdex.dart';

import 'package:apiinntrigation/Models/response_model.dart';

import 'package:flutter/material.dart';
import 'package:apiinntrigation/GlobaWidget/Background/index.dart';

import 'package:apiinntrigation/Utility/app_color.dart';
import 'dart:async';

class CreateNewTask extends StatefulWidget {
  const CreateNewTask({super.key});

  @override
  State<CreateNewTask> createState() => _CreateNewTaskState();
}

class _CreateNewTaskState extends State<CreateNewTask> {
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _descriptionTextController =
      TextEditingController();
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
                      "Add New Task",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _titleTextController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(hintText: "title"),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your  title';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _descriptionTextController,
                      maxLines: 5,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration:
                          const InputDecoration(hintText: 'Description'),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your Description';
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
                          _onPress();
                        },
                        child: const Icon(Icons.arrow_circle_right_outlined),
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

  _onPress() {
    if (_formKey.currentState!.validate()) {
      _onSubmit();
    }
  }

  Future<void> _onSubmit() async {
    isLoding = true;
    setState(() {});
    Map<String, dynamic> submitData = {
      'title': _titleTextController.text.trim(),
      'description': _descriptionTextController.text,
      'status': 'New'
    };

    final NetworkResponse response =
        await ApiCall.postApiCall(Api.creatTask, body: submitData);

    isLoding = false;

    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
      _clearFormField();

      if (mounted) {
        showSnackMessage(context, 'Data Save Successfully', false);
        Timer(const Duration(seconds: 2), () {
          if (mounted) {
            Navigator.pop(context, true);
          }
        });
      }
    } else {
      if (mounted) {
        showSnackMessage(
            context, response.errorMessage ?? 'Data Save Fail', true);
      }
    }
  }

  void _clearFormField() {
    _titleTextController.clear();
    _descriptionTextController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    _titleTextController.dispose();
    _descriptionTextController.dispose();
  }
}
