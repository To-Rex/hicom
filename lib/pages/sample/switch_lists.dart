import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:hicom/pages/sample/switch_detail.dart';
import 'package:hicom/resource/colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../companents/instrument/instrument_components.dart';
import '../../companents/sample/port_items.dart';
import '../../companents/sample/port_items_16.dart';
import '../../companents/search_fild.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';
import 'add_switch_page.dart';

class SwitchList extends StatelessWidget {
  final String name;
  SwitchList({super.key, required this.name});
  final GetController _getController = Get.put(GetController());
  final RefreshController refreshController = RefreshController(initialRefresh: false);

  void _onLoading() {
    refreshController.loadComplete();
  }

  void _getData() {
    refreshController.refreshCompleted();
    var argument = Get.arguments;
    ApiController().getSwitchList(argument);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Obx(() => Text(_getController.isSearch.value ? ''.tr : 'Qurilma ro’yxati'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.05))),
            leading: Obx(() => IconButton(icon: Icon(_getController.isSearch.value ? Icons.arrow_back : Icons.arrow_back,  size: Get.height * 0.035), onPressed: () => {
              if (_getController.isSearch.value){
                _getController.isSearch.value = !_getController.isSearch.value}
              else Get.back()
            })),
            centerTitle: true,
            actions: [
              Obx(() => _getController.isSearch.value
                  ? SearchFields(onChanged: (String value) {_getController.searchSwitch(value);})
                  : IconButton(icon: Icon(Icons.search, size: Get.height * 0.035), onPressed: () => {_getController.isSearch.value = !_getController.isSearch.value}))
            ]),
        body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            physics: const BouncingScrollPhysics(),
            header: CustomHeader(builder: (BuildContext context, RefreshStatus? mode) {return SizedBox(height: Get.height * 0.1);}),
            footer: CustomFooter(builder: (BuildContext context, LoadStatus? mode) {return SizedBox(height: Get.height * 0.1);}),
            onLoading: _onLoading,
            onRefresh: _getData,
            controller: refreshController,
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Obx(() => _getController.searchProjectModel.value.admin != null || _getController.searchProjectModel.value.join != null
                    ? Column(
                    children: [
                      if (_getController.switchListModel.value.offline != null)
                        ListView.builder(
                            itemCount: _getController.switchListModel.value.offline!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                                  onTap: () => {
                                    //_getController.clearSwitchDetailModel(), Get.to(SwitchDetailPage(sn: _getController.switchListModel.value.offline![index].sn, title: _getController.switchListModel.value.offline![index].name, pidId: Get.arguments))
                                    InstrumentComponents().showToast(Get.context!, 'Diqqat!', 'Qurilma o`chiq'.tr, true, 3)
                                  },
                                  child: Card(
                                      margin: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03, top: Get.height * 0.01),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                      elevation: 5,
                                      color: Theme.of(context).colorScheme.surface,
                                      child: Padding(
                                          padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03, bottom: Get.height * 0.01),
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
                                            if (_getController.switchListModel.value.offline![index].sn != null &&_getController.typeFromSerialNumber(_getController.switchListModel.value.offline![index].sn.toString()) == 7 || _getController.typeFromSerialNumber(_getController.switchListModel.value.offline![index].sn.toString()) == 8)
                                              PortItems16(
                                                  data: _getController.getPortMap(_getController.typeFromSerialNumber(_getController.switchListModel.value.offline![index].sn.toString())),
                                                  ports: _getController.portModification([],_getController.typeFromSerialNumber(_getController.switchListModel.value.offline![index].sn.toString())),
                                                  portsIcons: _getController.getPortTypeIcons(_getController.typeFromSerialNumber(_getController.switchListModel.value.offline![index].sn.toString()))
                                              )
                                            else
                                              PortItems(
                                                  data: _getController.getPortMap(_getController.typeFromSerialNumber(_getController.switchListModel.value.offline![index].sn.toString())),
                                                  ports:_getController.portModification([],_getController.typeFromSerialNumber(_getController.switchListModel.value.offline![index].sn.toString())),
                                                  portsIcons: _getController.getPortTypeIcons(_getController.typeFromSerialNumber(_getController.switchListModel.value.offline![index].sn.toString()))
                                              ),
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
                                  )
                              );
                            }),
                      if (_getController.switchListModel.value.online != null)
                        ListView.builder(
                            itemCount: _getController.switchListModel.value.online!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                                  onTap: () => {_getController.clearSwitchDetailModel(), Get.to(SwitchDetailPage(sn: _getController.switchListModel.value.online![index].sn, title: _getController.switchListModel.value.online![index].name, pidId: Get.arguments))},
                                  child: Card(
                                      margin: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03, top: Get.height * 0.01),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                      elevation: 5,
                                      color: Theme.of(context).colorScheme.surface,
                                      child: Padding(
                                          padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03, bottom: Get.height * 0.01),
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
                                                if (_getController.typeFromSerialNumber(_getController.switchListModel.value.online![index].sn.toString()) == 7 || _getController.typeFromSerialNumber(_getController.switchListModel.value.online![index].sn.toString()) == 8)
                                                 PortItems16(
                                                     data: _getController.getPortMap(_getController.typeFromSerialNumber(_getController.switchListModel.value.online![index].sn.toString())),
                                                     ports: _getController.getPortType(_getController.switchListModel.value.online![index].link,_getController.switchListModel.value.online![index].snr,_getController.typeFromSerialNumber(_getController.switchListModel.value.online![index].sn.toString())),
                                                     portsIcons: _getController.getPortTypeIcons(_getController.typeFromSerialNumber(_getController.switchListModel.value.online![index].sn.toString()))
                                                  )
                                                else
                                                  PortItems(
                                                    data: _getController.getPortMap(_getController.typeFromSerialNumber(_getController.switchListModel.value.online![index].sn.toString())),
                                                    ports: _getController.getPortType(_getController.switchListModel.value.online![index].link,_getController.switchListModel.value.online![index].snr,_getController.typeFromSerialNumber(_getController.switchListModel.value.online![index].sn.toString())),
                                                    portsIcons: _getController.getPortTypeIcons(_getController.typeFromSerialNumber(_getController.switchListModel.value.online![index].sn.toString()))
                                                  ),
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
                                  )
                              );
                            }
                        )
                    ]
                )
                    : Column(children: [
                      SizedBox(
                          height: Get.height* 0.9,
                          width: Get.width,
                          child: Center(child: Text('Loyihalar ro\'yxati'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.05)))
                      )
                ]))
            )
        ),
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