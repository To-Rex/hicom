import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/get_controller.dart';
import 'package:lottie/lottie.dart';

class OnboardingPage extends StatelessWidget {
  OnboardingPage({super.key});

  final GetController _getController = Get.put(GetController());
  late final AnimationController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          children: [
            Lottie.asset('assets/anim/Anims.json')
          ]
      ),
    );
  }
}