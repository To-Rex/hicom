import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class PortItems16 extends StatelessWidget {

  final List<String> data;
  final List<int>? ports;

  const PortItems16({super.key, required this.data, this.ports});

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
                  Expanded(
                      flex: 1,
                      child: SizedBox(
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
                  ),
                  Expanded(
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
                  ),
                  Expanded(
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
                  ),
                  Expanded(
                      flex: 1,
                      child: SizedBox(
                          width: Get.width * 0.06,
                          child: Column(
                              children: [
                                if (data[13] != '')
                                  SvgPicture.asset('assets/svg_assets/port.svg',
                                      width: Get.width * 0.022,
                                      height: Get.height * 0.022,
                                      colorFilter: ColorFilter.mode(ports?[13] == 0 ? Colors.orange : ports?[13] == 1 ? Colors.green : ports?[13] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn))
                                else
                                  SizedBox(width: Get.width * 0.03, height: Get.height * 0.022),
                                Text(data[13].tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.03))
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
                                if (data[15] != '')
                                  SvgPicture.asset('assets/svg_assets/port.svg',
                                      width: Get.width * 0.022,
                                      height: Get.height * 0.022,
                                      colorFilter: ColorFilter.mode(ports?[15] == 0 ? Colors.orange : ports?[15] == 1 ? Colors.green : ports?[15] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn))
                                else
                                  SizedBox(width: Get.width * 0.03, height: Get.height * 0.022),
                                Text(data[15].tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.03))
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
                                if (data[17] != '')
                                  SvgPicture.asset('assets/svg_assets/port.svg',
                                      width: Get.width * 0.022,
                                      height: Get.height * 0.022,
                                      colorFilter: ColorFilter.mode(ports?[17] == 0 ? Colors.orange : ports?[17] == 1 ? Colors.green : ports?[17] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn))
                                else
                                  SizedBox(width: Get.width * 0.03, height: Get.height * 0.022),
                                Text(data[17].tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.03))
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
                                if (data[19] != '')
                                  SvgPicture.asset('assets/svg_assets/port.svg',
                                      width: Get.width * 0.022,
                                      height: Get.height * 0.022,
                                      colorFilter: ColorFilter.mode(ports?[19] == 0 ? Colors.orange : ports?[19] == 1 ? Colors.green : ports?[19] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn))
                                else
                                  SizedBox(width: Get.width * 0.03, height: Get.height * 0.022),
                                Text(data[19].tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.03))
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
                                if (data[21] != '')
                                  SvgPicture.asset('assets/svg_assets/port.svg',
                                      width: Get.width * 0.022,
                                      height: Get.height * 0.022,
                                      colorFilter: ColorFilter.mode(ports?[21] == 0 ? Colors.orange : ports?[21] == 1 ? Colors.green : ports?[21] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn))
                                else
                                  SizedBox(width: Get.width * 0.03, height: Get.height * 0.022),
                                Text(data[21].tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.03))
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
                                if (data[23] != '')
                                  SvgPicture.asset('assets/svg_assets/port.svg',
                                      width: Get.width * 0.022,
                                      height: Get.height * 0.022,
                                      colorFilter: ColorFilter.mode(ports?[23] == 0 ? Colors.orange : ports?[23] == 1 ? Colors.green : ports?[23] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn))
                                else
                                  SizedBox(width: Get.width * 0.03, height: Get.height * 0.022),
                                Text(data[23].tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.03))
                              ]
                          )
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: SizedBox(
                          width: Get.width * 0.06
                      )
                  )
                ]
            ),
            if (data.isNotEmpty)
              Row(
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
                  ),
                  Expanded(
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
                      flex: 1,
                      child: SizedBox(
                          width: Get.width * 0.06,
                          child: Column(
                              children: [
                                if (data[12] != '')
                                  SvgPicture.asset('assets/svg_assets/port.svg',
                                      width: Get.width * 0.022,
                                      height: Get.height * 0.022,
                                      colorFilter: ColorFilter.mode(ports?[12] == 0 ? Colors.orange : ports?[12] == 1 ? Colors.green : ports?[12] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn))
                                else
                                  SizedBox(width: Get.width * 0.03, height: Get.height * 0.022),
                                Text(data[12].tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.03))
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
                                if (data[14] != '')
                                  SvgPicture.asset('assets/svg_assets/port.svg',
                                      width: Get.width * 0.022,
                                      height: Get.height * 0.022,
                                      colorFilter: ColorFilter.mode(ports?[14] == 0 ? Colors.orange : ports?[14] == 1 ? Colors.green : ports?[14] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn))
                                else
                                  SizedBox(width: Get.width * 0.03, height: Get.height * 0.022),
                                Text(data[14].tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.03))
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
                                if (data[16] != '')
                                  SvgPicture.asset('assets/svg_assets/port.svg',
                                      width: Get.width * 0.022,
                                      height: Get.height * 0.022,
                                      colorFilter: ColorFilter.mode(ports?[16] == 0 ? Colors.orange : ports?[16] == 1 ? Colors.green : ports?[16] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn))
                                else
                                  SizedBox(width: Get.width * 0.03, height: Get.height * 0.022),
                                Text(data[16].tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.03))
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
                                if (data[18] != '')
                                  SvgPicture.asset('assets/svg_assets/port.svg',
                                      width: Get.width * 0.022,
                                      height: Get.height * 0.022,
                                      colorFilter: ColorFilter.mode(ports?[18] == 0 ? Colors.orange : ports?[18] == 1 ? Colors.green : ports?[18] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn))
                                else
                                  SizedBox(width: Get.width * 0.03, height: Get.height * 0.022),
                                Text(data[18].tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.03))
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
                                if (data[20] != '')
                                  SvgPicture.asset('assets/svg_assets/port.svg',
                                      width: Get.width * 0.022,
                                      height: Get.height * 0.022,
                                      colorFilter: ColorFilter.mode(ports?[20] == 0 ? Colors.orange : ports?[20] == 1 ? Colors.green : ports?[20] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn))
                                else
                                  SizedBox(width: Get.width * 0.03, height: Get.height * 0.022),
                                Text(data[20].tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.03))
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
                                if (data[22] != '')
                                  SvgPicture.asset('assets/svg_assets/port.svg',
                                      width: Get.width * 0.022,
                                      height: Get.height * 0.022,
                                      colorFilter: ColorFilter.mode(ports?[22] == 0 ? Colors.orange : ports?[22] == 1 ? Colors.green : ports?[22] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn))
                                else
                                  SizedBox(width: Get.width * 0.03, height: Get.height * 0.022),
                                Text(data[22].tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.03))
                              ]
                          )
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: SizedBox(
                          width: Get.width * 0.06
                      )
                  )
                ]
            ),
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
                                  SvgPicture.asset('assets/svg_assets/port.svg',
                                      width: Get.width * 0.022,
                                      height: Get.height * 0.022,
                                      colorFilter: ColorFilter.mode(ports?[1] == 0 ? Colors.orange : ports?[1] == 1 ? Colors.green : ports?[1] == 2 ? Colors.yellow : Theme.of(context).colorScheme.onSurface, BlendMode.srcIn)),
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
                                ]
                            )
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: SizedBox(
                            width: Get.width * 0.01,

                        )
                    ),
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
                  Expanded(
                      flex: 1,
                      child: SizedBox(
                        width: Get.width * 0.01,
                      )
                  )
                ]
            ),
          ],
        )
    );
  }
}