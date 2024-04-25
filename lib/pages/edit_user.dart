import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hisobni taxrirlash'.tr,
          style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 20),
        ),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back, size: 30), onPressed: () => Get.back()),
      ),
      body: SafeArea(
        child: Center(
          child: Text('Edit User Page'),
        )
      )
    );
  }

}