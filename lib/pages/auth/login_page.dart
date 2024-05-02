import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/get_controller.dart';

class LoginPage extends StatelessWidget {

  LoginPage({super.key});

  final GetController _getController = Get.put(GetController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, size: Get.width * 0.07),
            onPressed: () => Get.back())
      ),
      body: Column(
        children: [
          SizedBox(height: Get.height * 0.03),
          Container(
            width: Get.width * 0.8,
            margin: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
            child: Text('Telefon raqamingizni kiriting:'.tr, style: TextStyle(fontSize: Get.width * 0.06, fontWeight: FontWeight.w500))
          ),
          Container(
              width: Get.width * 0.8,
              margin: EdgeInsets.only(top: Get.height * 0.01, left: Get.width * 0.03, right: Get.width * 0.03,bottom: Get.height * 0.01),
              child: Text('Biz Tasdiqlash kodini jo‘natamiz.'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7), fontSize: Get.width * 0.045, fontWeight: FontWeight.w500))
          ),

        ]
      )
    );
  }
}