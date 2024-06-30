import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:hicom/pages/sample/switch_detail.dart';
import 'package:hicom/resource/colors.dart';
import '../../companents/instrument/instrument_components.dart';
import '../../companents/sample/port_items.dart';
import '../../controllers/get_controller.dart';
import 'add_switch_page.dart';

class SwitchList extends StatelessWidget {
  final int lsc;
  SwitchList({super.key, required this.lsc});
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {

    debugPrint('type: ${_getController.typeFromSerialNumber('HIM42ECM11234700492BEKP5E')}');
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Qurilma ro’yxati'.tr),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.search, size: _getController.height.value * 0.035), onPressed: () => {_getController.isSearch.value = !_getController.isSearch.value})
        ]
      ),
      body: Obx(() =>  Column(
          children: [
            if (_getController.switchListModel.value.offline != null)
              ListView.builder(
                  itemCount: _getController.switchListModel.value.offline!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => {
                        Get.to(SwitchDetailPage(sn: _getController.switchListModel.value.online![index].sn, title: _getController.switchListModel.value.online![index].name, pidId: Get.arguments))
                      },
                      child: Container(
                          margin: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03, top: _getController.height.value * 0.01),
                          padding: EdgeInsets.all(_getController.height.value * 0.015),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.surface,
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
                                        color: Theme.of(context).colorScheme.surface,
                                        surfaceTintColor: Colors.transparent,
                                        elevation: 4,
                                        onSelected: (String value) {
                                          switch (value) {
                                            case 'edit':
                                              _getController.nameProjectController.text = _getController.projectModel.value.admin![index].name.toString();
                                              _getController.noteProjectController.text = _getController.projectModel.value.admin![index].note.toString();
                                              //bottomSwitchEditName(pidId,Index)
                                              InstrumentComponents().bottomSwitchEditName(context,Get.arguments,_getController.switchListModel.value.offline![index].sn, index,false);
                                              break;
                                            case 'delete':
                                              InstrumentComponents().deleteSwitch(context, Get.arguments,_getController.switchListModel.value.offline![index].sn);
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
                              //PortItems(data: const ['1', '2', '3', '4', '5', '6', '7', '8', '', 'L1', 'L2', 'SFF']),
                              PortItems(data: _getController.getPortMap(_getController.typeFromSerialNumber(_getController.switchListModel.value.offline![index].sn.toString()))),
                              Row(
                                children: [
                                  Text('${'MAC'.tr} ${_getController.switchListModel.value.offline![index].mac}'),
                                  const Spacer(),
                                  Text(_getController.maskString(_getController.switchListModel.value.offline![index].sn.toString())),
                                ],
                              )
                            ],
                          )
                      )
                    );
                  }
              ),
            if (_getController.switchListModel.value.online != null)
              ListView.builder(
                  itemCount: _getController.switchListModel.value.online!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => {
                        Get.to(SwitchDetailPage(sn: _getController.switchListModel.value.online![index].sn, title: _getController.switchListModel.value.online![index].name, pidId: Get.arguments)),
                      },
                      child: Container(
                          margin: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03, top: _getController.height.value * 0.01),
                          padding: EdgeInsets.all(_getController.height.value * 0.015),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Theme.of(context).colorScheme.surface),
                          child: Column(
                              children: [
                                Row(
                                    children: [
                                      Text(_getController.switchListModel.value.online![index].name.toString(), style: TextStyle(fontSize:Get.textTheme.bodyMedium!.fontSize)),
                                      const Spacer(),
                                      Icon(TablerIcons.circle_filled, color: AppColors.green, size: Get.width * 0.025),
                                      PopupMenuButton<String>(
                                          icon: Icon(TablerIcons.dots, size: _getController.width.value * 0.05),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                          color: Theme.of(context).colorScheme.surface,
                                          surfaceTintColor: Colors.transparent,
                                          elevation: 4,
                                          onSelected: (String value) {
                                            switch (value) {
                                              case 'edit':
                                                _getController.nameProjectController.text = _getController.projectModel.value.admin![index].name.toString();
                                                _getController.noteProjectController.text = _getController.projectModel.value.admin![index].note.toString();
                                                //bottomSwitchEditName(pidId,Index)
                                                InstrumentComponents().bottomSwitchEditName(context,Get.arguments,_getController.switchListModel.value.online![index].sn, index,false);
                                                break;
                                              case 'delete':
                                                InstrumentComponents().deleteSwitch(context, Get.arguments,_getController.switchListModel.value.online![index].sn);
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
                                //PortItems(data: const ['1', '2', '3', '4', '5', '6', '7', '8', '', 'L1', 'L2', 'SFF']),
                                //PortItems(data: _getController.getPortMap(1)),
                                PortItems(data: _getController.getPortMap(_getController.typeFromSerialNumber(_getController.switchListModel.value.online![index].sn.toString()))),
                                Row(
                                    children: [
                                      Text('${'MAC'.tr} ${_getController.switchListModel.value.online![index].mac}',style: TextStyle(fontSize: Get.textTheme.bodySmall!.fontSize)),
                                      const Spacer(),
                                      Text(_getController.maskString(_getController.switchListModel.value.online![index].sn.toString(),),style: TextStyle(fontSize: Get.textTheme.bodySmall!.fontSize)),
                                    ]
                                )
                              ]
                          )
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
          onPressed: () {
            Get.to(AddSwitchPage(), arguments: Get.arguments);
          },
          child: const Icon(Icons.add)
        )
    );
  }
}