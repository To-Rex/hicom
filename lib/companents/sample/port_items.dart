import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controllers/get_controller.dart';

class PortItems extends StatelessWidget {

  final List<String> data;
  final List<int>? ports;

  const PortItems({super.key, required this.data, this.ports});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5), width: Get.height * 0.003),
            color: Theme.of(context).colorScheme.surface
        ),
        margin: EdgeInsets.only(bottom: Get.height * 0.01),
        padding: EdgeInsets.all(Get.height * 0.01),
        child:  Row(
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                width: Get.width * 0.06,
                child: Column(
                    children: [
                      if (data[0] != '')
                        SvgPicture.asset('assets/svg_assets/port.svg',
                            width: Get.width * 0.022,
                            height: Get.height * 0.022,
                            colorFilter: ColorFilter.mode(ports?[0] == 0 ? Colors.orange : ports?[0] == 1 ? Colors.green : ports?[0] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn))
                      else
                        SizedBox(width: Get.width * 0.03, height: Get.height * 0.022),
                      Text(data[0].tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.03))
                    ]
                )
              )
            ),
            Expanded(
              flex: 1,
              child:  SizedBox(
                width: Get.width * 0.06,
                child: Column(
                    children: [
                      if (data[1] != '')
                        SvgPicture.asset('assets/svg_assets/port.svg',
                            width: Get.width * 0.022,
                            height: Get.height * 0.022,
                            colorFilter: ColorFilter.mode(ports?[1] == 0 ? Colors.orange : ports?[1] == 1 ? Colors.green : ports?[1] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn))
                      else
                        SizedBox(width: Get.width * 0.03, height: Get.height * 0.022),
                      Text(data[1].tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.03))
                    ]
                )
              )
            ),
            Expanded(
                flex: 1,
                child:  SizedBox(
                    width: Get.width * 0.06,
                    child: Column(
                        children: [
                          if (data[2] != '')
                            SvgPicture.asset('assets/svg_assets/port.svg',
                                width: Get.width * 0.022,
                                height: Get.height * 0.022,
                                colorFilter: ColorFilter.mode(ports?[2] == 0 ? Colors.orange : ports?[2] == 1 ? Colors.green : ports?[2] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn))
                          else
                            SizedBox(width: Get.width * 0.03, height: Get.height * 0.022),
                          Text(data[2].tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.03))
                        ]
                    )
                )
            ),
            Expanded(
                flex: 1,
                child:  SizedBox(
                    width: Get.width * 0.06,
                    child: Column(
                        children: [
                          if (data[3] != '')
                            SvgPicture.asset('assets/svg_assets/port.svg',
                                width: Get.width * 0.022,
                                height: Get.height * 0.022,
                                colorFilter: ColorFilter.mode(ports?[3] == 0 ? Colors.orange : ports?[3] == 1 ? Colors.green : ports?[3] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn))
                          else
                            SizedBox(width: Get.width * 0.03, height: Get.height * 0.022),
                          Text(data[3].tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.03))
                        ]
                    )
                )
            ),
            Expanded(
                flex: 1, // Occupies 8/12 columns
                child:  SizedBox(
                    width: Get.width * 0.06,
                    child: Column(
                        children: [
                          if (data[4] != '')
                            SvgPicture.asset('assets/svg_assets/port.svg',
                                width: Get.width * 0.022,
                                height: Get.height * 0.022,
                                colorFilter: ColorFilter.mode(ports?[4] == 0 ? Colors.orange : ports?[4] == 1 ? Colors.green : ports?[4] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn))
                          else
                            SizedBox(width: Get.width * 0.03, height: Get.height * 0.022),
                          Text(data[4].tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.03))
                        ]
                    )
                )
            ),
            Expanded(
                flex: 1, // Occupies 8/12 columns
                child:  SizedBox(
                    width: Get.width * 0.06,
                    child: Column(
                        children: [
                          if (data[5] != '')
                            SvgPicture.asset('assets/svg_assets/port.svg',
                                width: Get.width * 0.022,
                                height: Get.height * 0.022,
                                colorFilter: ColorFilter.mode(ports?[5] == 0 ? Colors.orange : ports?[5] == 1 ? Colors.green : ports?[5] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn))
                          else
                            SizedBox(width: Get.width * 0.03, height: Get.height * 0.022),
                          Text(data[5].tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.03))
                        ]
                    )
                )
            )
            ,Expanded(
                flex: 1, // Occupies 8/12 columns
                child:  SizedBox(
                    width: Get.width * 0.06,
                    child: Column(
                        children: [
                          if (data[6] != '')
                            SvgPicture.asset('assets/svg_assets/port.svg',
                                width: Get.width * 0.022,
                                height: Get.height * 0.022,
                                colorFilter: ColorFilter.mode(ports?[6] == 0 ? Colors.orange : ports?[6] == 1 ? Colors.green : ports?[6] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn))
                          else
                            SizedBox(width: Get.width * 0.03, height: Get.height * 0.022),
                          Text(data[6].tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.03))
                        ]
                    )
                )
            ),Expanded(
                flex: 1, // Occupies 8/12 columns
                child:  SizedBox(
                    width: Get.width * 0.06,
                    child: Column(
                        children: [
                          if (data[7] != '')
                            SvgPicture.asset('assets/svg_assets/port.svg',
                                width: Get.width * 0.022,
                                height: Get.height * 0.022,
                                colorFilter: ColorFilter.mode(ports?[7] == 0 ? Colors.orange : ports?[7] == 1 ? Colors.green : ports?[7] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn))
                          else
                            SizedBox(width: Get.width * 0.03, height: Get.height * 0.022),
                          Text(data[7].tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.03))
                        ]
                    )
                )
            ),Expanded(
                flex: 1, // Occupies 8/12 columns
                child:  SizedBox(
                    width: Get.width * 0.06,
                    child: Column(
                        children: [
                          if (data[8] != '')
                            SvgPicture.asset('assets/svg_assets/port.svg',
                                width: Get.width * 0.022,
                                height: Get.height * 0.022,
                                colorFilter: ColorFilter.mode(ports?[8] == 0 ? Colors.orange : ports?[8] == 1 ? Colors.green : ports?[8] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn))
                          else
                            SizedBox(width: Get.width * 0.03, height: Get.height * 0.022),
                          Text(data[8].tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.03))
                        ]
                    )
                )
            ),Expanded(
                flex: 1, // Occupies 8/12 columns
                child:  SizedBox(
                    width: Get.width * 0.06,
                    child: Column(
                        children: [
                          if (data[9] != '')
                            SvgPicture.asset('assets/svg_assets/port.svg',
                                width: Get.width * 0.022,
                                height: Get.height * 0.022,
                                colorFilter: ColorFilter.mode(ports?[9] == 0 ? Colors.orange : ports?[9] == 1 ? Colors.green : ports?[9] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn))
                          else
                            SizedBox(width: Get.width * 0.03, height: Get.height * 0.022),
                          Text(data[9].tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.03))
                        ]
                    )
                )
            ),
            Expanded(
                flex: 1, // Occupies 8/12 columns
                child:  SizedBox(
                    width: Get.width * 0.06,
                    child: Column(
                        children: [
                          if (data[10] != '')
                            SvgPicture.asset('assets/svg_assets/port.svg',
                                width: Get.width * 0.022,
                                height: Get.height * 0.022,
                                colorFilter: ColorFilter.mode(ports?[10] == 0 ? Colors.orange : ports?[10] == 1 ? Colors.green : ports?[10] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn))
                          else
                            SizedBox(width: Get.width * 0.03, height: Get.height * 0.022),
                          Text(data[10].tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.03))
                        ]
                    )
                )
            ),
            Expanded(
                flex: 1, // Occupies 8/12 columns
                child:  SizedBox(
                    width: Get.width * 0.06,
                    child: Column(
                        children: [
                          if (data[11] != '')
                            SvgPicture.asset('assets/svg_assets/port.svg',
                                width: Get.width * 0.022,
                                height: Get.height * 0.022,
                                colorFilter: ColorFilter.mode(ports?[11] == 0 ? Colors.orange : ports?[11] == 1 ? Colors.green : ports?[11] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn))
                          else
                            SizedBox(width: Get.width * 0.03, height: Get.height * 0.022),
                          Text(data[11].tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.03))
                        ]
                    )
                )
            )
          ]
        )
    );
  }
}