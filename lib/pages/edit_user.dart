import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/get_controller.dart';

class EditUser extends StatelessWidget {

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hisobni taxrirlash'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: Get.width * 0.05, fontWeight: FontWeight.w500)),
        centerTitle: true,
          leading: IconButton(icon: Icon(
              Icons.arrow_back, size: Get.width * 0.07),
              onPressed: () => Get.back())
      ),
      body: SafeArea(
        child: Center(
          child: Text('Edit User Page'),
        )
      )
    );
  }

}