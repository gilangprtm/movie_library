import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.orangeAccent,
        child: Center(
          child: SizedBox(
            height: 200,
            child: Image.asset(
              'assets/images/logo-white.png',
              scale: 1,
            ),
          ),
        ),
      ),
    );
  }
}
