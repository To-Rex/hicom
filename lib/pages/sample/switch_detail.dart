import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:hicom/controllers/api_controller.dart';
import 'package:hicom/resource/colors.dart';
import '../../companents/sample/port_items.dart';
import '../../controllers/get_controller.dart';

class SwitchDetailPage extends StatelessWidget {
  final String? pidId;
  final String? sn;
  final String? title;
  SwitchDetailPage({super.key, this.pidId, this.sn, this.title});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    ApiController().getSwitchDetail(Get.arguments, sn);
    _getController.tabController = TabController(length: 3, vsync: Navigator.of(context) as TickerProvider);
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.9),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Qurilma Xaqida'.tr),
          centerTitle: true,
          actions: [
            IconButton(icon: Icon(Icons.settings, size: _getController.height.value * 0.035), onPressed: () => {_getController.isSearch.value = !_getController.isSearch.value})
          ],
        ),
      body: Column(
        children: [
          Center(child: Text(title!, style: TextStyle(fontSize: Get.textTheme.headlineSmall!.fontSize, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface))),
          SizedBox(height: _getController.height.value * 0.02),
          Padding(padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
            child: PortItems(data: const ['1', '2', '3', '4', '5', '6', '7', '8', '', 'L1', 'L2', 'SFF']),
          ),
          Padding(padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03, top: _getController.height.value * 0.01),
            child: Row(
              children: [
                InkWell(
                    child: Row(
                      children: [
                        Icon(TablerIcons.info_circle, color: AppColors.blue, size: Get.textTheme.headlineSmall!.fontSize),
                        SizedBox(width: _getController.width.value * 0.01),
                        Text('Portlar holati xaqida'.tr, style: TextStyle(color: AppColors.blue, fontSize: Get.textTheme.bodyMedium!.fontSize, fontWeight: FontWeight.w500))
                      ]
                    )
                ),
                const Spacer(),
                Text('MTU VLAN'.tr, style: TextStyle(color: AppColors.blue, fontSize: Get.textTheme.bodyMedium!.fontSize, fontWeight: FontWeight.w500)),
                SizedBox(width: _getController.width.value * 0.01),
                CupertinoSwitch(
                    activeColor: AppColors.green,
                    trackColor: Colors.grey.withOpacity(0.5),
                    focusColor: AppColors.green,
                    thumbColor: Theme.of(context).colorScheme.surface,
                    applyTheme: true,
                    onChanged: (value) {}, value: false
                ),
              ]
            )
          ),
          Padding(
              padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03,top: Get.height * 0.03, bottom: Get.height * 0.02),
              child: Column(
                children: [
                  Container(
                      constraints: BoxConstraints.expand(height:  Get.height * 0.07),
                      padding: EdgeInsets.all(Get.height * 0.01),
                      decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1), borderRadius: BorderRadius.circular(11)),
                      child: TabBar(
                          indicatorSize: TabBarIndicatorSize.tab,
                          dividerColor: Colors.transparent,
                          controller: _getController.tabController,
                          labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.textTheme.bodyMedium!.fontSize, fontWeight: FontWeight.w500),
                          unselectedLabelColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                          indicator: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(11), boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.surface.withOpacity(0.1), spreadRadius: 2, blurRadius: 2, offset: const Offset(0, 2))]),
                          tabs: [
                            Tab(child: SizedBox(width: Get.width * 0.6, child: Center(child: Text('Ma\'lumotlar'.tr,maxLines: 1,overflow: TextOverflow.ellipsis)))),
                            Tab(child: SizedBox(width: Get.width * 0.6, child: Center(child: Text('Portlar'.tr,maxLines: 1,overflow: TextOverflow.ellipsis)))),
                            Tab(child: SizedBox(width: Get.width * 0.6, child: Center(child: Text('Sozlamalar'.tr,maxLines: 1,overflow: TextOverflow.ellipsis))))
                          ]
                      )
                  )
                ],
              )
          ),
          Expanded(
              child: TabBarView(
                controller: _getController.tabController,
                children: [
                  Column(
                    children: [

                    ],
                  ),
                  Container(
                    width: Get.width,
                    child: Text('Portlar'.tr),
                  ),
                  Container(
                    width: Get.width,
                    child: Text('Sozlamalar'.tr),
                  ),
                ],
              )
          )

        ],
      )
    );
  }
}