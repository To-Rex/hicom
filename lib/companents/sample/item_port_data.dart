import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemPortData extends StatelessWidget {
  final String? portName;
  final String? power;
  final String? tx;
  final String? rx;
  final String? status;

  const ItemPortData({super.key,  this.portName, this.power,  this.tx,  this.rx, this.status});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.05,
      child: Row(
          children: [
            Expanded(child: Center(child: Text(portName ?? '-', style: TextStyle(fontWeight: FontWeight.w500, fontSize: Get.textTheme.bodyMedium!.fontSize)))),
            Expanded(child: Center(child: Text(power ?? '-', style: TextStyle(fontWeight: FontWeight.w500, fontSize: Get.textTheme.bodyMedium!.fontSize)))),
            Expanded(child: Center(child: Text(tx ?? '-', style: TextStyle(fontWeight: FontWeight.w500, fontSize: Get.textTheme.bodyMedium!.fontSize)))),
            Expanded(child: Center(child: Text(rx ?? '-', style: TextStyle(fontWeight: FontWeight.w500, fontSize: Get.textTheme.bodyMedium!.fontSize)))),
            Expanded(child: Center(child: Text(status ?? '-', style: TextStyle(fontWeight: FontWeight.w500, fontSize: Get.textTheme.bodyMedium!.fontSize))))
          ]
      )
    );
  }
}