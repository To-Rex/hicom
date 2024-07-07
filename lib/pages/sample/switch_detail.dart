import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:hicom/controllers/api_controller.dart';
import 'package:hicom/resource/colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../companents/instrument/instrument_components.dart';
import '../../companents/sample/item_data.dart';
import '../../companents/sample/item_port_data.dart';
import '../../companents/sample/item_settings_data.dart';
import '../../companents/sample/port_items.dart';
import '../../companents/sample/port_items_16.dart';
import '../../controllers/get_controller.dart';

class SwitchDetailPage extends StatelessWidget {
  final String? pidId;
  final String? sn;
  final String? title;

  SwitchDetailPage({super.key, required this.pidId,required  this.sn,required  this.title});

  final GetController _getController = Get.put(GetController());
  final RefreshController refreshController = RefreshController(initialRefresh: false);

  void _onLoading() {
    refreshController.loadComplete();
  }

  void _getData() {
    refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    _getController.whileApi.value = true;
    ApiController().getSwitchDetail(pidId.toString(), sn.toString(),true);
    _getController.tabController = TabController(length: 3, vsync: Navigator.of(context) as TickerProvider);
    _getController.tabController.animateTo(1);
    return PopScope(
      canPop: false,
      onPopInvoked : (didPop){
        _getController.whileApi.value = false;
        if (didPop) {
          return;
        }
        Get.back();
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text('Qurilma Xaqida'.tr),
            centerTitle: true,
            leading: IconButton(icon: Icon(Icons.arrow_back_ios, size:Get.height * 0.035), onPressed: () => {Get.back()}),
            actions: [
              IconButton(icon: Icon(Icons.settings, size: Get.height * 0.035), onPressed: () => {Get.back()})
            ],
          ),
          body: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              physics: const BouncingScrollPhysics(),
              header: CustomHeader(builder: (BuildContext context, RefreshStatus? mode) {return SizedBox(height: Get.height * 0.1);}),
              footer: CustomFooter(builder: (BuildContext context, LoadStatus? mode) {return SizedBox(height: Get.height * 0.1);}),
              onLoading: _onLoading,
              onRefresh: _getData,
              controller: refreshController,
              child: Obx(() => _getController.searchProjectModel.value.admin != null || _getController.searchProjectModel.value.join != null
                  ? Column(
                  children: [
                    Center(child: Text(title!, style: TextStyle(fontSize: Get.textTheme.headlineSmall!.fontSize, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface))),
                    SizedBox(height: Get.height * 0.02),
                    Padding(padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
                        child: _getController.switchDetailModel.value.detail!.link!.length >= 16
                            ? PortItems16(data: _getController.getPortMap(_getController.typeFromSerialNumber(sn!)), ports: _getController.getPortType(_getController.switchDetailModel.value.detail!.link,_getController.switchDetailModel.value.detail!.snr,_getController.typeFromSerialNumber(sn!)))
                            : PortItems(
                            data: _getController.getPortMap(_getController.typeFromSerialNumber(sn!)),ports: _getController.getPortType(_getController.switchDetailModel.value.detail!.link,_getController.switchDetailModel.value.detail!.snr,_getController.typeFromSerialNumber(sn!))
                        )
                    ),

                    Padding(padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03, top: Get.height * 0.01),
                        child: Row(
                            children: [
                              InkWell(
                                  onTap: () {
                                    InstrumentComponents().infoPortDialog(context);
                                  },
                                  child: Row(
                                      children: [
                                        Icon(TablerIcons.info_circle, color: AppColors.blue, size: Get.textTheme.headlineSmall!.fontSize),
                                        SizedBox(width: Get.width * 0.01),
                                        Text('Portlar holati xaqida'.tr, style: TextStyle(color: AppColors.blue, fontSize: Get.textTheme.bodyMedium!.fontSize, fontWeight: FontWeight.w500))
                                      ]
                                  )
                              ),
                              const Spacer(),
                              Text('MTU VLAN'.tr, style: TextStyle(color: Get.theme.colorScheme.onSurface, fontSize: Get.textTheme.bodyMedium!.fontSize, fontWeight: FontWeight.w500)),
                              SizedBox(width: Get.width * 0.01),
                              CupertinoSwitch(
                                  activeColor: AppColors.green,
                                  trackColor: Colors.grey.withOpacity(0.5),
                                  focusColor: AppColors.green,
                                  thumbColor: Theme.of(context).colorScheme.surface,
                                  applyTheme: true,
                                  onChanged: (value) {
                                    //getSwF
                                    ApiController().getSwF(pidId!, sn!);
                                  }, value: false
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
                                    overlayColor: WidgetStateProperty.all(Colors.transparent),
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
                            if (_getController.switchDetailModel.value.detail != null)
                              Padding(
                                  padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03,top: Get.height * 0.03, bottom: Get.height * 0.02),
                                  child: Column(
                                      children: [
                                        ItemData(title: 'Qurilma modeli'.tr, subtitle: _getController.getTypeName(_getController.typeFromSerialNumber(sn!))),
                                        SizedBox(height: Get.height * 0.015),
                                        ItemData(title: 'Seriya raqami'.tr, subtitle: sn.toString()),
                                        SizedBox(height: Get.height * 0.015),
                                        ItemData(title: 'MAC adress'.tr, subtitle: _getController.switchDetailModel.value.detail!.mac.toString()),
                                        SizedBox(height: Get.height * 0.015),
                                        ItemData(title: 'Ip adress'.tr, subtitle: _getController.switchDetailModel.value.detail!.ip.toString()),
                                        SizedBox(height: Get.height * 0.015),
                                        ItemData(title: 'Dasturiy ta`minot'.tr,subtitle: _getController.switchDetailModel.value.detail!.v.toString()),
                                        SizedBox(height: Get.height * 0.015),
                                        ItemData(title: 'POE kuchlanishi'.tr, subtitle: '${_getController.switchDetailModel.value.detail!.vol} V'),
                                        SizedBox(height: Get.height * 0.015),
                                        ItemData(title: 'POE quvvati'.tr, subtitle: '${_getController.switchDetailModel.value.detail!.tp} W'),
                                        SizedBox(height: Get.height * 0.015),
                                        ItemData(title: 'Online davri'.tr, subtitle: _getController.switchDetailModel.value.detail!.uptime.toString()),
                                        SizedBox(height: Get.height * 0.05),
                                        SizedBox(
                                            width: Get.width,
                                            height: Get.height * 0.07,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: AppColors.blue,
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                                              ),
                                              onPressed: () {
                                                //switchReboot
                                                ApiController().switchReboot(pidId.toString(), sn.toString());
                                              },
                                              child: Text('Qurilmani o\'chirib yoqish'.tr, style: TextStyle(color: AppColors.white, fontSize: Get.textTheme.bodyMedium!.fontSize)),
                                            )
                                        )
                                      ]
                                  )
                              )
                            else
                              SizedBox(
                                width: Get.width,
                                child: Center(child: Text('Ma\'lumot topilmadi'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.textTheme.bodyMedium!.fontSize))),
                              ),
                            if (_getController.switchDetailModel.value.detail != null)
                              Padding(
                                  padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03,top: Get.height * 0.03, bottom: Get.height * 0.02),
                                  child: Column(
                                      children: [
                                        Row(
                                            children: [
                                              Expanded(child: Center(child: Text('Port'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.textTheme.bodyMedium!.fontSize, fontWeight: FontWeight.w500)))),
                                              Expanded(child: Center(child: Text('Power'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.textTheme.bodyMedium!.fontSize, fontWeight: FontWeight.w500)))),
                                              Expanded(child: Center(child: Text('TX'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.textTheme.bodyMedium!.fontSize, fontWeight: FontWeight.w500)))),
                                              Expanded(child: Center(child: Text('RX'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.textTheme.bodyMedium!.fontSize, fontWeight: FontWeight.w500)))),
                                              Expanded(child: Center(child: Text('Status'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.textTheme.bodyMedium!.fontSize, fontWeight: FontWeight.w500)))),
                                            ]
                                        ),
                                        Divider(thickness: 1, color: Theme.of(context).colorScheme.outline),
                                        Expanded(child: SingleChildScrollView(
                                            child: Column(
                                                children: [
                                                  for (int index = 0; index < _getController.switchDetailModel.value.detail!.tx!.length; index++)
                                                    ItemPortData(
                                                        portName: _getController.getPortList(_getController.typeFromSerialNumber(sn!)).toList()[index+1],
                                                        power: _getController.switchDetailModel.value.detail!.pw!.length > index ? _getController.formatPower(double.parse(_getController.switchDetailModel.value.detail!.pw![index].toString())) : '-',
                                                        tx: _getController.switchDetailModel.value.detail!.tx!.length > index ? _getController.trafficToString(double.parse(_getController.switchDetailModel.value.detail!.tx![index].toString())) : '-',
                                                        rx: _getController.switchDetailModel.value.detail!.rx!.length > index ? _getController.trafficToString(double.parse(_getController.switchDetailModel.value.detail!.rx![index].toString())) : '-',
                                                        status: switch (int.parse(_getController.switchDetailModel.value.detail!.link![index].toString())) {0 => "Offline", 1 => "Half 10M", 2 => "10M", 3 => "Half 100M", 4 => "100M", 5 => "1000M", _ => "Offline"}
                                                    )
                                                ]
                                            )
                                        ))
                                      ]
                                  )
                              )
                            else
                              SizedBox(
                                width: Get.width,
                                child: Center(child: Text('Ma\'lumot topilmadi'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.textTheme.bodyMedium!.fontSize))),
                              ),
                            if (_getController.switchDetailModel.value.detail != null)
                              Padding(
                                  padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03,top: Get.height * 0.03, bottom: Get.height * 0.02),
                                  child: Column(
                                      children: [
                                        Row(
                                            children: [
                                              Expanded(child: Center(child: Text('Port'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.textTheme.bodyMedium!.fontSize, fontWeight: FontWeight.w500)))),
                                              Expanded(child: Center(child: Text('POE'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.textTheme.bodyMedium!.fontSize, fontWeight: FontWeight.w500)))),
                                              Expanded(child: Center(child: Text('Extend'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.textTheme.bodyMedium!.fontSize, fontWeight: FontWeight.w500)))),
                                              Expanded(child: Center(child: Text('Reboot'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.textTheme.bodyMedium!.fontSize, fontWeight: FontWeight.w500)))),
                                            ]
                                        ),
                                        Divider(thickness: 1, color: Theme.of(context).colorScheme.outline),
                                        Expanded(child: SingleChildScrollView(
                                            child: Column(
                                                children: [
                                                  for (int index = 0; index < _getController.switchDetailModel.value.detail!.tx!.length; index++)
                                                    ItemSettingsData(
                                                        projectId: pidId,
                                                        serialNumber: sn,
                                                        portName: _getController.getPortList(_getController.typeFromSerialNumber(sn!)).toList()[index+1],
                                                        extend: _getController.switchDetailModel.value.detail!.iSoc!.toString(),
                                                        reboot: _getController.switchDetailModel.value.detail!.link![index].toString(),
                                                        port: _getController.switchDetailModel.value.detail!.poEc!.length > index ? int.parse(_getController.switchDetailModel.value.detail!.poEc![index].toString()) : null,
                                                        poEs: _getController.switchDetailModel.value.detail!.poEc!.length > index ? int.parse(_getController.switchDetailModel.value.detail!.poEc![index].toString()) : 0,
                                                        phYc: _getController.switchDetailModel.value.detail!.phYc!.length > index ? int.parse(_getController.switchDetailModel.value.detail!.phYc![index].toString()) : 0,
                                                        version: _getController.switchDetailModel.value.detail!.v!.length > index ? _getController.switchDetailModel.value.detail!.v![index].toString() : null,
                                                        index: index + 1
                                                    )
                                                  //for(int index = 0; index < _getController.switchDetailModel.value.detail!.tx!.length; index++)
                                                ]
                                            )
                                        ))
                                      ]
                                  )
                              )
                            else
                              SizedBox(
                                width: Get.width,
                                child: Center(child: Text('Ma\'lumot topilmadi'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.textTheme.bodyMedium!.fontSize))),
                              ),
                          ],
                        )
                    )
                  ]
              )
                  : const Center(child: CircularProgressIndicator()))
          ),

      )
    );
  }
}