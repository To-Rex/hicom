import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/get_controller.dart';

class RegisterPage extends StatelessWidget{

  RegisterPage({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ma’lumotlarni kiriting'.tr),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back, size: Get.width * 0.06), onPressed: () => Get.back())
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

          ],
        )
      )
    );
  }
}