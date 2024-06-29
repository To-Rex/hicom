import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hicom/controllers/api_controller.dart';
import 'package:hicom/controllers/tea.dart';
import 'package:hicom/pages/auth/login_page.dart';
import 'package:hicom/pages/sample/sample_page.dart';
import '../controllers/get_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {

    //_getController.addUserData(' {"Phone":"+998916848100","SessionToken":"ivEWz4iyP2UZ348HRyF3JKNMuppBSGCNL3a2fnRJolJIpjQUEOlJH208aXBdQtfQ","KEY":"a2tB333raC8y74dt","UID":"2025b25f25ce9ad98d6047ff0dc105b5"}');
    Future.delayed(const Duration(seconds: 1), () {
      if(_getController.getUid() != '' && _getController.getKey() != '50UvFayZ2w5u3O9B') {
        Get.off(SamplePage());
      } else {
        Get.off(LoginPage(), transition: Transition.fadeIn);
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
