
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Get.offNamed('/MainScreen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: DecoratedBox(
          decoration: const BoxDecoration(

            image: DecorationImage(
              image: AssetImage("assets/images/splash_bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [

                  const Spacer(),

                  /// Logo
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: const Color(0xffFFF3D8),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(18),
                    child: Image.asset("assets/images/logo.png"),
                  ),

                  const SizedBox(height: 24),

                   Text(
                    "LinguaLearn",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkGreen,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "MASTERY THROUGH FOCUS",
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),

                  const Spacer(),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffE8F3FF),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: const Color(0xffCFE2FF),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.auto_awesome,
                          color: AppColors.lightGreen,
                          size: 18,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "POWERED BY ADVANCED AI",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.accentGreen,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
                  ),
                ),

              // ],
            ),
          ),

        ),
    );

  }
}