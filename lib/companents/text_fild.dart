

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFields extends StatelessWidget {
  const TextFields({super.key,required this.title, required this.hintText, required this.controller});
  final String title;
  final String hintText;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: Get.width * 0.04)),
          SizedBox(height: Get.height * 0.01),
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      fillColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
                      filled: true,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      //contentPadding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                      contentPadding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
                      hintText: 'Kiriting'.tr,
                      hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5), fontSize: Get.width * 0.04)
                  ),
                  style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: Get.width * 0.04)
              )
          )
        ]
      )
    );
  }
}