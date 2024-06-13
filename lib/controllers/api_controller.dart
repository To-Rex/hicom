import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:hicom/controllers/tea.dart';
import 'package:http/http.dart';
import '../models/districts_model.dart';
import '../models/login_model.dart';
import '../models/province_model.dart';
import '../models/register_model.dart';
import '../models/sample/project_model.dart';
import '../pages/auth/register_page.dart';
import '../pages/auth/verify_page.dart';
import '../pages/sample_page.dart';
import 'get_controller.dart';

class ApiController extends GetxController {
  final GetController _getController = Get.put(GetController());

  static const String _baseUrl = 'http://185.196.213.76:8000/SSC_Switch/hicom?';
  static const String key = '50UvFayZ2w5u3O9B';
  static const String _switchPassword = '123456';


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
                        Container(height: _getController.height.value * 0.005, width: _getController.width.value * 0.2, margin: EdgeInsets.only(top: _getController.height.value * 0.02, bottom: _getController.height.value * 0.03), decoration: BoxDecoration(color: Theme.of(context).colorScheme.onBackground, borderRadius: BorderRadius.circular(10.0))),
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
                                            if (index != 0) {
                                              _getController.changeDropDownItems(0, index);
                                              ApiController().getRegions(Tea.encryptTea('{"country_id": 1,"region_id": ${_getController.provinceModel.value.regions![_getController.dropDownItems[0]].id.toString()}}',key), 'districts');
                                            }
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
                                          if (index != 0) {
                                            setState(() {
                                              _getController.changeDropDownItems(1, index);
                                            });
                                          }
                                        },
                                        child: Padding(padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
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
                                                                Text(_getController.districtsModel.value.districts![index].name.toString(),
                                                                  style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.04)),
                                                                const Spacer(),
                                                                if (_getController.dropDownItems[1] == index)
                                                                  Icon(TablerIcons.circle_check, color: Theme.of(context).colorScheme.onBackground)
                                                                else
                                                                  Icon(TablerIcons.circle, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5))
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

  Future<void> getRegions(data,act) async {
    var response = await get(
        Uri.parse('${_baseUrl+_getController.getQueryString(act, 'null') + data}&key=$key'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        }
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (act == 'regions') {
        _getController.clearProvinceModel();
        _getController.changeProvinceModel(ProvinceModel.fromJson(jsonDecode(Tea.decryptTea(response.body,key).toString())));
      } else if (act == 'districts') {
        _getController.clearDistrictsModel();
        debugPrint(Tea.decryptTea(response.body,key).toString());
        _getController.fullName.value = Tea.decryptTea(response.body,key);
        _getController.changeDistrictsModel(DistrictsModel.fromJson(jsonDecode(Tea.decryptTea(response.body,key).toString())));
      }
    }else {
      showToast(Get.context!, 'Xatolik', 'Xatolik yuz berdi'.tr, true, 3);
    }
  }

  Future<void> sendCode() async {
    var json = Tea.encryptTea('{"phone": "${_getController.code.value+_getController.phoneController.text}","code":""}',_getController.getKey());
    var response = await post( Uri.parse('${_baseUrl+_getController.getQueryString('sendcode', 'null') + json.toString()}&key=${_getController.getKey()}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        }
    );
    debugPrint(response.body);
    debugPrint(Tea.decryptTea(response.body,_getController.getKey()).toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (jsonDecode(utf8.decode(Tea.decryptTea(response.body,_getController.getKey()).toString().codeUnits))['errcode'] == 0) {
        showToast(Get.context!, 'OK', 'Kod jo‘natildi'.tr, false, 2);
        Get.to(VerifyPage());
      } else {
        showToast(Get.context!, 'Hayronman', 'Xatolik yuz berdi'.tr, true, 3);
      }
    }else {
      showToast(Get.context!, 'Xatolik', 'Xatolik yuz berdi'.tr, true, 3);
    }
  }

  Future<void> checkCode() async {
    var json = Tea.encryptTea('{"phone": "${_getController.code.value+_getController.phoneController.text}","code":"${_getController.codeController.text}"}',_getController.getKey());
    print(json);
    print(Tea.decryptTea(json,key).toString());
    var response = await post( Uri.parse('${_baseUrl+_getController.getQueryString('checkcode', 'null') + json.toString()}&key=${_getController.getKey()}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        }
    );
    debugPrint(response.body);
    debugPrint(Tea.decryptTea(response.body,_getController.getKey()).toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      _getController.writeLogin(_getController.code.value+_getController.phoneController.text, jsonDecode(utf8.decode(Tea.decryptTea(response.body,_getController.getKey()).toString().codeUnits))['session']);
      if (jsonDecode(utf8.decode(Tea.decryptTea(response.body,_getController.getKey()).toString().codeUnits))['errcode'] == 0) {
        showToast(Get.context!, 'OK', 'Kod to‘g‘ri'.tr, false, 2);
        if (jsonDecode(utf8.decode(Tea.decryptTea(response.body,_getController.getKey()).toString().codeUnits))['registered'] == 0) {
          Get.to(RegisterPage());
        } else {
          login(_getController.code.value+_getController.phoneController.text,jsonDecode(utf8.decode(Tea.decryptTea(response.body,_getController.getKey()).toString().codeUnits))['session'],key,true);
        }
      } else {
        showToast(Get.context!, 'Hayronman', 'Xatolik yuz berdi'.tr, true, 3);
      }
    } else {
      showToast(Get.context!, 'Xatolik', 'Xatolik yuz berdi'.tr, true, 3);
    }
  }

  Future<void> login (phone,session,keys,enter) async {
    debugPrint(phone);
    debugPrint(session);
    var json = Tea.encryptTea('{"phone": "$phone","session":"$session"}',keys);
    print('suuu $json');
    print(Tea.decryptTea(json,keys).toString());
    var response = await post( Uri.parse('${_baseUrl+_getController.getQueryString('login', 'null') + json.toString()}&key=$keys'), headers: {'Content-Type': 'application/json; charset=UTF-8', 'Accept': 'application/json'});
    debugPrint(response.body);
    debugPrint(response.statusCode.toString());
    debugPrint(Tea.decryptTea(response.body,keys).toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (jsonDecode(utf8.decode(Tea.decryptTea(response.body,keys).toString().codeUnits))['errcode'] == 0) {
        _getController.changeLoginModel(LoginModel.fromJson(jsonDecode(utf8.decode(Tea.decryptTea(response.body,keys).toString().codeUnits))));
        _getController.writeKey(_getController.loginModel.value.key.toString());
        _getController.writeUid(_getController.loginModel.value.uid.toString());
        _getController.writeUser(_getController.loginModel.value);
        if (enter){
          Get.offAll(SamplePage());
        }

      } else {
        if (jsonDecode(utf8.decode(Tea.decryptTea(response.body,keys).toString().codeUnits))['errcode'] == 20003) {
          _getController.writeKey(_getController.loginModel.value.key.toString());
          _getController.writeUid(_getController.loginModel.value.uid.toString());
          _getController.writeUser(_getController.loginModel.value);
          Get.to(RegisterPage());
          showToast(Get.context!, 'Xatolik', 'Bunday foydalanuvchi allaqachon mavjud.'.tr, true, 3);
        }else {
          showToast(Get.context!, 'Hayronman', 'Xatolik yuz berdi'.tr, true, 3);
        }
      }
    } else {
      showToast(Get.context!, 'Xatolik', 'Xatolik yuz berdi'.tr, true, 3);
    }
  }

  Future<void> signUp() async {
    var json = Tea.encryptTea('{"phone": "${_getController.code.value+_getController.phoneController.text}","name": "${_getController.nameController.text}","type": "${_getController.dropDownItems[2]}","country_id": "1","region_id": "${_getController.provinceModel.value.regions![_getController.dropDownItems[0]].id.toString()}", "district_id": "${_getController.districtsModel.value.districts![_getController.dropDownItems[1]].id.toString()}"}',key);
    debugPrint(json.toString());
    debugPrint('${_baseUrl + _getController.getQueryString('signup', 'null') + json.toString()}&key=$key}');
    var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('signup', 'null') + json.toString()}&key=$key'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        }
    );
    debugPrint(response.body);
    debugPrint(response.statusCode.toString());
    debugPrint(Tea.decryptTea(response.body,key).toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      showToast(Get.context!, 'OK', 'Ajoyiiiibbbbb'.tr, false, 2);
      _getController.changeRegisterModel(RegisterModel.fromJson(jsonDecode(Tea.decryptTea(response.body,key).toString())));
      _getController.writeKey(_getController.registerModel.value.key.toString());
      _getController.writeUid(_getController.registerModel.value.uid.toString());
      login(_getController.getNumber(),_getController.getSession(),key,true);
    } else {
      showToast(Get.context!, 'Xatolik', 'Xatolik yuz berdi'.tr, true, 3);
    }
  }

  Future<void> editUser() async {
    var json = Tea.encryptTea('{"phone": "${_getController.code.value+_getController.phoneController.text == '+998' ? _getController.getNumber() : _getController.code.value+_getController.phoneController.text}","name": "${_getController.nameController.text}","type": "${_getController.dropDownItems[2]}","country_id": "${_getController.dropDownItemsTitle[0] == 'Uzbekistan'.tr ? 1 : 2}","region_id": "${_getController.dropDownItemsTitle[0] == 'Uzbekistan'.tr?_getController.provinceModel.value.regions![_getController.dropDownItems[0]].id.toString(): "0"}", "district_id": "${_getController.dropDownItemsTitle[0] == 'Uzbekistan'.tr ? _getController.districtsModel.value.districts![_getController.dropDownItems[1]].id.toString() : "0"}"}',_getController.getKey());
    debugPrint('${_baseUrl + _getController.getQueryString('changeprofile', 'null') + json.toString()}&key=${_getController.getKey()}');
    var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('changeprofile', 'null') + json.toString()}&key=${_getController.getKey()}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );
    debugPrint(response.body);
    debugPrint(response.statusCode.toString());
    debugPrint(Tea.decryptTea(response.body,_getController.getKey()).toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      showToast(Get.context!, 'OK', 'Ajoyiiiibbbbb'.tr, false, 2);
      //login(phone, session, keys)
      login(_getController.getNumber(),_getController.getSession(),key,false);
    } else {
      showToast(Get.context!, 'Xatolik', 'Xatolik yuz berdi'.tr, true, 3);
    }
  }

  Future<void> deleteUser() async {
    var json = Tea.encryptTea(jsonEncode(_getController.loginModel.value),_getController.getKey());
    print('${_getController.getQueryString('logout', _getController.getUid())}&key=${_getController.getKey()}');
    var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('logout', _getController.getUid()) + json.toString()}&key=${_getController.getKey()}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );
    debugPrint(response.body);
    debugPrint(response.statusCode.toString());
    debugPrint(Tea.decryptTea(response.body,_getController.getKey()).toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      showToast(Get.context!, 'OK', 'Ajoyiiiibbbbb'.tr, false, 2);
    } else {
      showToast(Get.context!, 'Xatolik', 'Xatolik yuz berdi'.tr, true, 3);
    }
  }

  Future<void> getSettings() async {
    print('${_baseUrl + _getController.getQueryString('settings', 'null')}&key=${_getController.getKey()}');
    var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('settings', 'null')}&key=${_getController.getKey()}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );
    debugPrint(response.body);
    debugPrint(response.statusCode.toString());
    debugPrint(Tea.decryptTea(response.body,_getController.getKey()).toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      showToast(Get.context!, 'OK', 'Ajoyiiiibbbbb'.tr, false, 2);
    } else {
      showToast(Get.context!, 'Xatolik', 'Xatolik yuz berdi'.tr, true, 3);
    }
  }

  Future<void> getProjects() async {
    print('${_baseUrl + _getController.getQueryString('prjmng', _getController.getUid()) + Tea.encryptTea('{}', _getController.getKey())}&key=${_getController.getKey()}');
    var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('prjmng', _getController.getUid()) + Tea.encryptTea('{}', _getController.getKey())}&key=${_getController.getKey()}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );
    debugPrint(response.body);
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      showToast(Get.context!, 'OK', 'Ajoyiiiibbbbb'.tr, false, 2);
      try {
        debugPrint(Tea.decryptTea(response.body.toString().replaceAll('\n',''),_getController.getKey()));
        _getController.getProject(ProjectModel.fromJson(jsonDecode(Tea.decryptTea(response.body.toString(),_getController.getKey()))));
      }catch(e){
        debugPrint(e.toString());
      }
    } else {
      showToast(Get.context!, 'Xatolik', 'Xatolik yuz berdi'.tr, true, 3);
    }
  }

}