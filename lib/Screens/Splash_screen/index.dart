import 'package:apiinntrigation/GlobaWidget/Background/index.dart';
import 'package:apiinntrigation/HelperMethod/auth_helper.dart';
import 'package:apiinntrigation/Screens/bottomNavigation/index.dart';
import 'package:apiinntrigation/Screens/forgoPassword/index.dart';
import 'package:apiinntrigation/Screens/login/index.dart';

import 'package:apiinntrigation/Utility/assets_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _nextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Center(
          child: SvgPicture.asset(
            AssetPaths.logoPath,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Future<void> _nextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    bool isLogedInUser = await AuthHelper.checkAuthState();
    print(isLogedInUser);
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => isLogedInUser
              ? const BottoNavigationScreen()
              : const SingInScreen(),
        ),
      );
    }
  }
}
