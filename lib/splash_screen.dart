import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hicom/controllers/api_controller.dart';
import 'package:hicom/controllers/tea.dart';
import 'package:hicom/pages/sample_page.dart';
import '../controllers/get_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    //ApiController().getData('I0N7xNMEgeesBx/mXPInIb0=','districts');
    //ApiController().getData('I0N7xNMEgeesBx/mXPInIb0=','regions');

    debugPrint(TEA.encryptTEA('{'
        '"country_id": 1'
        '}'));
    Future.delayed(const Duration(seconds: 1), () {
      Get.off(SamplePage(), transition: Transition.fadeIn);
      if (GetStorage().read('token') != null) {
        //Get.off(SamplePage());
      } else {
        //Get.off(const OnboardingPage());
      }
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: _getController.height.value * 0.4),
            SizedBox(
              width: _getController.width.value * 0.35,
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover
              )
            ),
            const Spacer(),
            CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary
            ),
            SizedBox(height: _getController.height.value * 0.04),
            Text('versiya'.tr,
              style: TextStyle(
                fontSize: _getController.width.value * 0.035,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onBackground
              )
            ),
            SizedBox(height: _getController.height.value * 0.02),
          ]
        )
      )
    );
  }
}
