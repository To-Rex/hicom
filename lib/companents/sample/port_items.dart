import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controllers/get_controller.dart';

class PortItems extends StatelessWidget {

  final String one; //1
  final String two; //2
  final String three; //3
  final String four; //4
  final String five; //5
  final String six; //6
  final String seven; //7
  final String eight; //8
  final String nine; //9
  final String ten; //10
  final String eleven; //11
  final String twelve; //12

  PortItems({super.key, required this.one, required this.two, required this.three, required this.four, required this.five, required this.six, required this.seven, required this.eight, required this.nine, required this.ten, required this.eleven, required this.twelve});

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
        child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      children: [
                        SvgPicture.asset('assets/svg_assets/port.svg', width: _getController.width.value * 0.022, height: _getController.height.value * 0.022,colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground, BlendMode.srcIn)),
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
                        SvgPicture.asset('assets/svg_assets/port.svg', width: _getController.width.value * 0.022, height: _getController.height.value * 0.022,colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground, BlendMode.srcIn)),
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
        )
    );
  }
}