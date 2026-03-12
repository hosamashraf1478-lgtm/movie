import 'dart:async';
import 'package:flutter/material.dart';
import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121312),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            const Icon(
              Icons.play_circle_outline,
              color: Color(0xffFFBB3B),
              size: 90,
            ),

            const SizedBox(height: 20),

            Image.asset(
              "assets/images/Route.png",
              height: 60,
            ),

            const SizedBox(height: 10),

            const Text(
              "Supervised by Mohamed Nabil",
              style: TextStyle(
                color: Colors.white54,
                fontSize: 12,
              ),
            ),

          ],
        ),
      ),
    );
  }
}