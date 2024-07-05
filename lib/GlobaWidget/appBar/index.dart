import 'package:apiinntrigation/HelperMethod/auth_helper.dart';
import 'package:apiinntrigation/Utility/app_color.dart';
import 'package:flutter/material.dart';

AppBar constomAppBar(context) {
  return AppBar(
    centerTitle: false,
    backgroundColor: AppColors.cardColorOne,
    title: GestureDetector(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${AuthHelper.userData?.firstName}  ${AuthHelper.userData?.lastName}",
            style: const TextStyle(fontSize: 16, color: Colors.red),
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
      onTap: () {},
      child: const Padding(
        padding: EdgeInsets.only(left: 12.0),
        child: CircleAvatar(
          radius: 50.0,
          backgroundImage: NetworkImage(
              'https://images.pexels.com/photos/18681384/pexels-photo-18681384/free-photo-of-gaming.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'), // Replace with your image URL
        ),
      ),
    ),
  );
}
