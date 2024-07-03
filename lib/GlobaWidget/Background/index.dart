import 'package:apiinntrigation/Utility/assets_paths.dart';
import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({super.key});
  // final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AssetPaths.backgroundSvg,
          width: double.maxFinite,
          height: double.maxFinite,
          fit: BoxFit.cover,
        )
      ],
    );
  }
}
