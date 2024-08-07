import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemData extends StatelessWidget {
  final String title;
  final String subtitle;
  const ItemData({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Text(
              title == '' ? '-' : title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: Get.textTheme.bodyMedium!.fontSize)),
          SizedBox(width: Get.width * 0.01),
          const Spacer(),
          Text(
              subtitle == '' ? '-' : subtitle,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.end,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: Get.textTheme.labelMedium!.fontSize))
        ]
    );
  }
}