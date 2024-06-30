import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import '../../resource/colors.dart';

class ItemSettingsData extends StatelessWidget {
  final String portName;
  final String poe;
  final String extend;
  final String reboot;
  final int port;
  final int poEs;
  final int phYc;

  const ItemSettingsData({super.key, required this.portName, required this.poe, required this.extend, required this.reboot, required this.port, required this.poEs, required this.phYc});

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Expanded(child: Center(child: Text(portName == '' ? '-' : portName, style: TextStyle(fontWeight: FontWeight.w500, fontSize: Get.textTheme.bodyMedium!.fontSize)))),
          if (port <= 0)
            Expanded(child: Center(child: Text(poe == '' ? '-' : poe, style: TextStyle(fontWeight: FontWeight.w500, fontSize: Get.textTheme.bodyMedium!.fontSize))))
          else
            Expanded(child: Center(child: CupertinoSwitch(
              value: poEs > 0 ? true : false,
              onChanged: (value) {},
              activeColor: AppColors.green,
              trackColor: AppColors.grey.withOpacity(0.5),
              focusColor: AppColors.green,
              thumbColor: Theme.of(context).colorScheme.surface,
              applyTheme: true
            ))),
          if (port <= 0)
            Expanded(child: Center(child: Text(extend == '' ? '-' : extend, style: TextStyle(fontWeight: FontWeight.w500, fontSize: Get.textTheme.bodyMedium!.fontSize))))
          else
            Expanded(child: Center(child: CupertinoSwitch(
              value: phYc <= 1 ? true : false,
              onChanged: (value) {},
              activeColor: AppColors.green,
              trackColor: AppColors.grey.withOpacity(0.5),
              focusColor: AppColors.green,
              thumbColor: Theme.of(context).colorScheme.surface,
              applyTheme: true
            ))),
          Expanded(child: Center(child: ElevatedButton(onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
            child: Icon(TablerIcons.refresh, color: Get.theme.colorScheme.onSurface, size: Get.textTheme.bodyMedium!.fontSize)
          )))
        ]
    );
  }
}