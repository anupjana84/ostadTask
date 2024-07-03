import 'package:apiinntrigation/Screens/Splash_screen/index.dart';
import 'package:apiinntrigation/Screens/login/index.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: _lightTheme(),
      darkTheme: _dartheme(),
      themeMode: ThemeMode.light,
      home: const SingInScreen(),
    );
  }
}

ThemeData _lightTheme() {
  return ThemeData(
      brightness: Brightness.light,
      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black45),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ));
}
//Mark- Dark them config

ThemeData _dartheme() {
  return ThemeData(
    brightness: Brightness.light,
    inputDecorationTheme: const InputDecorationTheme(
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.black45)),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedBorder: OutlineInputBorder(),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          fixedSize: const Size.fromWidth(double.maxFinite),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: const Color(0xff667C89),
          foregroundColor: Colors.white),
    ),
  );
}
//ffff