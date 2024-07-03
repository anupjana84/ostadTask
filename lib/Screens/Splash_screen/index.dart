import 'package:apiinntrigation/Utility/app_color.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {

   return Scaffold(
     appBar: AppBar(
       title:  const Text("data"),
       backgroundColor: AppColors.backgroundColorTwo,
     ),
     body: const SafeArea(child: Center(
       child: Text("data",style: TextStyle(color: AppColors.backgroundColorTwo ),),
     ),),

   );
  }
}
