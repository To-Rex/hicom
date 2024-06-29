import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/get_controller.dart';

class ItemPortData extends StatelessWidget {
  final String portName;
  final String power;
  final String tx;
  final String rx;
  final String status;

  const ItemPortData({Key? key, required this.portName, required this.power, required this.tx, required this.rx, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Expanded(child: Center(child: Text(portName == '' ? '-' : portName, style: TextStyle(fontWeight: FontWeight.w500, fontSize: Get.textTheme.bodyMedium!.fontSize)))),
          Expanded(child: Center(child: Text(power == '' ? '-' : power, style: TextStyle(fontWeight: FontWeight.w500, fontSize: Get.textTheme.bodyMedium!.fontSize)))),
          Expanded(child: Center(child: Text(tx == '' ? '-' : tx, style: TextStyle(fontWeight: FontWeight.w500, fontSize: Get.textTheme.bodyMedium!.fontSize)))),
          Expanded(child: Center(child: Text(rx == '' ? '-' : rx, style: TextStyle(fontWeight: FontWeight.w500, fontSize: Get.textTheme.bodyMedium!.fontSize)))),
          Expanded(child: Center(child: Text(status == '' ? '-' : status, style: TextStyle(fontWeight: FontWeight.w500, fontSize: Get.textTheme.bodyMedium!.fontSize))))
        ]
    );
  }
}