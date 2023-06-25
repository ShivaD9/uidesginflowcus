import 'dart:async';
import 'package:flutter/material.dart';
import 'onboardingpage.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // init state
  @override
  void initState() {
    super.initState();
    // create a timer of 2 seconds
    Timer(
      const Duration(seconds: 2),
          () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const onBoardingScreen()));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KAppDarkTheme,
      body: SafeArea(
        child: Center(
          child: Image.asset(
            "assets/logo_flowcus.png",
            height: 200,
            width: 200,
          ),
        ),
      ),
    );
  }
}



const KAppDarkTheme = Colors.black;