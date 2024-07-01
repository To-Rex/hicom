import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import '../../resource/colors.dart';

class ItemSettingsData extends StatelessWidget {
  final String? portName;
  final String? poe;
  final String? extend;
  final String? reboot;
  final int? port;
  final int? poEs;
  final int? phYc;

  const ItemSettingsData({super.key, this.portName, this.poe, this.extend, this.reboot, this.port, this.poEs, this.phYc});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(child: Container(margin: EdgeInsets.only(top: Get.width * 0.04), child: Text(portName ?? '--', style: TextStyle(fontWeight: FontWeight.w500, fontSize: Get.textTheme.bodyMedium!.fontSize)))),
          if (port != null)
            if (port! <= 0)
              Center(child: Container(margin: EdgeInsets.only(top: Get.width * 0.04), child: Text(poe ?? '--', style: TextStyle(fontWeight: FontWeight.w500, fontSize: Get.textTheme.bodyMedium!.fontSize))))
            else
              Center(child: CupertinoSwitch(
                  value:poEs! > 0 ? true : false,
                  onChanged: (value) {},
                  activeColor: AppColors.green,
                  trackColor: AppColors.grey.withOpacity(0.5),
                  focusColor: AppColors.green,
                  thumbColor: Theme.of(context).colorScheme.surface,
                  applyTheme: true
              ))
          else
            Center(child: Container(margin: EdgeInsets.only(top: Get.width * 0.04), child:Text('--', style: TextStyle(fontWeight: FontWeight.w500, fontSize: Get.textTheme.bodyMedium!.fontSize)))),
          if(port != null)
            if (port! <= 0)
              Center(child: Container(margin: EdgeInsets.only(top: Get.width * 0.04), child: Text(extend != '0' ? extend.toString() : '--', style: TextStyle(fontWeight: FontWeight.w500, fontSize: Get.textTheme.bodyMedium!.fontSize))))
            else
              Center(child: CupertinoSwitch(
                  value:port != null && phYc! <= 1 ? true : false,
                  onChanged: (value) {},
                  activeColor: AppColors.green,
                  trackColor: AppColors.grey.withOpacity(0.5),
                  focusColor: AppColors.green,
                  thumbColor: Theme.of(context).colorScheme.surface,
                  applyTheme: true
              ))
          else
            Center(child: Container(margin: EdgeInsets.only(top: Get.width * 0.04), child:Text('--', style: TextStyle(fontWeight: FontWeight.w500, fontSize: Get.textTheme.bodyMedium!.fontSize)))),
          if(port != null && port! > 0)
            Center(child: ElevatedButton(onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                ),
                child: Icon(TablerIcons.refresh, color: Get.theme.colorScheme.onSurface, size: Get.textTheme.bodyMedium!.fontSize)))
          else
            Center(
                child: Container(
                  margin: EdgeInsets.only(top: Get.width * 0.04),
                    child: Text('--', style: TextStyle(fontWeight: FontWeight.w500, fontSize: Get.textTheme.bodyMedium!.fontSize))
                )
            )
        ]
    );
  }
}