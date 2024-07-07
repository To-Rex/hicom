import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controllers/get_controller.dart';

class SwitchPortItems extends StatelessWidget {
  final int? ports;
  final String? name;
  final int? portsIcons;
  const SwitchPortItems({super.key, required this.ports, required this.name, required this.portsIcons});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: SizedBox(
            width: Get.width * 0.06,
            child: Column(
                children: [
                  if (name != '')
                    //SvgPicture.asset('assets/svg_assets/port.svg',
                    SvgPicture.asset(GetController().getPortTypes(portsIcons ?? 0),
                        width: Get.width * 0.022,
                        height: Get.height * 0.022,
                        colorFilter: ColorFilter.mode(ports == 0 ? Colors.orange : ports == 1 ? Colors.green : ports == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn))
                  else
                    SizedBox(width: Get.width * 0.03, height: Get.height * 0.022),
                  Text(name.toString(), style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.03))
                ]
            )
        )
    );
  }
}