import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../companents/sample/port_items.dart';
import '../../controllers/get_controller.dart';

class SwitchList extends StatelessWidget {
  SwitchList({super.key});
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background.withOpacity(0.9),
      appBar: AppBar(
        title: Text('Qurilma ro’yxati'.tr),
        centerTitle: true,
      ),
      body: Obx(() =>  Column(
          children: [
            //if (_getController.projectModel.value.admin != null || _getController.projectModel.value.join != null)
            if (_getController.switchListModel.value.offline != null)
              ListView.builder(
                  itemCount: _getController.switchListModel.value.offline!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(left: _getController.width.value * 0.02, right: _getController.width.value * 0.02, top: _getController.height.value * 0.01),
                      padding: EdgeInsets.all(_getController.height.value * 0.015),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.background,
                      ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(_getController.switchListModel.value.offline![index].name.toString()),
                                const Spacer(),
                                Icon(TablerIcons.circle_filled, color: Theme.of(context).colorScheme.error, size: _getController.width.value * 0.025),
                                PopupMenuButton<String>(
                                    icon: Icon(TablerIcons.dots, size: _getController.width.value * 0.05),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                    color: Theme.of(context).colorScheme.background,
                                    surfaceTintColor: Colors.transparent,
                                    elevation: 4,
                                    onSelected: (String value) {
                                      switch (value) {
                                        case 'edit':
                                          break;
                                        case 'delete':
                                          break;
                                      }
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return [
                                        PopupMenuItem(
                                          height: _getController.height.value * 0.03,
                                            value: 'edit',
                                            child: Row(
                                              children: [
                                                Icon(Icons.edit, size: _getController.width.value * 0.04),
                                                SizedBox(width: _getController.width.value * 0.015),
                                                Text('Tahrirlash'.tr)
                                              ],
                                            )
                                        ),
                                        const PopupMenuItem(
                                          height: 0,
                                          padding: EdgeInsets.all(0),
                                          value: 'watcher',
                                          child: Divider(),
                                        ),
                                        PopupMenuItem(
                                          height: _getController.height.value * 0.03,
                                            value: 'delete',
                                            child: Row(
                                              children: [
                                                Icon(Icons.delete, size: _getController.width.value * 0.04, color: Theme.of(context).colorScheme.error),
                                                SizedBox(width: _getController.width.value * 0.015),
                                                Text('O\'chirish'.tr, style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: _getController.width.value * 0.04))
                                              ],
                                            )
                                        )
                                      ];
                                    }
                                )
                              ]
                            ),
                            PortItems(one: '1', two: '2', three: '3', four: '4', five: '5', six: '6', seven: '7', eight: '8', nine: '', ten: 'L1', eleven: 'L2', twelve: 'SFF'),
                            Row(
                              children: [
                                Text('${'MAC'.tr} ${_getController.switchListModel.value.offline![index].mac}'),
                                const Spacer(),
                                Text(_getController.switchListModel.value.offline![index].sn.toString()),
                              ],
                            )
                          ],
                        )
                    );
                  }
              )
          ]
      )),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: Colors.blue,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          onPressed: () {},
          child: const Icon(Icons.add),
        )
    );
  }
}