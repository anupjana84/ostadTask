import 'package:apiinntrigation/HelperMethod/auth_helper.dart';
import 'package:apiinntrigation/ProdileUpdate/index.dart';
import 'package:apiinntrigation/Screens/login/index.dart';
import 'package:apiinntrigation/Utility/app_color.dart';
import 'package:flutter/material.dart';

import 'dart:convert';

AppBar customAppBar(context, [bool fromUpdateProfile = false]) {
  return AppBar(
    centerTitle: false,
    backgroundColor: AppColors.cardColorOne,
    title: GestureDetector(
      onTap: () {
        if (fromUpdateProfile) {
          return;
        }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => const ProfileUpdateScreen()));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AuthHelper.userData?.fullName ?? "",
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
          Text(
            AuthHelper.userData?.email ?? '',
            style: const TextStyle(
                fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ),
    leading: GestureDetector(
      onTap: () async {
        if (fromUpdateProfile) {
          return;
        }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => const ProfileUpdateScreen()));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: CircleAvatar(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.memory(
              base64Decode(
                AuthHelper.userData?.photo ?? "",
              ),
            ),
          ),
        ),
      ),
    ),
    actions: [
      IconButton(
          onPressed: () async {
            AuthHelper.clearUserData();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (builder) => const SingInScreen()),
                (route) => false);
          },
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
          ))
    ],
  );
}
