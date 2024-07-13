import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hicom/pages/auth/login_page.dart';
import 'package:hicom/pages/sample/sample_page.dart';
import '../controllers/get_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    //_getController.addUserData(' {"Phone":"+998916848100","SessionToken":"ivEWz4iyP2UZ348HRyF3JKNMuppBSGCNL3a2fnRJolJIpjQUEOlJH208aXBdQtfQ","KEY":"a2tB333raC8y74dt","UID":"2025b25f25ce9ad98d6047ff0dc105b5"}');
    Future.delayed(const Duration(seconds: 2), () {
      _getController.sec.value = _getController.sec.value + 1;
      if(_getController.sec.value == 1){
        debugPrint('uuuuuu111   ${_getController.sec}');
        if(_getController.getUid() != '' && _getController.getKey() != '50UvFayZ2w5u3O9B') {
          Get.offAll(SamplePage());
        } else {
          Get.offAll(LoginPage(), transition: Transition.fadeIn);
        }
      }else{
        debugPrint('${_getController.sec}');
      }
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(child: Container()),
            SizedBox(width: Get.width * 0.7, child: Image.asset(Theme.of(context).brightness == Brightness.light ? 'assets/images/logo.png' : 'assets/images/logo_night.png', fit: BoxFit.cover)),
            Flexible(child: Container()),
            CircularProgressIndicator(color: Theme.of(context).colorScheme.primary),
            SizedBox(height: Get.height * 0.04),
            Text('${'Talqin'.tr}: 1.0.0', style: TextStyle(fontSize: Get.width * 0.035, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface)),
            SizedBox(height: Get.height * 0.02),
          ]
        )
      )
    );
  }
}
