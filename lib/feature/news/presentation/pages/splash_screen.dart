import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:news_edge/core/themes/app_colors.dart';
import 'package:news_edge/feature/news/presentation/pages/news_Screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
   Timer(const Duration(seconds: 6), () {
     Navigator.push(context, HomeScreen.route());
   });
    super.initState();
  }
  @override

  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child:AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              "News App",
              textStyle: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 50,
              ),
              speed: const Duration(milliseconds: 270)
            ),
          ]

      ),
      )
    );
  }
}

