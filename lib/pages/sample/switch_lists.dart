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
  final String name;
  SwitchList({super.key, required this.name});
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Qurilma ro’yxati'.tr),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.search, size: Get.height * 0.035), onPressed: () => {_getController.isSearch.value = !_getController.isSearch.value})
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
                          margin: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03, top: Get.height * 0.01),
                          padding: EdgeInsets.all(Get.height * 0.015),
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
                                    Icon(TablerIcons.circle_filled, color: Theme.of(context).colorScheme.error, size: Get.width * 0.025),
                                    PopupMenuButton<String>(
                                        icon: Icon(TablerIcons.dots, size: Get.width * 0.05),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                        color: Theme.of(context).colorScheme.surface,
                                        surfaceTintColor: Colors.transparent,
                                        elevation: 4,
                                        onSelected: (String value) {
                                          switch (value) {
                                            case 'edit':
                                              _getController.nameProjectController.text = _getController.switchListModel.value.offline![index].name.toString();
                                              _getController.noteProjectController.text = _getController.switchListModel.value.offline![index].note.toString();
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
                                                height: Get.height * 0.03,
                                                value: 'edit',
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.edit, size: Get.width * 0.04),
                                                    SizedBox(width: Get.width * 0.015),
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
                                                height: Get.height * 0.03,
                                                value: 'delete',
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.delete, size: Get.width * 0.04, color: Theme.of(context).colorScheme.error),
                                                    SizedBox(width: Get.width * 0.015),
                                                    Text('O\'chirish'.tr, style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: Get.width * 0.04))
                                                  ],
                                                )
                                            )
                                          ];
                                        }
                                    )
                                  ]
                              ),
                              PortItems(data: _getController.getPortMap(_getController.typeFromSerialNumber(_getController.switchListModel.value.online![index].sn.toString())), ports: _getController.getPortType(_getController.switchListModel.value.online![index].link,_getController.switchListModel.value.online![index].snr,_getController.typeFromSerialNumber(_getController.switchListModel.value.online![index].sn.toString())),),
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
                          margin: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03, top: Get.height * 0.01),
                          padding: EdgeInsets.all(Get.height * 0.015),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Theme.of(context).colorScheme.surface),
                          child: Column(
                              children: [
                                Row(
                                    children: [
                                      Text(_getController.switchListModel.value.online![index].name.toString(), style: TextStyle(fontSize:Get.textTheme.bodyMedium!.fontSize)),
                                      const Spacer(),
                                      Icon(TablerIcons.circle_filled, color: AppColors.green, size: Get.width * 0.025),
                                      PopupMenuButton<String>(
                                          icon: Icon(TablerIcons.dots, size: Get.width * 0.05),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                          color: Theme.of(context).colorScheme.surface,
                                          surfaceTintColor: Colors.transparent,
                                          elevation: 4,
                                          onSelected: (String value) {
                                            switch (value) {
                                              case 'edit':
                                                _getController.nameProjectController.text = _getController.switchListModel.value.online![index].name.toString();
                                                _getController.noteProjectController.text = _getController.switchListModel.value.online![index].note.toString();
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
                                                  height: Get.height * 0.03,
                                                  value: 'edit',
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.edit, size: Get.width * 0.04),
                                                      SizedBox(width: Get.width * 0.015),
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
                                                  height: Get.height * 0.03,
                                                  value: 'delete',
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.delete, size: Get.width * 0.04, color: Theme.of(context).colorScheme.error),
                                                      SizedBox(width: Get.width * 0.015),
                                                      Text('O\'chirish'.tr, style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: Get.width * 0.04))
                                                    ],
                                                  )
                                              )
                                            ];
                                          }
                                      )
                                    ]
                                ),
                                PortItems(data: _getController.getPortMap(_getController.typeFromSerialNumber(_getController.switchListModel.value.online![index].sn.toString())), ports: _getController.getPortType(_getController.switchListModel.value.online![index].link,_getController.switchListModel.value.online![index].snr,_getController.typeFromSerialNumber(_getController.switchListModel.value.online![index].sn.toString()))),
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
            _getController.nameProjectController.text = name;
            Get.to(AddSwitchPage(), arguments: Get.arguments);
          },
          child: const Icon(Icons.add)
        )
    );
  }
}