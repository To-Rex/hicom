import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:hicom/controllers/tea.dart';
import 'package:http/http.dart';
import '../models/districts_model.dart';
import '../models/province_model.dart';
import 'get_controller.dart';

class ApiController extends GetxController {
  final GetController _getController = Get.put(GetController());

  static const String _baseUrl = 'http://185.196.213.76:8000/SSC_Switch/hicom?';
  static const String key = '50UvFayZ2w5u3O9B';
  static const String _switchPassword = '123456';

  final GetController getController = Get.put(GetController());

  //show toast message
  void showToast(context,String title,String message, error,sec) {
    Get.snackbar(
      title.tr,
      message.tr,
      backgroundColor: error ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.onBackground,
      colorText: error ? Theme.of(context).colorScheme.onError : Theme.of(context).colorScheme.surface,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.only(
          bottom: _getController.height.value * 0.03,
          left: _getController.width.value * 0.04,
          right: _getController.width.value * 0.04
      ),
      borderRadius: 12,
      duration: Duration(seconds: sec),
      icon: error ? Icon(
        Icons.error,
        color: Theme.of(context).colorScheme.onError,
      ) : null,
    );
  }

  void showDialogConnectivity(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Internet bağlanmadi'.tr),
          content: Text('Internet bağlanmadi'.tr),
          actions: <Widget>[
            TextButton(
              child: Text('Yana qayta urinish'.tr),
              onPressed: () {
                Navigator.of(context).pop();
              }
            ),
          ],
        );
      },
    );
  }

  bottomBuildLanguageDialog(BuildContext context,title,cat){
    Get.bottomSheet(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
        enableDrag: true,
        isScrollControlled: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SizedBox(
                  height: _getController.height.value * 0.7,
                  width: double.infinity,
                  child: Column(
                      children: [
                        Container(
                            height: _getController.height.value * 0.005,
                            width: _getController.width.value * 0.2,
                            margin: EdgeInsets.only(top: _getController.height.value * 0.02, bottom: _getController.height.value * 0.03),
                            decoration: BoxDecoration(color: Theme.of(context).colorScheme.onBackground, borderRadius: BorderRadius.circular(10.0))
                        ),
                        Text(title.toString().tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.045)),
                        SizedBox(height: _getController.height.value * 0.02),
                        if (cat == 0)
                          Expanded(
                              child: ListView.builder(
                                  itemCount: _getController.provinceModel.value.regions!.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: () {
                                          setState(() {
                                            _getController.changeDropDownItems(0, index);
                                            ApiController().getData(TEA.encryptTEA('{"country_id": 1,"region_id": ${_getController.provinceModel.value.regions![_getController.dropDownItems[0]].id.toString()}}'), 'districts');
                                          });
                                        },
                                      child: Padding(
                                        padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                                        child: Column(
                                            children: [
                                              SizedBox(height: _getController.height.value * 0.01),
                                              Container(
                                                  height: _getController.height.value * 0.04,
                                                  width: _getController.width.value,
                                                  margin: EdgeInsets.only(bottom: _getController.height.value * 0.01),
                                                  child: Center(
                                                    child: Row(
                                                        children: [
                                                          Text(_getController.provinceModel.value.regions![index].name.toString(), style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.04),),
                                                          const Spacer(),
                                                          if (_getController.dropDownItems[0] == index)
                                                            Icon(TablerIcons.circle_check, color: Theme.of(context).colorScheme.onBackground)
                                                          else
                                                            Icon(TablerIcons.circle, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5))
                                                        ]
                                                    )
                                                  )
                                              ),
                                              if (_getController.provinceModel.value.regions!.length - 1 != index)
                                                const Divider(),
                                              if (_getController.provinceModel.value.regions!.length - 1 == index)
                                                SizedBox(height: _getController.height.value * 0.01),
                                            ]
                                        )
                                      )
                                    );
                                  }
                              )
                          )
                        else if (cat == 1)
                          Expanded(
                              child: Obx(() => ListView.builder(
                                  itemCount: _getController.districtsModel.value.districts!.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: () {
                                          setState(() {
                                            _getController.changeDropDownItems(1, index);
                                          });
                                        },
                                        child: Padding(padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                                            child: Column(
                                                children: [
                                                  SizedBox(
                                                      height: _getController
                                                          .height.value *
                                                          0.01),
                                                  Container(
                                                      height: _getController
                                                          .height.value *
                                                          0.04,
                                                      width: _getController
                                                          .width.value,
                                                      margin: EdgeInsets.only(
                                                          bottom: _getController
                                                              .height.value *
                                                              0.01),
                                                      child: Center(
                                                          child: Row(
                                                              children: [
                                                                Text(
                                                                  _getController
                                                                      .districtsModel
                                                                      .value
                                                                      .districts![index]
                                                                      .name
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Theme
                                                                          .of(
                                                                          context)
                                                                          .colorScheme
                                                                          .onBackground,
                                                                      fontSize: _getController
                                                                          .width
                                                                          .value *
                                                                          0.04),),
                                                                const Spacer(),
                                                                if (_getController
                                                                    .dropDownItems[1] ==
                                                                    index)
                                                                  Icon(
                                                                      TablerIcons
                                                                          .circle_check,
                                                                      color: Theme
                                                                          .of(
                                                                          context)
                                                                          .colorScheme
                                                                          .onBackground)
                                                                else
                                                                  Icon(
                                                                      TablerIcons
                                                                          .circle,
                                                                      color: Theme
                                                                          .of(
                                                                          context)
                                                                          .colorScheme
                                                                          .onBackground
                                                                          .withOpacity(
                                                                          0.5))
                                                              ]
                                                          )
                                                      )
                                                  ),
                                                  //if (_getController.state.length - 1 != index)
                                                  const Divider()
                                                ]
                                            )
                                        )
                                    );
                                    /*if (_getController.districtsModel.value.districts![index].regionId == _getController.provinceModel.value.regions![_getController.dropDownItems[0]].id) {
                                      return InkWell(
                                          onTap: () {
                                            setState(() {
                                              _getController.changeDropDownItems(1, index);
                                            });
                                          },
                                          child: Padding(padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                                              child: Column(
                                                  children: [
                                                    SizedBox(
                                                        height: _getController
                                                            .height.value *
                                                            0.01),
                                                    Container(
                                                        height: _getController
                                                            .height.value *
                                                            0.04,
                                                        width: _getController
                                                            .width.value,
                                                        margin: EdgeInsets.only(
                                                            bottom: _getController
                                                                .height.value *
                                                                0.01),
                                                        child: Center(
                                                            child: Row(
                                                                children: [
                                                                  Text(
                                                                    _getController
                                                                        .districtsModel
                                                                        .value
                                                                        .districts![index]
                                                                        .name
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        color: Theme
                                                                            .of(
                                                                            context)
                                                                            .colorScheme
                                                                            .onBackground,
                                                                        fontSize: _getController
                                                                            .width
                                                                            .value *
                                                                            0.04),),
                                                                  const Spacer(),
                                                                  if (_getController
                                                                      .dropDownItems[1] ==
                                                                      index)
                                                                    Icon(
                                                                        TablerIcons
                                                                            .circle_check,
                                                                        color: Theme
                                                                            .of(
                                                                            context)
                                                                            .colorScheme
                                                                            .onBackground)
                                                                  else
                                                                    Icon(
                                                                        TablerIcons
                                                                            .circle,
                                                                        color: Theme
                                                                            .of(
                                                                            context)
                                                                            .colorScheme
                                                                            .onBackground
                                                                            .withOpacity(
                                                                            0.5))
                                                                ]
                                                            )
                                                        )
                                                    ),
                                                    //if (_getController.state.length - 1 != index)
                                                    const Divider()
                                                  ]
                                              )
                                          )
                                      );
                                    } else{
                                      return Container();
                                    }*/
                                  }
                              ))
                          )
                        else
                          Expanded(
                              child: ListView.builder(
                                  itemCount: _getController.dropDownItem.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: () {
                                          setState(() {
                                            _getController.changeDropDownItems(2, index);
                                          });
                                        },
                                        child: Padding(
                                            padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                                            child: Column(
                                                children: [
                                                  SizedBox(height: _getController.height.value * 0.01),
                                                  Container(
                                                      height: _getController.height.value * 0.04,
                                                      width: _getController.width.value,
                                                      margin: EdgeInsets.only(bottom: _getController.height.value * 0.01),
                                                      child: Center(
                                                          child: Row(
                                                              children: [
                                                                Text(_getController.dropDownItem[index].tr,style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.04),),
                                                                const Spacer(),
                                                                if (_getController.dropDownItems[2] == index)
                                                                  Icon(TablerIcons.circle_check, color: Theme.of(context).colorScheme.onBackground)
                                                                else
                                                                  Icon(TablerIcons.circle, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5))
                                                              ]
                                                          )
                                                      )
                                                  ),
                                                  if (_getController.dropDownItem.length - 1 != index)
                                                    const Divider()
                                                ]
                                            )
                                        )
                                    );
                                  }
                              )
                          )
                      ]
                  )
              );
            })
    );
  }

  Future<void> getData(data,act) async {
    var response = await get(
        Uri.parse('${_baseUrl+getController.getQueryString(act, 'null') + data}&key=$key'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        }
    );
    //encode the data utf8.encode
    if (response.statusCode == 200) {
      if (act == 'regions') {
        _getController.clearProvinceModel();
        _getController.changeProvinceModel(ProvinceModel.fromJson(jsonDecode(utf8.decode(TEA.decryptTEA(response.body).toString().codeUnits))));
        debugPrint(TEA.decryptTEA(response.body).toString());
        debugPrint('====================================================================================');
      }else if (act == 'districts') {
        _getController.clearDistrictsModel();
        debugPrint(TEA.decryptTEA(response.body).toString());
        _getController.fullName.value = TEA.decryptTEA(response.body);
        //_getController.changeDistrictsModel(DistrictsModel.fromJson(jsonDecode(TEA.decryptTEA(response.body))));
        _getController.changeDistrictsModel(DistrictsModel.fromJson(jsonDecode(utf8.decode(TEA.decryptTEA(response.body).toString().codeUnits))));
      }
    }else {
      showToast(Get.context!, 'Xatolik', 'Xatolik yuz berdi'.tr, true, 3);
    }
  }

}
