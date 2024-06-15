import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/get_controller.dart';

class SwitchList extends StatelessWidget {
  SwitchList({super.key});
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Qurilma ro’yxati'.tr),
          centerTitle: true,
        ),
      body: Column(
        children: []
      )
    );
  }
}