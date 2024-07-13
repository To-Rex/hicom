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
import '../pages/auth/verify_page_number.dart';
import '../pages/sample/sample_page.dart';
import '../splash_screen.dart';
import 'get_controller.dart';

class ApiController extends GetxController {
  final GetController _getController = Get.put(GetController());

  static const String _baseUrl = 'http://185.196.213.76:8000/SSC_Switch/hicom?';
  static const String key = '50UvFayZ2w5u3O9B';
  static const String switchPassword = '123456';

  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
  };

  void timeOut(sec,func) => Timer(Duration(milliseconds: sec), func);


  Future<void> getRegions(data, act) async {
    var response = await get(Uri.parse('${_baseUrl + _getController.getQueryString(act, 'null') + data}&key=$key'), headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (act == 'regions') {
        _getController.clearProvinceModel();
        _getController.changeProvinceModel(ProvinceModel.fromJson(jsonDecode(Tea.decryptTea(response.body, key).toString())));
      } else if (act == 'districts') {
        _getController.clearDistrictsModel();
        debugPrint(Tea.decryptTea(response.body, key).toString());
        _getController.fullName.value = Tea.decryptTea(response.body, key);
        _getController.changeDistrictsModel(DistrictsModel.fromJson(jsonDecode(Tea.decryptTea(response.body, key).toString())));
      }
    } else {
      InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Xatolik yuz berdi'.tr, true, 3);
    }
  }

  Future<void> sendCode() async {
    var json = Tea.encryptTea('{"phone": "${_getController.code.value + _getController.phoneController.text}","code":""}', _getController.getKey());
    var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('sendcode', 'null') + json.toString()}&key=${_getController.getKey()}'), headers: headers);
    debugPrint(response.body);
    debugPrint(Tea.decryptTea(response.body, _getController.getKey()).toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (jsonDecode(utf8.decode(Tea.decryptTea(response.body, _getController.getKey()).toString().codeUnits))['errcode'] == 0) {
        InstrumentComponents().showToast(Get.context!, 'Muvaffaqiyatli', '${_getController.code.value + _getController.phoneController.text} ${'raqamiga Kod yuborildi'.tr}', false, 2);
        //Get.to(VerifyPage());
        Get.to(VerifyPageNumber(phoneNumber: _getController.code.value + _getController.phoneController.text));
      } else {
        InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Xatolik yuz berdi', true, 3);
      }
    } else {
      InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Xatolik yuz berdi', true, 3);
    }
  }

  Future<void> checkCode() async {
    try {
      var json = Tea.encryptTea('{"phone": "${_getController.code.value + _getController.phoneController.text}","code":"${_getController.verifyCodeControllers[0].text+_getController.verifyCodeControllers[1].text+_getController.verifyCodeControllers[2].text+_getController.verifyCodeControllers[3].text+_getController.verifyCodeControllers[4].text}"}', _getController.getKey());
      var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('checkcode', 'null') + json.toString()}&key=${_getController.getKey()}'), headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (jsonDecode(utf8.decode(Tea.decryptTea(response.body, _getController.getKey()).toString().codeUnits))['errcode'] == 0) {
          _getController.writeLogin(_getController.code.value + _getController.phoneController.text, jsonDecode(utf8.decode(Tea.decryptTea(response.body, _getController.getKey()).toString().codeUnits))['session']);
          if (jsonDecode(utf8.decode(Tea.decryptTea(response.body, _getController.getKey()).toString().codeUnits))['registered'] == 0) {
            Get.to(RegisterPage());
          } else {
            InstrumentComponents().showToast(Get.context!, 'Muvaffaqiyatli', 'Kiritilgan kod tasdiqlandi'.tr, false, 2);
            _getController.clearVerifyCodeControllers();
            login(_getController.code.value + _getController.phoneController.text, jsonDecode(utf8.decode(Tea.decryptTea(response.body, _getController.getKey()).toString().codeUnits))['session'], key, true);
          }
        } else {
          _getController.clearVerifyCodeControllers();
          InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Kiritilgan kod xato'.tr, true, 3);
        }
      } else {
        InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Xatolik yuz berdi'.tr, true, 3);
      }
    } catch (e) {
      InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Ulanishni tekshiring'.tr, true, 3);
    }
  }

  Future<void> login(phone, session, keys, enter) async {
    try {
      var json = Tea.encryptTea('{"phone": "$phone","session":"$session"}', keys);
      var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('login', 'null') + json.toString()}&key=$keys'), headers: headers);
      debugPrint(response.statusCode.toString());
      debugPrint(Tea.decryptTea(response.body, keys).toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (jsonDecode(Tea.decryptTea(response.body, keys).toString())['errcode'] == 0) {
          _getController.changeLoginModel(LoginModel.fromJson(jsonDecode(Tea.decryptTea(response.body, keys).toString())));
          _getController.writeKey(_getController.loginModel.value.key.toString());
          _getController.writeUid(_getController.loginModel.value.uid.toString());
          _getController.writeUser(_getController.loginModel.value);
          if (enter) {
            _getController.setRequest();
            Get.offAll(SamplePage());
          }
        } else {
          _getController.sec.value = 0;
          if (jsonDecode(utf8.decode(Tea.decryptTea(response.body, keys).toString().codeUnits))['errcode'] == 20003) {
            if (jsonDecode(utf8.decode(Tea.decryptTea(response.body, keys).toString().codeUnits))['errmsg'] == 'user not exist'){
              Get.offAll(() => RegisterPage());
            } else{
              _getController.writeKey(_getController.loginModel.value.key.toString());
              _getController.writeUid(_getController.loginModel.value.uid.toString());
              _getController.writeUser(_getController.loginModel.value);
              _getController.clearKey();
              _getController.clearUid();
              _getController.clearUser();
              Get.offAll(() => SplashScreen());
            }
            InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Hisobingizga kirishda xatolik yuz berdi.'.tr, true, 3);
          } else {
            InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Serverga ulanishda xatolik yuz berdi.'.tr, true, 3);
          }
        }
      }
    } catch (e) {
      InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Iltimos ulanishni tekshiring!'.tr, true, 3);
    }
  }

  Future<void> signUp() async {
    try {
      var json = Tea.encryptTea('{"phone": "${_getController.code.value + _getController.phoneController.text}","name": "${_getController.nameController.text}","type": "${_getController.dropDownItems[2]}","country_id": "1","region_id": "${_getController.provinceModel.value.regions![_getController.dropDownItems[0]].id.toString()}", "district_id": "${_getController.districtsModel.value.districts![_getController.dropDownItems[1]].id.toString()}"}', key);
      debugPrint(json.toString());
      debugPrint('${_baseUrl + _getController.getQueryString('signup', 'null') + json.toString()}&key=$key}');
      var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('signup', 'null') + json.toString()}&key=$key'), headers: headers);
      debugPrint(response.body);
      debugPrint(response.statusCode.toString());
      debugPrint(Tea.decryptTea(response.body, key).toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        _getController.changeRegisterModel(RegisterModel.fromJson(jsonDecode(Tea.decryptTea(response.body, key).toString())));
        _getController.writeKey(_getController.registerModel.value.key.toString());
        _getController.writeUid(_getController.registerModel.value.uid.toString());
        login(_getController.getNumber(), _getController.getSession(), key, true);
      } else {
        InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Serverga ulanishda xatolik yuz berdi.'.tr, true, 3);
      }
    } catch (e) {
      InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Iltimos ulanishni tekshiring!'.tr, true, 3);
    }
  }

  Future<void> editUser() async {
    try {
      var json = Tea.encryptTea('{"phone": "${_getController.code.value + _getController.phoneController.text == '+998' ? _getController.getNumber() : _getController.code.value + _getController.phoneController.text}","name": "${_getController.nameController.text}","type": "${_getController.dropDownItems[2]}","country_id": "${_getController.dropDownItemsTitle[0] == 'Uzbekistan'.tr ? 1 : 2}","region_id": "${_getController.dropDownItemsTitle[0] == 'Uzbekistan'.tr ? _getController.provinceModel.value.regions![_getController.dropDownItems[0]].id.toString() : "0"}", "district_id": "${_getController.dropDownItemsTitle[0] == 'Uzbekistan'.tr ? _getController.districtsModel.value.districts![_getController.dropDownItems[1]].id.toString() : "0"}"}', _getController.getKey());
      debugPrint('${_baseUrl + _getController.getQueryString('changeprofile', 'null') + json.toString()}&key=${_getController.getKey()}');
      var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('changeprofile', 'null') + json.toString()}&key=${_getController.getKey()}'), headers: headers);
      debugPrint(response.body);
      debugPrint(response.statusCode.toString());
      debugPrint(Tea.decryptTea(response.body, _getController.getKey()).toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back();
        login(_getController.getNumber(), _getController.getSession(), key, false);
      } else {
        InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Serverga ulanishda xatolik yuz berdi.'.tr, true, 3);
      }
    } catch (e) {
      InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Iltimos ulanishni tekshiring!'.tr, true, 3);
    }
  }

  Future<void> deleteUser() async {
    try {
      var json = Tea.encryptTea(jsonEncode(_getController.loginModel.value), _getController.getKey());
      var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('logout', _getController.getUid()) + json.toString()}&key=${_getController.getKey()}'), headers: headers);
      debugPrint(response.body);
      debugPrint(response.statusCode.toString());
      debugPrint(Tea.decryptTea(response.body, _getController.getKey()).toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        InstrumentComponents().showToast(Get.context!, 'Muvaffaqiyatli', 'Ushbu foydalanuvchi hisobi o‘chirildi.'.tr, true, 3);
      } else {
        InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Serverga ulanishda xatolik yuz berdi.'.tr, true, 3);
      }
    } catch(e) {
      InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Iltimos ulanishni tekshiring!'.tr, true, 3);
    }
  }

  Future<void> getSettings() async {
    if(_getController.isRequest.value) {
      debugPrint('getSettings');
      _getController.setRequest();
      try {
        debugPrint('${_baseUrl + _getController.getQueryString('settings', 'null') + Tea.encryptTea('{}', _getController.getKey())}&key=${_getController.getKey()}');
        var response = await get(Uri.parse('${_baseUrl + _getController.getQueryString('settings', 'null') + Tea.encryptTea('{}', _getController.getKey())}&key=${_getController.getKey()}'), headers: headers);
        debugPrint(response.body);
        debugPrint(response.statusCode.toString());
        if (response.statusCode == 200 || response.statusCode == 201) {
          _getController.changeSettingsInfoModel(SettingsInfo.fromJson(jsonDecode(Tea.decryptTea(response.body, _getController.getKey()).toString())));
        } else {
          InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Serverga ulanishda xatolik yuz berdi.'.tr, true, 3);
        }
      } catch (e){
        InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Iltimos ulanishni tekshiring!'.tr, true, 3);
      }
    }
  }

  Future<void> getProjects() async {
    debugPrint('getProjects');
    if(_getController.isRequest.isTrue) {
      _getController.setRequest();
      try {
        InstrumentComponents().loadingDialog(Get.context!);
        var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('prjmng', _getController.getUid()) + Tea.encryptTea('{}', _getController.getKey())}&key=${_getController.getKey()}'), headers: headers);
        debugPrint(response.body.toString());
        debugPrint(Tea.decryptTea(response.body.toString(), _getController.getKey()).toString());
        if (response.statusCode == 200 || response.statusCode == 201) {
          if (jsonDecode(Tea.decryptTea(response.body.toString(), _getController.getKey()).toString()) == null || jsonDecode(Tea.decryptTea(response.body.toString(), _getController.getKey()).toString()) == '') {
            InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Serverga ulanishda xatolik yuz berdi.'.tr, true, 3);
            login(_getController.getNumber(), _getController.getSession(), _getController.getKey(), false);
          } else{
            _getController.getProject(ProjectModel.fromJson(jsonDecode(Tea.decryptTea(response.body.toString(), _getController.getKey()))));
          }
        } else {
          InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Serverga ulanishda xatolik yuz berdi.'.tr, true, 3);
        }
        Get.back();
      } catch (e){
        InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Iltimos ulanishni tekshiring!'.tr, true, 3);
      }
    }
  }

  Future<void> renameProjects(pidId, name, note) async {
    try {
      var json = Tea.encryptTea(jsonEncode({"pid": pidId, "name": name}), _getController.getKey());
      var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('prjren', _getController.getUid()) + json.toString()}&key=${_getController.getKey()}'), headers: headers);
      debugPrint(response.body);
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (jsonDecode(Tea.decryptTea(response.body, _getController.getKey()).toString())['errcode'] == 20000) {
          Get.back();
          InstrumentComponents().showToast(Get.context!, 'Xatolik', 'Sizda bunday huquq mavjud emas!'.tr, true, 3);
        } else {
          if (note != '') {
            await renameProjectsNote(pidId, note);
          } else {
            Get.back();
            getProjects();
          }
        }
      } else {
        InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Serverga ulanishda xatolik yuz berdi.'.tr, true, 3);
      }
    } catch (e){
      InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Iltimos ulanishni tekshiring!'.tr, true, 3);
    }
  }

  Future<void> renameProjectsNote(pidId, note) async {
    try {
      if (note == '') note = ' ';
      var json = Tea.encryptTea(jsonEncode({"pid": pidId, "note": note}), _getController.getKey());
      var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('prjnote', _getController.getUid()) + json.toString()}&key=${_getController.getKey()}'), headers: headers);
      debugPrint(response.body);
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (jsonDecode(Tea.decryptTea(response.body, _getController.getKey()).toString())['errcode'] == 20000) {
          InstrumentComponents().showToast(Get.context!, 'Xatolik', 'Sizda bunday huquq mavjud emas!'.tr, true, 3);
        } else {
          getProjects();
        }
      } else {
        InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Serverga ulanishda xatolik yuz berdi.'.tr, true, 3);
      }
      Get.back();
    } catch (e){
      InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Iltimos ulanishni tekshiring!'.tr, true, 3);
    }
  }

  Future<void> getProjectsUsers(pidId) async {
    try {
      var json = Tea.encryptTea(jsonEncode({"pid": pidId}), _getController.getKey());
      var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('prjjoin', _getController.getUid()) + json.toString()}&key=${_getController.getKey()}'), headers: headers);
      debugPrint(response.body);
      debugPrint(response.statusCode.toString());
      debugPrint(Tea.decryptTea(response.body, _getController.getKey()).toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (jsonDecode(Tea.decryptTea(response.body, _getController.getKey()).toString())['errcode'] == 20000) {
          Get.back();
          InstrumentComponents().showToast(Get.context!, 'Xatolik', 'Sizda bunday huquq mavjud emas!'.tr, true, 3);
        } else {
          _getController.getUsersModel(GetUsersModel.fromJson(jsonDecode(Tea.decryptTea(response.body.toString(), _getController.getKey()))));
        }
      } else {
        InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Serverga ulanishda xatolik yuz berdi.'.tr, true, 3);
      }
    } catch (e){
      InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Iltimos ulanishni tekshiring!'.tr, true, 3);
    }
  }

  Future<void> projectShare(pidId) async {
    try {
      var json = Tea.encryptTea(jsonEncode({"pid": pidId, "phone": _getController.nameProjectController.text, "name": _getController.noteProjectController.text}), _getController.getKey());
      var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('prjshrem', _getController.getUid()) + json.toString()}&key=${_getController.getKey()}'), headers: headers);
      debugPrint(response.body);
      debugPrint(Tea.decryptTea(response.body, _getController.getKey()).toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (jsonDecode(Tea.decryptTea(response.body, _getController.getKey()).toString())['errcode'] == 20000) {
          Get.back();
          InstrumentComponents().showToast(Get.context!, 'Diqqat!', 'Ushbu foydalanuvchi allaqachon taklif qilgan.'.tr, false, 2);
        } else if (jsonDecode(Tea.decryptTea(response.body, _getController.getKey()).toString())['errcode'] == 1) {
          InstrumentComponents().showToast(Get.context!, 'Xatolik', 'Ushbu foydalanuvchi tizimda mavjud emas!'.tr, true, 3);
        } else if (jsonDecode(Tea.decryptTea(response.body, _getController.getKey()).toString())['errcode'] == 0) {
          Get.back();
          InstrumentComponents().showToast(Get.context!, 'Muvaffaqiyatli', 'Foydalanuvchi taklif qilindi'.tr, false, 2);
        } else {
          Get.back();
          InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Serverga ulanishda xatolik yuz berdi.'.tr, true, 3);
        }
      } else {
        InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Serverga ulanishda xatolik yuz berdi.'.tr, true, 3);
      }
    } catch (e){
      InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Iltimos ulanishni tekshiring!'.tr, true, 3);
    }
  }

  Future<void> projectDelete(pidId) async {
    try {
      var json = Tea.encryptTea(jsonEncode({"pid": pidId}), _getController.getKey());
      var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('prjdel', _getController.getUid()) + json.toString()}&key=${_getController.getKey()}'), headers: headers);
      debugPrint(response.body);
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (jsonDecode(Tea.decryptTea(response.body, _getController.getKey()).toString())['errcode'] == 0) {
          getProjects();
        } else {
          InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Sizda bunday huquq mavjud emas!'.tr, true, 3);
        }
      } else {
        InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Serverga ulanishda xatolik yuz berdi.'.tr, true, 3);
      }
    } catch (e){
      InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Iltimos ulanishni tekshiring!'.tr, true, 3);
    }
  }

  Future<void> addProjects() async {
    debugPrint(_getController.switchSerialProjectController.text);
    try {
      var json = Tea.encryptTea(jsonEncode({'sna': [_getController.switchSerialProjectController.text], 'na': [_getController.switchNameProjectController.text], 'pda': [_getController.passwordProjectController.text], 'name': _getController.nameProjectController.text, 'note': '', 'auto': 0}), _getController.getKey());
      var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('prjadd', _getController.getUid()) + json.toString()}&key=${_getController.getKey()}'), headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(Tea.decryptTea(response.body, _getController.getKey()).toString());
        if (jsonDecode(Tea.decryptTea(response.body, _getController.getKey()).toString())['errcode'] == 29999) {
          InstrumentComponents().showToast(Get.context!, 'Diqqat!', 'Kiritilgan ma’lumotlar (Masalan, seriya raqam) noto‘g‘ri!'.tr, true, 1);
        } if (jsonDecode(Tea.decryptTea(response.body, _getController.getKey()).toString())['errcode'] == 20000) {
          InstrumentComponents().showToast(Get.context!, 'Diqqat!', 'Kiritilgan ma’lumotlar (Masalan, seriya raqam) noto‘g‘ri!'.tr, true, 1);
        }
        else if (jsonDecode(Tea.decryptTea(response.body, _getController.getKey()).toString())['errcode'] == 0 && jsonDecode(Tea.decryptTea(response.body, _getController.getKey()).toString())['bound'].length != 0) {
          InstrumentComponents().showToast(Get.context!, 'Diqqat!', 'Ushbu loyiha boshqa foydalanuvchilarda mavjud.'.tr, false, 3);
        } else if (jsonDecode(Tea.decryptTea(response.body, _getController.getKey()).toString())['errcode'] == 0 && jsonDecode(Tea.decryptTea(response.body, _getController.getKey()).toString())['noonline'].length != 0) {
          InstrumentComponents().showToast(Get.context!, 'Diqqat!', 'Bu qurilma online emas.'.tr, false, 3);
        }
        else if (jsonDecode(Tea.decryptTea(response.body, _getController.getKey()).toString())['errcode'] == 0) {
          Get.back();
          _getController.clearControllers();
          InstrumentComponents().showToast(Get.context!, 'Muvaffaqiyatli', 'Yangi loyiha qo‘shildi.'.tr, false, 2);
          getProjects();
        }
      } else {
        Get.back();
        InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Serverga ulanishda xatolik yuz berdi.'.tr, true, 3);
      }
    } catch (e){
      debugPrint(e.toString());
      Get.back();
      InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Iltimos ulanishni tekshiring!'.tr, true, 3);
    }
  }

  Future<void> getSwitchList(pidId) async {
    try {
      _getController.clearSwitchList();
      var json = Tea.encryptTea(jsonEncode({"pid": pidId}), _getController.getKey());
      var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('swmng', _getController.getUid()) + json.toString()}&key=${_getController.getKey()}'), headers: headers);
      debugPrint(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(Tea.decryptTea(response.body, _getController.getKey()).toString());
        _getController.clearSwitchList();
        if (jsonDecode(Tea.decryptTea(response.body.toString(), _getController.getKey()).toString()) == null || jsonDecode(Tea.decryptTea(response.body.toString(), _getController.getKey()).toString()) == '') {
          login(_getController.getNumber(), _getController.getSession(), _getController.getKey(), false);
        } else {
          _getController.changeSwitchList(SwitchListModel.fromJson(jsonDecode(Tea.decryptTea(response.body, _getController.getKey()))));
        }
      } else {
        InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Serverga ulanishda xatolik yuz berdi.'.tr, true, 3);
      }
    } catch (e){
      InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Iltimos ulanishni tekshiring!'.tr, true, 3);
    }
  }

  Future<void> renameSwitch(pidId, sn) async {
    try {
      var json = Tea.encryptTea(jsonEncode({"pid": pidId, "sn": sn, "name": _getController.nameProjectController.text}), _getController.getKey());
      var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('swren', _getController.getUid()) + json.toString()}&key=${_getController.getKey()}'), headers: headers);
      debugPrint(response.body);
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (_getController.noteProjectController.text == '') {
          Get.back();
          InstrumentComponents().showToast(Get.context!, 'Muvaffaqiyatli', 'Ma’lumot o’zgartirildi'.tr, false, 2);
          getSwitchList(pidId);
        } else {
          renameSwitchNote(pidId, sn);
        }
      } else {
        InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Serverga ulanishda xatolik yuz berdi.'.tr, true, 3);
      }
    } catch (e){
      InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Iltimos ulanishni tekshiring!'.tr, true, 3);
    }
  }

  Future<void> renameSwitchNote(pidId, sn) async {
    try {
      var json = Tea.encryptTea(jsonEncode({"pid": pidId, "sn": sn, "note": _getController.noteProjectController.text}), _getController.getKey());
      var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('swnote', _getController.getUid()) + json.toString()}&key=${_getController.getKey()}'), headers: headers);
      debugPrint(response.body);
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back();
        InstrumentComponents().showToast(Get.context!, 'Muvaffaqiyatli', 'Ma’lumot o’zgartirildi'.tr, false, 2);
        getSwitchList(pidId);
      } else {
        InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Serverga ulanishda xatolik yuz berdi.'.tr, true, 3);
      }
    } catch (e){
      InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Iltimos ulanishni tekshiring!'.tr, true, 3);
    }
  }

  Future<void> deleteSwitch(pidId, sn) async {
    try {
      var json = Tea.encryptTea(jsonEncode({"pid": pidId, "sn": sn}), _getController.getKey());
      var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('swdel', _getController.getUid()) + json.toString()}&key=${_getController.getKey()}'), headers: headers);
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back();
        InstrumentComponents().showToast(Get.context!, 'Muvaffaqiyatli', 'Ma’lumot o’zgartirildi.'.tr, false, 2);getSwitchList(pidId);
      } else {
        InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Serverga ulanishda xatolik yuz berdi.'.tr, true, 3);
      }
    } catch (e){
      InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Iltimos ulanishni tekshiring!'.tr, true, 3);
    }
  }

  Future<void> addSwitch(pidId) async {
    try {
      var json = Tea.encryptTea(jsonEncode({"pid": pidId, "sna": [_getController.switchSerialProjectController.text], "na": [_getController.switchNameProjectController.text], "pda": [_getController.passwordProjectController.text], "auto": 0}), _getController.getKey());
      var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('swadd', _getController.getUid()) + json.toString()}&key=${_getController.getKey()}'), headers: headers);
      debugPrint(response.body);
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (jsonDecode(Tea.decryptTea(response.body, _getController.getKey()).toString())['errcode'] == 29999) {
          InstrumentComponents().showToast(Get.context!, 'Diqqat!', 'Kiritilgan ma’lumotlar (Masalan, seriya raqam) noto‘g‘ri!'.tr, true, 1);
        }
        if (jsonDecode(Tea.decryptTea(response.body, _getController.getKey()).toString())['errcode'] == 20000) {
          InstrumentComponents().showToast(Get.context!, 'Diqqat!', 'Kiritilgan ma’lumotlar (Masalan, seriya raqam) noto‘g‘ri!'.tr, true, 1);
        }
        else if (jsonDecode(Tea.decryptTea(response.body, _getController.getKey()).toString())['errcode'] == 0) {
          Get.back();
          _getController.clearControllers();
          InstrumentComponents().showToast(Get.context!, 'Muvaffaqiyatli', 'Yangi loyiha qo‘shildi.'.tr, false, 2);getSwitchList(pidId);
        } else {
          InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Serverga ulanishda xatolik yuz berdi.'.tr, true, 3);
        }
      } else {
        InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Serverga ulanishda xatolik yuz berdi.'.tr, true, 3);
      }
    } catch (e){
      InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Iltimos ulanishni tekshiring!'.tr, true, 3);
    }
  }

  Future<void> getSwitchDetail(String pidId, String sn) async {
    InstrumentComponents().loadingDialog(Get.context!);
    try {
      _getController.whileApi.value = true;
      var json = Tea.encryptTea(jsonEncode({"pid": pidId, "sn": sn, 'isJoin': "1"}), _getController.getKey());
      debugPrint('${_baseUrl + _getController.getQueryString('swdet', _getController.getUid()) + json.toString()}&key=${_getController.getKey()}');
      var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('swdet', _getController.getUid()) + json.toString()}&key=${_getController.getKey()}'), headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(Tea.decryptTea(response.body, _getController.getKey()).toString());
        if (jsonDecode(Tea.decryptTea(response.body.toString(), _getController.getKey()).toString()) == null || jsonDecode(Tea.decryptTea(response.body.toString(), _getController.getKey()).toString()) == '') {
          Get.back();
        } else{
          if (jsonDecode(Tea.decryptTea(response.body, _getController.getKey()))['errcode'] == 0) {
            _getController.changeSwitchDetailModel(SwitchDetailModel.fromJson(jsonDecode(Tea.decryptTea(response.body, _getController.getKey()))));
          } else if (jsonDecode(Tea.decryptTea(response.body, _getController.getKey()))['errcode'] == 10002) {
            Get.back();
            InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Iltimos hisobingizga qaytadan kiriting.'.tr, true, 3);
          } else {
            InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Serverga ulanishda xatolik yuz berdi.'.tr, true, 3);
          }
        }
      } else {
        InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Serverga ulanishda xatolik yuz berdi.'.tr, true, 3);
      }
    } catch (e) {
      InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Iltimos ulanishni tekshiring!'.tr, true, 3);
    }
    Get.back();
  }

  Future<void> getSwitchDetailRealTime(String pidId, String sn, bool realTime) async {
    if (_getController.whileApi.isTrue) {
      try {
        var json = Tea.encryptTea(jsonEncode({"pid": pidId, "sn": sn, 'isJoin': "1"}), _getController.getKey());
        debugPrint('${_baseUrl + _getController.getQueryString('swdet', _getController.getUid()) + json.toString()}&key=${_getController.getKey()}');
        var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('swdet', _getController.getUid()) + json.toString()}&key=${_getController.getKey()}'), headers: headers);
        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint(Tea.decryptTea(response.body, _getController.getKey()).toString());
          if (jsonDecode(Tea.decryptTea(response.body, _getController.getKey()))['errcode'] == 0) {
            _getController.changeSwitchDetailModel(SwitchDetailModel.fromJson(jsonDecode(Tea.decryptTea(response.body, _getController.getKey()))));
          } else if (jsonDecode(Tea.decryptTea(response.body, _getController.getKey()))['errcode'] == 10002) {
            Get.back();
            InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Iltimos hisobingizga qaytadan kiriting.'.tr, true, 3);
          }
        } else {
          InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Serverga ulanishda xatolik yuz berdi.'.tr, true, 3);
        }
      } catch (e) {
        InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Iltimos ulanishni tekshiring!'.tr, true, 3);
      }
      if (realTime) {
        Timer(const Duration(seconds: 5), () {
          if (_getController.whileApi.isTrue) {
            getSwitchDetailRealTime(pidId, sn, realTime);
          }
        });
      } else {
        Get.back();
      }
    }

  }

  Future<void> portPOESwitch(String projectId, String serialNo, int port, bool state) async {
    try {
      int opcode = 2 | ((port - 1) << 4);
      if (state) opcode |= 1 << 9;
      await switchConfig(projectId, serialNo, opcode);
    } catch (e){
      InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Serverga ulanishda xatolik yuz berdi.'.tr, true, 3);
    }
  }

  Future<void> portExtendSwitch(String projectId, String serialNo, int port, bool state, String firmware) async {
    try {
      int opcode = ((port - 1) << 4);
      if (state) {
        opcode |= 2 * (1 << 9);
      } else {
        debugPrint('${!serialNo.startsWith("HIF")}');
        if (serialNo.startsWith("HIF")) {
          opcode |= 5 * (1 << 9); // Full 1000M
        } else {
          opcode |= 4 * (1 << 9); // Full 100M
        }
      }
      await switchConfig(projectId, serialNo, opcode);
    } catch (e){
      InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Serverga ulanishda xatolik yuz berdi.'.tr, true, 3);
    }
  }

  Future<void> switchConfig(pidId, sn, opcode) async {
    InstrumentComponents().loadingDialog(Get.context!);
    try {
      var json = Tea.encryptTea(jsonEncode({"pid": pidId, "sn": sn, "opcode": opcode}), _getController.getKey());
      var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('swconf', _getController.getUid()) + json.toString()}&key=${_getController.getKey()}'), headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(Tea.decryptTea(response.body, _getController.getKey()).toString());
        if (jsonDecode(Tea.decryptTea(response.body, _getController.getKey()))['errcode'] == 0 && jsonDecode(Tea.decryptTea(response.body, _getController.getKey()))['data']['config'] == 'fail') {
          Get.back();
          InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Iltimos qaytadan urinib ko‘ring.'.tr, true, 3);
        } else if (jsonDecode(Tea.decryptTea(response.body, _getController.getKey()))['errcode'] == 0) {
          timeOut(500, () {
            Get.back();
            getSwitchDetail(pidId, sn);
          });
        }
      } else {
        Get.back();
        InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Serverga ulanishda xatolik yuz berdi.'.tr, true, 3);
      }
    } catch (e) {
      Get.back();
      InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Iltimos ulanishni tekshiring!'.tr, true, 3);
    }
  }

  Future<void> portRestart(String projectId, String serialNo, int port) async {
    try {
      int opcode = 3 | ((port - 1) << 4);
      opcode |= 1 << 9; // Restart
      await switchConfig(projectId, serialNo, opcode);
    } catch (e){
      InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Iltimos ulanishni tekshiring!'.tr, true, 3);
    }
  }

  Future<void> switchReboot(pidId, sn) async {
    try {
      var json = Tea.encryptTea(jsonEncode({"pid": pidId, "sn": sn}), _getController.getKey());
      var response = await post(Uri.parse('${_baseUrl + _getController.getQueryString('swreb', _getController.getUid()) + json.toString()}&key=${_getController.getKey()}'), headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (jsonDecode(Tea.decryptTea(response.body, _getController.getKey()).toString())['errcode'] == 0) {
          InstrumentComponents().showToast(Get.context!, 'Muvaffaqiyatli', 'Qurilma qayta ishga tushdi.'.tr, false, 2);
        } else {
          InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Serverga ulanishda xatolik yuz berdi.'.tr, true, 3);
        }
      } else {
        InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Serverga ulanishda xatolik yuz berdi.'.tr, true, 3);
      }
    } catch (e){
      InstrumentComponents().showToast(Get.context!, 'Xatolik!', 'Iltimos ulanishni tekshiring!'.tr, true, 3);
    }
  }

}
