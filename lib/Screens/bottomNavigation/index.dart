import 'package:apiinntrigation/GlobaWidget/appBar/index.dart';
import 'package:apiinntrigation/Screens/bottomNavigation/cancelled_task_screen.dart';
import 'package:apiinntrigation/Screens/bottomNavigation/completed_screen.dart';
import 'package:apiinntrigation/Screens/bottomNavigation/in_progress_screen.dart';
import 'package:apiinntrigation/Screens/bottomNavigation/new_task_screen.dart';
import 'package:apiinntrigation/Utility/app_color.dart';

import 'package:flutter/material.dart';

class BottoNavigationScreen extends StatefulWidget {
  const BottoNavigationScreen({super.key});

  @override
  State<BottoNavigationScreen> createState() => _BottoNavigationScreenState();
}

class _BottoNavigationScreenState extends State<BottoNavigationScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screen = const [
    CancelledTaskScreen(),
    CompletedScreen(),
    InProgressScreen(),
    NewTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: constomAppBar(context),
      body: _screen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.cardColorOne,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          _selectedIndex = index;
          if (mounted) {
            setState(() {});
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.file_copy),
            label: 'New Task',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.compare_outlined),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cancel),
            label: 'Canceled',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.precision_manufacturing),
            label: 'Progress',
          ),
        ],
      ),
    );
  }
}
