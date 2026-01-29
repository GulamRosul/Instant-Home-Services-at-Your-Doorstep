import 'package:flutter/material.dart';
import 'package:protiva502/core/utils/constants/image_path.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagePath.splash),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
