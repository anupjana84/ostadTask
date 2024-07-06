import 'package:apiinntrigation/GlobaWidget/Background/index.dart';

import 'package:flutter/material.dart';

class FogotPasswordScreen extends StatefulWidget {
  const FogotPasswordScreen({super.key});

  @override
  State<FogotPasswordScreen> createState() => _FogotPasswordScreenState();
}

class _FogotPasswordScreenState extends State<FogotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Center(
          child: ElevatedButton(
              onPressed: () {
                // _getData();
              },
              child: const Text("data")),
        ),
      ),
    );
  }

  // Future<void> _getData() async {
  //   NetworkResponse res = await ApiCall.getApiCall(Api.completTask);
  //   // print(res);
  // }
}
