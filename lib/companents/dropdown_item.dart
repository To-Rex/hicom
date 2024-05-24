import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/get_controller.dart';

class DropdownItem extends StatelessWidget {
  String title;
  Function onTap;

  DropdownItem({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
            padding: EdgeInsets.symmetric(vertical: Get.height * 0.015, horizontal: Get.width * 0.03),
            width: Get.width,
            height: Get.height * 0.06,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Text(title, style: TextStyle(fontSize: Get.width * 0.04, color: Theme.of(context).colorScheme.onBackground, fontWeight: FontWeight.w500)),
                const Spacer(),
                Icon(Icons.chevron_right, size: Get.width * 0.04, color: Theme.of(context).colorScheme.onBackground)
              ]
            )
        ),
        onTap: () => onTap()
    );
  }
}