import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hicom/companents/instrument/instrument_components.dart';
import 'package:hicom/controllers/tea.dart';
import 'package:http/http.dart';
import '../models/districts_model.dart';
import '../models/login_model.dart';
import '../models/province_model.dart';
import '../models/register_model.dart';
import '../models/sample/Switch_detail_model.dart';
import '../models/sample/get_users_model.dart';
import '../models/sample/project_model.dart';
import '../models/sample/switch_list_model.dart';
import '../models/settings_info.dart';
import '../pages/auth/register_page.dart';
import '../pages/auth/verify_page.dart';
import '../pages/sample/sample_page.dart';
import 'get_controller.dart';

class ApiController extends GetxController {
  final GetController _getController = Get.put(GetController());

  static const String _baseUrl = 'http://185.196.213.76:8000/SSC_Switch/hicom?';
  static const String key = '50UvFayZ2w5u3O9B';
  static const String _switchPassword = '123456';

  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
  };

  Future<void> getRegions(data,act) async {
    var response = await get(
        Uri.parse('${_baseUrl+_getController.getQueryString(act, 'null') + data}&key=$key'),
        headers: headers
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
      InstrumentComponents().showToast(Get.context!, 'Xatolik', 'Xatolik yuz berdi'.tr, true, 3);
    }
  }

  Future<void> sendCode() async {
    var json = Tea.encryptTea('{"phone": "${_getController.code.value+_getController.phoneController.text}","code":""}',_getController.getKey());
    var response = await post( Uri.parse('${_baseUrl+_getController.getQueryString('sendcode', 'null') + json.toString()}&key=${_getController.getKey()}'),
        headers: headers
    );
    debugPrint(response.body);
    debugPrint(Tea.decryptTea(response.body,_getController.getKey()).toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (jsonDecode(utf8.decode(Tea.decryptTea(response.body,_getController.getKey()).toString().codeUnits))['errcode'] == 0) {
        InstrumentComponents().showToast(Get.context!, 'Muvaffaqiyatli', '${_getController.code.value+_getController.phoneController.text} raqamiga Kod yuborildi'.tr, false, 2);
        Get.to(VerifyPage());
      } else {
        InstrumentComponents().showToast(Get.context!, 'Hayronman', 'Xatolik yuz berdi'.tr, true, 3);
      }
    }else {
      InstrumentComponents().showToast(Get.context!, 'Xatolik', 'Xatolik yuz berdi'.tr, true, 3);
    }
  }

  Future<void> checkCode() async {
    var json = Tea.encryptTea('{"phone": "${_getController.code.value+_getController.phoneController.text}","code":"${_getController.codeController.text}"}',_getController.getKey());
    var response = await post( Uri.parse('${_baseUrl+_getController.getQueryString('checkcode', 'null') + json.toString()}&key=${_getController.getKey()}'),
        headers: headers
    );
    debugPrint(response.body);
    debugPrint(Tea.decryptTea(response.body,_getController.getKey()).toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      _getController.writeLogin(_getController.code.value+_getController.phoneController.text, jsonDecode(utf8.decode(Tea.decryptTea(response.body,_getController.getKey()).toString().codeUnits))['session']);
      if (jsonDecode(utf8.decode(Tea.decryptTea(response.body,_getController.getKey()).toString().codeUnits))['errcode'] == 0) {
        if (jsonDecode(utf8.decode(Tea.decryptTea(response.body,_getController.getKey()).toString().codeUnits))['registered'] == 0) {
          Get.to(RegisterPage());
        } else {
          InstrumentComponents().showToast(Get.context!, 'Muvaffaqiyatli', 'Kiritilgan kod tasdiqlandi'.tr, false, 2);
          login(_getController.code.value+_getController.phoneController.text,jsonDecode(utf8.decode(Tea.decryptTea(response.body,_getController.getKey()).toString().codeUnits))['session'],key,true);
        }
      } else {
        InstrumentComponents().showToast(Get.context!, 'Hayronman', 'Xatolik yuz berdi'.tr, true, 3);
      }
    } else {
      InstrumentComponents().showToast(Get.context!, 'Xatolik', 'Xatolik yuz berdi'.tr, true, 3);
    }
  }

  Future<void> login (phone,session,keys,enter) async {
    var json = Tea.encryptTea('{"phone": "$phone","session":"$session"}',keys);
    var response = await post( Uri.parse('${_baseUrl+_getController.getQueryString('login', 'null') + json.toString()}&key=$keys'), headers: headers);
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
          InstrumentComponents().showToast(Get.context!, 'Xatolik', 'Bunday foydalanuvchi allaqachon mavjud.'.tr, true, 3);
        }else {
          InstrumentComponents().showToast(Get.context!, 'Hayronman', 'Xatolik yuz berdi'.tr, true, 3);
        }
      }
    } else {
      InstrumentComponents().showToast(Get.context!, 'Xatolik', 'Xatolik yuz berdi'.tr, true, 3);
    }
  }

  Future<void> signUp() async {
    var json = Tea.encryptTea('{"phone": "${_getController.code.value+_getController.phoneController.text}","name": "${_getController.nameController.text}","type": "${_getController.dropDownItems[2]}","country_id": "1","region_id": "${_getController.provinceModel.value.regions![_getController.dropDownItems[0]].id.toString()}", "district_id": "${_getController.districtsModel.value.districts![_getController.dropDownItems[1]].id.toString()}"}',key);
    debugPrint(json.toString());
    debugPrint('${_baseUrl + _getController.getQueryString('signup', 'null') + json.toString()}&key=$key}');
    var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('signup', 'null') + json.toString()}&key=$key'),
        headers: headers
    );
    debugPrint(response.body);
    debugPrint(response.statusCode.toString());
    debugPrint(Tea.decryptTea(response.body,key).toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      _getController.changeRegisterModel(RegisterModel.fromJson(jsonDecode(Tea.decryptTea(response.body,key).toString())));
      _getController.writeKey(_getController.registerModel.value.key.toString());
      _getController.writeUid(_getController.registerModel.value.uid.toString());
      login(_getController.getNumber(),_getController.getSession(),key,true);
    } else {
      InstrumentComponents().showToast(Get.context!, 'Xatolik', 'Xatolik yuz berdi'.tr, true, 3);
    }
  }

  Future<void> editUser() async {
    var json = Tea.encryptTea('{"phone": "${_getController.code.value+_getController.phoneController.text == '+998' ? _getController.getNumber() : _getController.code.value+_getController.phoneController.text}","name": "${_getController.nameController.text}","type": "${_getController.dropDownItems[2]}","country_id": "${_getController.dropDownItemsTitle[0] == 'Uzbekistan'.tr ? 1 : 2}","region_id": "${_getController.dropDownItemsTitle[0] == 'Uzbekistan'.tr?_getController.provinceModel.value.regions![_getController.dropDownItems[0]].id.toString(): "0"}", "district_id": "${_getController.dropDownItemsTitle[0] == 'Uzbekistan'.tr ? _getController.districtsModel.value.districts![_getController.dropDownItems[1]].id.toString() : "0"}"}',_getController.getKey());
    debugPrint('${_baseUrl + _getController.getQueryString('changeprofile', 'null') + json.toString()}&key=${_getController.getKey()}');
    var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('changeprofile', 'null') + json.toString()}&key=${_getController.getKey()}'),
      headers: headers
    );
    debugPrint(response.body);
    debugPrint(response.statusCode.toString());
    debugPrint(Tea.decryptTea(response.body,_getController.getKey()).toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      login(_getController.getNumber(),_getController.getSession(),key,false);
    } else {
      InstrumentComponents().showToast(Get.context!, 'Xatolik', 'Xatolik yuz berdi'.tr, true, 3);
    }
  }

  Future<void> deleteUser() async {
    var json = Tea.encryptTea(jsonEncode(_getController.loginModel.value),_getController.getKey());
    var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('logout', _getController.getUid()) + json.toString()}&key=${_getController.getKey()}'),
      headers: headers
    );
    debugPrint(response.body);
    debugPrint(response.statusCode.toString());
    debugPrint(Tea.decryptTea(response.body,_getController.getKey()).toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      InstrumentComponents().showToast(Get.context!, 'Muofaqqiyatli', 'Muvaffaqiyatli o\'chirildi'.tr, true, 3);
    } else {
      InstrumentComponents().showToast(Get.context!, 'Xatolik', 'Xatolik yuz berdi'.tr, true, 3);
    }
  }

  Future<void> getSettings() async {
    debugPrint('${_baseUrl + _getController.getQueryString('settings', 'null') + Tea.encryptTea('{}', _getController.getKey())}&key=${_getController.getKey()}');
    var response = await get(Uri.parse('${_baseUrl + _getController.getQueryString('settings', 'null') + Tea.encryptTea('{}', _getController.getKey())}&key=${_getController.getKey()}'), headers: headers);
    debugPrint(response.body);
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      _getController.changeSettingsInfoModel(SettingsInfo.fromJson(jsonDecode(Tea.decryptTea(response.body,_getController.getKey()).toString())));
    } else {
      InstrumentComponents().showToast(Get.context!, 'Xatolik', 'Xatolik yuz berdi'.tr, true, 3);
    }
  }

  Future<void> getProjects() async {
    var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('prjmng', _getController.getUid()) + Tea.encryptTea('{}', _getController.getKey())}&key=${_getController.getKey()}'),
      headers: headers
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        debugPrint(Tea.decryptTea(response.body.toString().replaceAll('\n',''),_getController.getKey()));
        _getController.getProject(ProjectModel.fromJson(jsonDecode(Tea.decryptTea(response.body.toString(),_getController.getKey()))));
      }catch(e){
        InstrumentComponents().showToast(Get.context!, 'Xatolik', 'Xatolik yuz berdi'.tr, true, 3);
        debugPrint(e.toString());
      }
    } else {
      InstrumentComponents().showToast(Get.context!, 'Xatolik', 'Xatolik yuz berdi'.tr, true, 3);
    }
  }

  Future<void> renameProjects(pidId, name, note) async {
    var json = Tea.encryptTea(jsonEncode({"pid": pidId, "name": name}),_getController.getKey());
    var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('prjren', _getController.getUid()) + json.toString()}&key=${_getController.getKey()}'),
      headers: headers
    );
    debugPrint(response.body);
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      await renameProjectsNote(pidId, note);
    } else {
      InstrumentComponents().showToast(Get.context!, 'Xatolik', 'Xatolik yuz berdi'.tr, true, 3);
    }
  }

  Future<void> renameProjectsNote(pidId, note) async {
    var json = Tea.encryptTea(jsonEncode({"pid": pidId, "note": note}),_getController.getKey());
    var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('prjnote', _getController.getUid()) + json.toString()}&key=${_getController.getKey()}'),
      headers: headers
    );
    debugPrint(response.body);
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      getProjects();
    } else {
      InstrumentComponents().showToast(Get.context!, 'Xatolik', 'Xatolik yuz berdi'.tr, true, 3);
    }
  }

  Future<void> getProjectsUsers(pidId) async {
    var json = Tea.encryptTea(jsonEncode({"pid": pidId}),_getController.getKey());
    var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('prjjoin', _getController.getUid()) + json.toString()}&key=${_getController.getKey()}'),
      headers: headers
    );
    debugPrint(response.body);
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        _getController.getUsersModel(GetUsersModel.fromJson(jsonDecode(Tea.decryptTea(response.body.toString(),_getController.getKey()))));
      }catch(e){
        debugPrint(e.toString());
        InstrumentComponents().showToast(Get.context!, 'Xatolik', 'Xatolik yuz berdi'.tr, true, 3);
      }
    } else {
      InstrumentComponents().showToast(Get.context!, 'Xatolik', 'Xatolik yuz berdi'.tr, true, 3);
    }
  }

  Future<void> projectShare(pidId) async {
    var json = Tea.encryptTea(jsonEncode({"pid": pidId, "phone": _getController.nameProjectController.text, "name": _getController.noteProjectController.text}),_getController.getKey());
    var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('prjshrem', _getController.getUid()) + json.toString()}&key=${_getController.getKey()}'),
      headers: headers
    );
    debugPrint(response.body);
    debugPrint(Tea.decryptTea(response.body,_getController.getKey()).toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (jsonDecode(Tea.decryptTea(response.body,_getController.getKey()).toString())['errcode'] == 20000) {
        Get.back();
        InstrumentComponents().showToast(Get.context!, 'Diqqat!', 'Ushbu foydalanuvchi allaqachon taklif qilgan'.tr, false, 2);
      } else if (jsonDecode(Tea.decryptTea(response.body,_getController.getKey()).toString())['errcode'] == 1) {
        InstrumentComponents().showToast(Get.context!, 'Xatolik', 'Bu foydalanuvchi tizimda mavjud emas'.tr, true, 3);
      } else if (jsonDecode(Tea.decryptTea(response.body,_getController.getKey()).toString())['errcode'] == 0) {
        Get.back();
        InstrumentComponents().showToast(Get.context!, 'Muvaffaqiyatli', 'Foydalanuvchi taklif qilindi'.tr, false, 2);
      } else {
        Get.back();
        InstrumentComponents().showToast(Get.context!, 'Xatolik', 'Exx nimadur xato ketdi'.tr, true, 3);
      }
    } else {
      InstrumentComponents().showToast(Get.context!, 'Xatolik', 'Xatolik yuz berdi'.tr, true, 3);
    }
  }

  Future<void> projectDelete(pidId) async {
    var json = Tea.encryptTea(jsonEncode({"pid": pidId}),_getController.getKey());
    var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('prjdel', _getController.getUid()) + json.toString()}&key=${_getController.getKey()}'),
      headers: headers
    );
    debugPrint(response.body);
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      getProjects();
    } else {
      InstrumentComponents().showToast(Get.context!, 'Xatolik', 'Xatolik yuz berdi'.tr, true, 3);
    }
  }

  Future<void> addProjects() async {
    var json = Tea.encryptTea(jsonEncode({"sna": _getController.switchSerialProjectController.text, "na": _getController.switchNameProjectController.text, "pda": _getController.passwordProjectController.text, "name":_getController.nameProjectController.text, "note": "", "auto": 0}),_getController.getKey());
    var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('prjadd', _getController.getUid()) + json.toString()}&key=${_getController.getKey()}'),
      headers: headers
    );
    debugPrint(response.body);
    debugPrint(Tea.decryptTea(response.body,_getController.getKey()).toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (jsonDecode(Tea.decryptTea(response.body,_getController.getKey()).toString())['errcode'] == 29999) {
        InstrumentComponents().showToast(Get.context!, 'Diqqat!', 'Kiritilgan ma\'lumotlar (Masalan, seriya raqam) noto\'g\'ri!'.tr, true, 1);
      }
    } else {
      InstrumentComponents().showToast(Get.context!, 'Diqqat!', 'Xatolik yuz berdi'.tr, true, 3);
    }
  }

  Future<void> getSwitchList(pidId) async {
    debugPrint(pidId);
    var json = Tea.encryptTea(jsonEncode({"pid": pidId}),_getController.getKey());
    var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('swmng', _getController.getUid()) + json.toString()}&key=${_getController.getKey()}'),
      headers: headers
    );
    debugPrint(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint(Tea.decryptTea(response.body,_getController.getKey()).toString());
      _getController.clearSwitchList();
      _getController.changeSwitchList(SwitchListModel.fromJson(jsonDecode(Tea.decryptTea(response.body,_getController.getKey()))));
    } else {
      InstrumentComponents().showToast(Get.context!, 'Xatolik', 'Xatolik yuz berdi'.tr, true, 3);
    }
  }

  Future<void> renameSwitch(pidId,sn) async {
    var json = Tea.encryptTea(jsonEncode({"pid": pidId, "sn": sn, "name": _getController.nameProjectController.text}),_getController.getKey());
    var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('swren', _getController.getUid()) + json.toString()}&key=${_getController.getKey()}'),
      headers: headers
    );
    debugPrint(response.body);
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      renameSwitchNote(pidId,sn);
    } else {
      InstrumentComponents().showToast(Get.context!, 'Xatolik', 'Xatolik yuz berdi'.tr, true, 3);
    }
  }

  Future<void> renameSwitchNote(pidId,sn) async {
    var json = Tea.encryptTea(jsonEncode({"pid": pidId, "sn": sn, "note": _getController.noteProjectController.text}),_getController.getKey());
    var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('swnote', _getController.getUid()) + json.toString()}&key=${_getController.getKey()}'),
        headers: headers
    );
    debugPrint(response.body);
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.back();
      InstrumentComponents().showToast(Get.context!, 'Muvaffaqiyatli', 'Ma’lumot o’zgartirildi'.tr, false, 2);
      getSwitchList(pidId);
    } else {
      InstrumentComponents().showToast(Get.context!, 'Xatolik', 'Xatolik yuz berdi'.tr, true, 3);
    }
  }

  Future<void> deleteSwitch(pidId,sn) async {
    var json = Tea.encryptTea(jsonEncode({"pid": pidId, "sn": sn}),_getController.getKey());
    var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('swdel', _getController.getUid()) + json.toString()}&key=${_getController.getKey()}'),
        headers: headers
    );
    debugPrint(response.body);
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.back();
      InstrumentComponents().showToast(Get.context!, 'Muvaffaqiyatli', 'Ma’lumot o’zgartirildi'.tr, false, 2);
      getSwitchList(pidId);
    } else {
      InstrumentComponents().showToast(Get.context!, 'Xatolik', 'Xatolik yuz berdi'.tr, true, 3);
    }
  }

  Future<void> addSwitch(pidId) async {
    var json = Tea.encryptTea(jsonEncode({"pid": pidId, "sna": [_getController.switchSerialProjectController.text], "na": [_getController.switchNameProjectController.text], "pda": [_getController.passwordProjectController.text], "auto": 0}),_getController.getKey());
    var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('swadd', _getController.getUid()) + json.toString()}&key=${_getController.getKey()}'), headers: headers);
    debugPrint(response.body);
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.back();
      InstrumentComponents().showToast(Get.context!, 'Muvaffaqiyatli', 'Ma’lumot o’zgartirildi'.tr, false, 2);
      getSwitchList(pidId);
    } else {
      InstrumentComponents().showToast(Get.context!, 'Xatolik', 'Xatolik yuz berdi'.tr, true, 3);
    }
  }

  Future<void> getSwitchDetail(String pidId, String sn) async {
    var json = Tea.encryptTea(jsonEncode({"pid": pidId, "sn": sn,'isJoin':"1"}),_getController.getKey());
    debugPrint('${_baseUrl + _getController.getQueryString('swdet', _getController.getUid()) + json.toString()}&key=${_getController.getKey()}');
    var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('swdet', _getController.getUid()) + json.toString()}&key=${_getController.getKey()}'),
      headers: headers
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint(Tea.decryptTea(response.body,_getController.getKey()).toString());
      if(jsonDecode(Tea.decryptTea(response.body,_getController.getKey()))['errcode'] == 0){
        _getController.changeSwitchDetailModel(SwitchDetailModel.fromJson(jsonDecode(Tea.decryptTea(response.body,_getController.getKey()))));
      } else {
        InstrumentComponents().showToast(Get.context!, 'Xatolik', 'Xatolik yuz berdi'.tr, true, 3);
      }
    } else {
      InstrumentComponents().showToast(Get.context!, 'Xatolik', 'Xatolik yuz berdi'.tr, true, 3);
    }
    Timer(const Duration(seconds: 5), () {
      if (_getController.whileApi.isTrue){
        getSwitchDetail(pidId, sn);
      }
    });
  }

  Future<void> portPOESwitch(String projectId, String serialNo, int port, bool state) async {
    // 1 00000 0010
    // [0-3] bitlar: 0010 - POE switch holatini o'zgartirish
    // [4-8] bitlar: 00000 - Port indeksi (0 dan boshlanadi, ya'ni 1-port = 00000, 2-port = 00001 va hok)
    // [9] bit: 0 - POE o'chirish, 1 - yoqish
    debugPrint('$projectId, $serialNo, $port, $state');

    int opcode = 2 | ((port - 1) << 4);
    if (state) opcode |= 1 << 9;
    await switchConfig(projectId, serialNo, opcode);
  }

  Future<void> switchConfig(pidId,sn,opcode) async {
    var json = Tea.encryptTea(jsonEncode({"pid": pidId, "sn": sn, "opcode": opcode}),_getController.getKey());
    debugPrint(Tea.decryptTea(json.toString(),_getController.getKey()).toString());
    var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('swconf', _getController.getUid()) + json.toString()}&key=${_getController.getKey()}'),
      headers: headers
    );
    debugPrint(response.body);
    debugPrint(response.statusCode.toString());
    debugPrint(Tea.decryptTea(response.body,_getController.getKey()).toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      InstrumentComponents().showToast(Get.context!, 'Muvaffaqiyatli', 'Ma’lumot o’zgartirildi'.tr, false, 2);
    } else {
      InstrumentComponents().showToast(Get.context!, 'Xatolik', 'Xatolik yuz berdi'.tr, true, 3);
    }
  }

}