import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropdownItem extends StatelessWidget {
  final String title;
  final Function onTap;

  const DropdownItem({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
            padding: EdgeInsets.symmetric(vertical: Get.height * 0.015, horizontal: Get.width * 0.03),
            width: Get.width,
            height: Get.height * 0.07,
            decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Text(title.tr, style: TextStyle(fontSize: Get.width * 0.04, color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w500)),
                const Spacer(),
                Icon(Icons.chevron_right, size: Get.width * 0.04, color: Theme.of(context).colorScheme.onSurface)
              ]
            )
        ),
        onTap: () => onTap()
    );
  }
}