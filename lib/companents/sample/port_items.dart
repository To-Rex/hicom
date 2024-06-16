import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controllers/get_controller.dart';

class PortItems extends StatelessWidget {

  final List<String> data;

  PortItems({super.key, required this.data});

  final GetController _getController = Get.put(GetController());
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5), width: _getController.height.value * 0.003),
            color: Theme.of(context).colorScheme.background
        ),
        margin: EdgeInsets.only(bottom: _getController.height.value * 0.01),
        padding: EdgeInsets.all(_getController.height.value * 0.01),
        /*child: Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        children: [
                          if (one != '')
                            SvgPicture.asset('assets/svg_assets/port.svg', width: _getController.width.value * 0.022, height: _getController.height.value * 0.022,colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground, BlendMode.srcIn))
                          else
                            SizedBox(width: _getController.width.value * 0.03, height: _getController.height.value * 0.022),
                          Text(one.tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.03))
                        ]
                    ),
                    Column(
                        children: [
                          SvgPicture.asset('assets/svg_assets/port.svg', width: _getController.width.value * 0.022, height: _getController.height.value * 0.022,colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground, BlendMode.srcIn)),
                          Text(two.tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.03))
                        ]
                    ),
                    Column(
                        children: [
                          SvgPicture.asset('assets/svg_assets/port.svg', width: _getController.width.value * 0.022, height: _getController.height.value * 0.022,colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground, BlendMode.srcIn)),
                          Text(three.tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.03))
                        ]
                    ),
                    Column(
                        children: [
                          SvgPicture.asset('assets/svg_assets/port.svg', width: _getController.width.value * 0.022, height: _getController.height.value * 0.022,colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground, BlendMode.srcIn)),
                          Text(four.tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.03))
                        ]
                    ),
                    Column(
                        children: [
                          SvgPicture.asset('assets/svg_assets/port.svg', width: _getController.width.value * 0.022, height: _getController.height.value * 0.022,colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground, BlendMode.srcIn)),
                          Text(five.tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.03))
                        ]
                    ),
                    Column(
                        children: [
                          SvgPicture.asset('assets/svg_assets/port.svg', width: _getController.width.value * 0.022, height: _getController.height.value * 0.022,colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground, BlendMode.srcIn)),
                          Text(six.tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.03))
                        ]
                    ),
                    Column(
                        children: [
                          SvgPicture.asset('assets/svg_assets/port.svg', width: _getController.width.value * 0.022, height: _getController.height.value * 0.022,colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground, BlendMode.srcIn)),
                          Text(seven.tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.03))
                        ]
                    ),
                    Column(
                        children: [
                          SvgPicture.asset('assets/svg_assets/port.svg', width: _getController.width.value * 0.022, height: _getController.height.value * 0.022,colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground, BlendMode.srcIn)),
                          Text(eight.tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.03))
                        ]
                    ),
                    Column(
                        children: [
                          if (nine != '')
                            SvgPicture.asset('assets/svg_assets/port.svg', width: _getController.width.value * 0.022, height: _getController.height.value * 0.022,colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground, BlendMode.srcIn))
                          else
                            SizedBox(width: _getController.width.value * 0.03, height: _getController.height.value * 0.022),
                          Text(nine.tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.03))
                        ]
                    ),
                    Column(
                        children: [
                          SvgPicture.asset('assets/svg_assets/port.svg', width: _getController.width.value * 0.022, height: _getController.height.value * 0.022,colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground, BlendMode.srcIn)),
                          Text(ten.tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.03))
                        ]
                    ),
                    Column(
                        children: [
                          SvgPicture.asset('assets/svg_assets/port.svg', width: _getController.width.value * 0.022, height: _getController.height.value * 0.022,colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground, BlendMode.srcIn)),
                          Text(eleven.tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.03))
                        ]
                    ),
                    Column(
                        children: [
                          SvgPicture.asset('assets/svg_assets/port.svg', width: _getController.width.value * 0.022, height: _getController.height.value * 0.022,colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground, BlendMode.srcIn)),
                          Text(twelve.tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.03))
                        ]
                    )
                  ]
              )

            ]
        )*/
        child:  Row(
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                width: _getController.width.value * 0.06,
                child: Column(
                    children: [
                      if (data[0] != '')
                        SvgPicture.asset('assets/svg_assets/port.svg', width: _getController.width.value * 0.022, height: _getController.height.value * 0.022,colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground, BlendMode.srcIn))
                      else
                        SizedBox(width: _getController.width.value * 0.03, height: _getController.height.value * 0.022),
                      Text(data[0].tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.03))
                    ]
                )
              )
            ),
            Expanded(
              flex: 1,
              child:  SizedBox(
                width: _getController.width.value * 0.06,
                child: Column(
                    children: [
                      if (data[1] != '')
                        SvgPicture.asset('assets/svg_assets/port.svg', width: _getController.width.value * 0.022, height: _getController.height.value * 0.022,colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground, BlendMode.srcIn))
                      else
                        SizedBox(width: _getController.width.value * 0.03, height: _getController.height.value * 0.022),
                      Text(data[1].tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.03))
                    ]
                )
              )
            ),
            Expanded(
                flex: 1,
                child:  SizedBox(
                    width: _getController.width.value * 0.06,
                    child: Column(
                        children: [
                          if (data[2] != '')
                            SvgPicture.asset('assets/svg_assets/port.svg', width: _getController.width.value * 0.022, height: _getController.height.value * 0.022,colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground, BlendMode.srcIn))
                          else
                            SizedBox(width: _getController.width.value * 0.03, height: _getController.height.value * 0.022),
                          Text(data[2].tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.03))
                        ]
                    )
                )
            ),
            Expanded(
                flex: 1,
                child:  SizedBox(
                    width: _getController.width.value * 0.06,
                    child: Column(
                        children: [
                          if (data[3] != '')
                            SvgPicture.asset('assets/svg_assets/port.svg', width: _getController.width.value * 0.022, height: _getController.height.value * 0.022,colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground, BlendMode.srcIn))
                          else
                            SizedBox(width: _getController.width.value * 0.03, height: _getController.height.value * 0.022),
                          Text(data[3].tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.03))
                        ]
                    )
                )
            ),
            Expanded(
                flex: 1, // Occupies 8/12 columns
                child:  SizedBox(
                    width: _getController.width.value * 0.06,
                    child: Column(
                        children: [
                          if (data[4] != '')
                            SvgPicture.asset('assets/svg_assets/port.svg', width: _getController.width.value * 0.022, height: _getController.height.value * 0.022,colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground, BlendMode.srcIn))
                          else
                            SizedBox(width: _getController.width.value * 0.03, height: _getController.height.value * 0.022),
                          Text(data[4].tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.03))
                        ]
                    )
                )
            ),
            Expanded(
                flex: 1, // Occupies 8/12 columns
                child:  SizedBox(
                    width: _getController.width.value * 0.06,
                    child: Column(
                        children: [
                          if (data[5] != '')
                            SvgPicture.asset('assets/svg_assets/port.svg', width: _getController.width.value * 0.022, height: _getController.height.value * 0.022,colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground, BlendMode.srcIn))
                          else
                            SizedBox(width: _getController.width.value * 0.03, height: _getController.height.value * 0.022),
                          Text(data[5].tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.03))
                        ]
                    )
                )
            )
            ,Expanded(
                flex: 1, // Occupies 8/12 columns
                child:  SizedBox(
                    width: _getController.width.value * 0.06,
                    child: Column(
                        children: [
                          if (data[6] != '')
                            SvgPicture.asset('assets/svg_assets/port.svg', width: _getController.width.value * 0.022, height: _getController.height.value * 0.022,colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground, BlendMode.srcIn))
                          else
                            SizedBox(width: _getController.width.value * 0.03, height: _getController.height.value * 0.022),
                          Text(data[6].tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.03))
                        ]
                    )
                )
            ),Expanded(
                flex: 1, // Occupies 8/12 columns
                child:  SizedBox(
                    width: _getController.width.value * 0.06,
                    child: Column(
                        children: [
                          if (data[7] != '')
                            SvgPicture.asset('assets/svg_assets/port.svg', width: _getController.width.value * 0.022, height: _getController.height.value * 0.022,colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground, BlendMode.srcIn))
                          else
                            SizedBox(width: _getController.width.value * 0.03, height: _getController.height.value * 0.022),
                          Text(data[7].tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.03))
                        ]
                    )
                )
            ),Expanded(
                flex: 1, // Occupies 8/12 columns
                child:  SizedBox(
                    width: _getController.width.value * 0.06,
                    child: Column(
                        children: [
                          if (data[8] != '')
                            SvgPicture.asset('assets/svg_assets/port.svg', width: _getController.width.value * 0.022, height: _getController.height.value * 0.022,colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground, BlendMode.srcIn))
                          else
                            SizedBox(width: _getController.width.value * 0.03, height: _getController.height.value * 0.022),
                          Text(data[8].tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.03))
                        ]
                    )
                )
            ),Expanded(
                flex: 1, // Occupies 8/12 columns
                child:  SizedBox(
                    width: _getController.width.value * 0.06,
                    child: Column(
                        children: [
                          if (data[9] != '')
                            SvgPicture.asset('assets/svg_assets/port.svg', width: _getController.width.value * 0.022, height: _getController.height.value * 0.022,colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground, BlendMode.srcIn))
                          else
                            SizedBox(width: _getController.width.value * 0.03, height: _getController.height.value * 0.022),
                          Text(data[9].tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.03))
                        ]
                    )
                )
            ),
            Expanded(
                flex: 1, // Occupies 8/12 columns
                child:  SizedBox(
                    width: _getController.width.value * 0.06,
                    child: Column(
                        children: [
                          if (data[10] != '')
                            SvgPicture.asset('assets/svg_assets/port.svg', width: _getController.width.value * 0.022, height: _getController.height.value * 0.022,colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground, BlendMode.srcIn))
                          else
                            SizedBox(width: _getController.width.value * 0.03, height: _getController.height.value * 0.022),
                          Text(data[10].tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.03))
                        ]
                    )
                )
            ),
            Expanded(
                flex: 1, // Occupies 8/12 columns
                child:  SizedBox(
                    width: _getController.width.value * 0.06,
                    child: Column(
                        children: [
                          if (data[11] != '')
                            SvgPicture.asset('assets/svg_assets/port.svg', width: _getController.width.value * 0.022, height: _getController.height.value * 0.022,colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground, BlendMode.srcIn))
                          else
                            SizedBox(width: _getController.width.value * 0.03, height: _getController.height.value * 0.022),
                          Text(data[11].tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.03))
                        ]
                    )
                )
            )
          ]
        )
    );
  }
}