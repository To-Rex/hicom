import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hicom/companents/sample/switch_port_items.dart';

class PortItems16 extends StatelessWidget {

  final List<String> data;
  final List<int>? ports;
  final List<int>? portsIcons;

  const PortItems16({super.key, required this.data, this.ports,required this.portsIcons});

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
        child:  Column(
          children: [
            if (data.isNotEmpty)
              Row(
                children: [
                  SwitchPortItems(ports: ports?[1], name: data[1], portsIcons: portsIcons?[1]),
                  SwitchPortItems(ports: ports?[3], name: data[3], portsIcons: portsIcons?[3]),
                  SwitchPortItems(ports: ports?[5], name: data[5], portsIcons: portsIcons?[5]),
                  SwitchPortItems(ports: ports?[7], name: data[7], portsIcons: portsIcons?[7]),
                  SwitchPortItems(ports: ports?[9], name: data[9], portsIcons: portsIcons?[9]),
                  SwitchPortItems(ports: ports?[11], name: data[11], portsIcons: portsIcons?[11]),
                  SwitchPortItems(ports: ports?[13], name: data[13], portsIcons: portsIcons?[13]),
                  SwitchPortItems(ports: ports?[15], name: data[15], portsIcons: portsIcons?[15]),
                  SwitchPortItems(ports: ports?[17], name: data[17], portsIcons: portsIcons?[17]),
                  SwitchPortItems(ports: ports?[19], name: data[19], portsIcons: portsIcons?[19]),
                  SwitchPortItems(ports: ports?[21], name: data[21], portsIcons: portsIcons?[21]),
                  SwitchPortItems(ports: ports?[23], name: data[23], portsIcons: portsIcons?[23]),
                  Expanded(flex: 1, child: SizedBox(width: Get.width * 0.06))
                ]
            ),
            if (data.isNotEmpty)
              Row(
                children: [
                  SwitchPortItems(ports: ports?[0], name: data[0], portsIcons: portsIcons?[0]),
                  SwitchPortItems(ports: ports?[2], name: data[2], portsIcons: portsIcons?[2]),
                  SwitchPortItems(ports: ports?[4], name: data[4], portsIcons: portsIcons?[4]),
                  SwitchPortItems(ports: ports?[6], name: data[6], portsIcons: portsIcons?[6]),
                  SwitchPortItems(ports: ports?[8], name: data[8], portsIcons: portsIcons?[8]),
                  SwitchPortItems(ports: ports?[10], name: data[10], portsIcons: portsIcons?[10]),
                  SwitchPortItems(ports: ports?[12], name: data[12], portsIcons: portsIcons?[12]),
                  SwitchPortItems(ports: ports?[14], name: data[14], portsIcons: portsIcons?[14]),
                  SwitchPortItems(ports: ports?[16], name: data[16], portsIcons: portsIcons?[16]),
                  SwitchPortItems(ports: ports?[18], name: data[18], portsIcons: portsIcons?[18]),
                  SwitchPortItems(ports: ports?[20], name: data[20], portsIcons: portsIcons?[20]),
                  SwitchPortItems(ports: ports?[22], name: data[22], portsIcons: portsIcons?[22]),
                  Expanded(flex: 1, child: SizedBox(width: Get.width * 0.06))
                ]
            ),
            if (data.isEmpty)
              Row(
                  children: [
                    Expanded(flex: 1, child: SizedBox(width: Get.width * 0.06)),
                    Expanded(
                        flex: 1,
                        child: SizedBox(
                            width: Get.width * 0.06,
                            child: Column(
                                children: [
                                  SvgPicture.asset('assets/svg_assets/port_top.svg',
                                      width: Get.width * 0.022,
                                      height: Get.height * 0.022,
                                      colorFilter: ColorFilter.mode(ports?[1] == 0 ? Colors.orange : ports?[1] == 1 ? Colors.green : ports?[1] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn)
                                  )
                                ]
                            )
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: SizedBox(
                            width: Get.width * 0.06,
                            child: Column(
                                children: [
                                  SvgPicture.asset('assets/svg_assets/port_top.svg',
                                      width: Get.width * 0.022,
                                      height: Get.height * 0.022,
                                      colorFilter: ColorFilter.mode(ports?[1] == 0 ? Colors.orange : ports?[1] == 1 ? Colors.green : ports?[1] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn)
                                  )
                                ]
                            )
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: SizedBox(
                            width: Get.width * 0.06,
                            child: Column(
                                children: [
                                  SvgPicture.asset('assets/svg_assets/port_top.svg',
                                      width: Get.width * 0.022,
                                      height: Get.height * 0.022,
                                      colorFilter: ColorFilter.mode(ports?[1] == 0 ? Colors.orange : ports?[1] == 1 ? Colors.green : ports?[1] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn)
                                  )
                                ]
                            )
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: SizedBox(
                            width: Get.width * 0.06,
                            child: Column(
                                children: [
                                  SvgPicture.asset('assets/svg_assets/port_top.svg',
                                      width: Get.width * 0.022,
                                      height: Get.height * 0.022,
                                      colorFilter: ColorFilter.mode(ports?[1] == 0 ? Colors.orange : ports?[1] == 1 ? Colors.green : ports?[1] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn)
                                  )
                                ]
                            )
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: SizedBox(
                            width: Get.width * 0.06,
                            child: Column(
                                children: [
                                  SvgPicture.asset('assets/svg_assets/port_top.svg',
                                      width: Get.width * 0.022,
                                      height: Get.height * 0.022,
                                      colorFilter: ColorFilter.mode(ports?[1] == 0 ? Colors.orange : ports?[1] == 1 ? Colors.green : ports?[1] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn)
                                  )
                                ]
                            )
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: SizedBox(
                            width: Get.width * 0.06,
                            child: Column(
                                children: [
                                  SvgPicture.asset('assets/svg_assets/port_top.svg',
                                      width: Get.width * 0.022,
                                      height: Get.height * 0.022,
                                      colorFilter: ColorFilter.mode(ports?[1] == 0 ? Colors.orange : ports?[1] == 1 ? Colors.green : ports?[1] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn)
                                  )
                                ]
                            )
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: SizedBox(
                            width: Get.width * 0.06,
                            child: Column(
                                children: [
                                  SvgPicture.asset('assets/svg_assets/port_top.svg',
                                      width: Get.width * 0.022,
                                      height: Get.height * 0.022,
                                      colorFilter: ColorFilter.mode(ports?[1] == 0 ? Colors.orange : ports?[1] == 1 ? Colors.green : ports?[1] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn)
                                  )
                                ]
                            )
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: SizedBox(
                            width: Get.width * 0.06,
                            child: Column(
                                children: [
                                  SvgPicture.asset('assets/svg_assets/port_top.svg',
                                      width: Get.width * 0.022,
                                      height: Get.height * 0.022,
                                      colorFilter: ColorFilter.mode(ports?[1] == 0 ? Colors.orange : ports?[1] == 1 ? Colors.green : ports?[1] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn)
                                  )
                                ]
                            )
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: SizedBox(
                            width: Get.width * 0.06
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: SizedBox(
                            width: Get.width * 0.06,
                            child: Column(
                                children: [
                                  SvgPicture.asset('assets/svg_assets/port_top.svg',
                                      width: Get.width * 0.022,
                                      height: Get.height * 0.022,
                                      colorFilter: ColorFilter.mode(ports?[1] == 0 ? Colors.orange : ports?[1] == 1 ? Colors.green : ports?[1] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn)
                                  )
                                ]
                            )
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: SizedBox(
                            width: Get.width * 0.06,
                            child: Column(
                                children: [
                                  SvgPicture.asset('assets/svg_assets/port_top.svg',
                                      width: Get.width * 0.022,
                                      height: Get.height * 0.022,
                                      colorFilter: ColorFilter.mode(ports?[1] == 0 ? Colors.orange : ports?[1] == 1 ? Colors.green : ports?[1] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn)
                                  )
                                ]
                            )
                        )
                    ),
                    Expanded(flex: 1, child: SizedBox(width: Get.width * 0.01)),
                  ]
              ),
            if (data.isEmpty)
              SizedBox(height: Get.height * 0.01),
            if (data.isEmpty)
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: SizedBox(
                          width: Get.width * 0.06
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: SizedBox(
                          width: Get.width * 0.06,
                          child: Column(
                              children: [
                                SvgPicture.asset('assets/svg_assets/port.svg',
                                    width: Get.width * 0.022,
                                    height: Get.height * 0.022,
                                    colorFilter: ColorFilter.mode(ports?[1] == 0 ? Colors.orange : ports?[1] == 1 ? Colors.green : ports?[1] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn)),
                                Text('1', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.03))
                              ]
                          )
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: SizedBox(
                          width: Get.width * 0.06,
                          child: Column(
                              children: [
                                SvgPicture.asset('assets/svg_assets/port.svg',
                                    width: Get.width * 0.022,
                                    height: Get.height * 0.022,
                                    colorFilter: ColorFilter.mode(ports?[1] == 0 ? Colors.orange : ports?[1] == 1 ? Colors.green : ports?[1] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn)),
                                Text('3', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.03))
                              ]
                          )
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: SizedBox(
                          width: Get.width * 0.06,
                          child: Column(
                              children: [
                                SvgPicture.asset('assets/svg_assets/port.svg',
                                    width: Get.width * 0.022,
                                    height: Get.height * 0.022,
                                    colorFilter: ColorFilter.mode(ports?[1] == 0 ? Colors.orange : ports?[1] == 1 ? Colors.green : ports?[1] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn)),
                                Text('5', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.03))
                              ]
                          )
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: SizedBox(
                          width: Get.width * 0.06,
                          child: Column(
                              children: [
                                SvgPicture.asset('assets/svg_assets/port.svg',
                                    width: Get.width * 0.022,
                                    height: Get.height * 0.022,
                                    colorFilter: ColorFilter.mode(ports?[1] == 0 ? Colors.orange : ports?[1] == 1 ? Colors.green : ports?[1] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn)),
                                Text('7', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.03))
                              ]
                          )
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: SizedBox(
                          width: Get.width * 0.06,
                          child: Column(
                              children: [
                                SvgPicture.asset('assets/svg_assets/port.svg',
                                    width: Get.width * 0.022,
                                    height: Get.height * 0.022,
                                    colorFilter: ColorFilter.mode(ports?[1] == 0 ? Colors.orange : ports?[1] == 1 ? Colors.green : ports?[1] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn)),
                                Text('9', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.03))
                              ]
                          )
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: SizedBox(
                          width: Get.width * 0.06,
                          child: Column(
                              children: [
                                SvgPicture.asset('assets/svg_assets/port.svg',
                                    width: Get.width * 0.022,
                                    height: Get.height * 0.022,
                                    colorFilter: ColorFilter.mode(ports?[1] == 0 ? Colors.orange : ports?[1] == 1 ? Colors.green : ports?[1] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn)),
                                Text('11', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.03))
                              ]
                          )
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: SizedBox(
                          width: Get.width * 0.06,
                          child: Column(
                              children: [
                                SvgPicture.asset('assets/svg_assets/port.svg',
                                    width: Get.width * 0.022,
                                    height: Get.height * 0.022,
                                    colorFilter: ColorFilter.mode(ports?[1] == 0 ? Colors.orange : ports?[1] == 1 ? Colors.green : ports?[1] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn)),
                                Text('13', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.03))
                              ]
                          )
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: SizedBox(
                          width: Get.width * 0.06,
                          child: Column(
                              children: [
                                SvgPicture.asset('assets/svg_assets/port.svg',
                                    width: Get.width * 0.022,
                                    height: Get.height * 0.022,
                                    colorFilter: ColorFilter.mode(ports?[1] == 0 ? Colors.orange : ports?[1] == 1 ? Colors.green : ports?[1] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn)),
                                Text('15', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.03))
                              ]
                          )
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: SizedBox(
                          width: Get.width * 0.06,

                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: SizedBox(
                          width: Get.width * 0.06,
                          child: Column(
                              children: [
                                SvgPicture.asset('assets/svg_assets/port.svg',
                                    width: Get.width * 0.022,
                                    height: Get.height * 0.022,
                                    colorFilter: ColorFilter.mode(ports?[1] == 0 ? Colors.orange : ports?[1] == 1 ? Colors.green : ports?[1] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn)),
                                Text('1', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.03))
                              ]
                          )
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: SizedBox(
                        width: Get.width * 0.06,

                      )
                  ),
                  Expanded(flex: 1, child: SizedBox(width: Get.width * 0.01))
                ]
            ),
          ],
        )
    );
  }
}