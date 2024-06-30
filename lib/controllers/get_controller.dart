import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hicom/companents/instrument/instrument_components.dart';
import 'package:hicom/models/settings_info.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../models/districts_model.dart';
import '../models/login_model.dart';
import '../models/province_model.dart';
import '../models/register_model.dart';
import '../models/sample/Switch_detail_model.dart';
import '../models/sample/get_users_model.dart';
import '../models/sample/project_model.dart';
import '../models/sample/switch_list_model.dart';


class GetController extends GetxController {
  var height = 0.0.obs;
  var width = 0.0.obs;
  var fullName = 'Dilshodjon Haydarov'.obs;
  var isSearch = false.obs;
  var isNightMode = false.obs;
  var code = '+998'.obs;
  RxList<int> dropDownItems = <int>[0, 0, 0, 0].obs;
  RxList<String> dropDownItemsTitle = <String>['Uzbekistan'].obs;
  RxList<String> dropDownItem = <String>['Sotuvchi','Ornatuvchi'].obs;
  var responseText = ''.obs;
  var whileApi = false.obs;


  final qrKey = GlobalKey(debugLabel: 'QR');
  var result = Rxn<Barcode>();
  QRViewController? controller;
  var isLampOn = false.obs;
  var cameraFacing = CameraFacing.back.obs;

  void onQRViewCreated(QRViewController qrController) {
    controller = qrController;
    controller?.scannedDataStream.listen((scanData) {
      result.value = scanData;
      if (scanData.code != null) {
        print(scanData.code.toString());
        print(scanData.code.toString());

        switchSerialProjectController.text = scanData.code.toString();
        controller?.pauseCamera();
        Get.back();
      }
    });
  }

  void reassembleCamera() {
    if (GetPlatform.isAndroid) {
      controller?.pauseCamera();
    } else if (GetPlatform.isIOS) {
      controller?.resumeCamera();
    }
  }

  void toggleLamp() {
    isLampOn.value = !isLampOn.value;
    controller?.toggleFlash();
  }

  void toggleCamera() {
    if (cameraFacing.value == CameraFacing.back) {
      cameraFacing.value = CameraFacing.front;
    } else {
      cameraFacing.value = CameraFacing.back;
    }
    controller?.flipCamera();
  }

  void changeDropDownItems(int index, int newValue) {
    if (index >= 0 && index < dropDownItems.length) {
      dropDownItems[index] = newValue;
    }
  }

  void changeDropDownItemsTitle(int index, String newValue) {
    if (index >= 0 && index < dropDownItemsTitle.length) {
      dropDownItemsTitle[index] = newValue;
    }
  }

  changeFullName(String name) {fullName.value = name;}

  String getKey() {
   if (GetStorage().read('key') != null) {
     return GetStorage().read('key').toString();
   } else {
     return '50UvFayZ2w5u3O9B';
   }
  }

  void writeKey(String token) {GetStorage().write('key', token);}

  void clearKey() {GetStorage().remove('key');}

  void writeUid(String uid) {GetStorage().write('uid', uid);}

  String getUid() {return GetStorage().read('uid') ?? '';}

  void clearUid() {GetStorage().remove('uid');}

  void writeUser(LoginModel loginModel) {GetStorage().write('user', jsonEncode(loginModel.toJson()));}

  void getUser() {
    if (GetStorage().read('user') != null) {
      loginModel.value = LoginModel.fromJson(jsonDecode(GetStorage().read('user')));
    }
  }

  void clearUser() {GetStorage().remove('user');}

  void writeLogin(String number, String session) {
    GetStorage().write('number', number);
    GetStorage().write('session', session);
  }

  String getNumber() {
    if (GetStorage().read('number') != null) {
      return GetStorage().read('number').toString();
    } else {
      return '';
    }
  }

  String getSession() {
    if (GetStorage().read('session') != null) {
      return GetStorage().read('session').toString();
    } else {
      return '';
    }
  }

  void addAllData(number, session, keys, uid) {
    writeLogin(number, session);
    writeKey(keys);
    writeUid(uid);
    InstrumentComponents().showToast(Get.context!, 'OK', 'Masulot saqlandi'.tr, false, 2);
  }

  void addUserData(data){
    if (data != null) {
      var dataJson = jsonDecode(data.toString());
      writeLogin(dataJson['Phone'].toString(), dataJson['SessionToken'].toString());
      writeKey(dataJson['KEY'].toString());
      writeUid(dataJson['UID'].toString());
    } else {
      InstrumentComponents().showToast(Get.context!, 'Xatolik', 'Masulot bo\'sh'.tr, true, 3);
    }
  }

  @override
  void onInit() {
    super.onInit();
    height.value = Get.height;
    width.value = Get.width;
  }

  @override
  void onClose() {
    controller?.dispose();
    super.onClose();
  }

  var districtsModel = DistrictsModel().obs;
  var provinceModel = ProvinceModel().obs;
  var loginModel = LoginModel().obs;
  var registerModel = RegisterModel().obs;
  var projectModel = ProjectModel().obs;
  var getUsersModel = GetUsersModel().obs;
  var switchListModel = SwitchListModel().obs;
  var settingsInfoModel = SettingsInfo().obs;
  //SwitchDetailModel
  var switchDetailModel = SwitchDetailModel().obs;

  void changeSwitchDetailModel(SwitchDetailModel switchDetailModels) {switchDetailModel.value = switchDetailModels;}

  void clearSwitchDetailModel() {switchDetailModel.value = SwitchDetailModel();}

  void changeSettingsInfoModel(SettingsInfo settingsInfo) {settingsInfoModel.value = settingsInfo;}

  void changeSwitchList(SwitchListModel switchLists) {switchListModel.value = switchLists;}

  void clearSwitchList() {switchListModel.value = SwitchListModel();}

  void changeGetUsersModel(GetUsersModel getUsersModels) {getUsersModel.value = getUsersModels;}

  void getProject(ProjectModel projectModels){projectModel.value = projectModels;}

  void getProvince(){
    if (loginModel.value.user != null && loginModel.value.user?.regionId != null) {
      for (var i = 0; i < provinceModel.value.regions!.length; i++) {
        if (provinceModel.value.regions![i].id == loginModel.value.user?.regionId) {
          changeDropDownItems(0, i);
          break;
        }
      }
    }
  }

  void getDistricts(){
    if (loginModel.value.user != null && loginModel.value.user?.regionId != null) {
      for (var i = 0; i < districtsModel.value.districts!.length; i++) {
        if (districtsModel.value.districts![i].id == loginModel.value.user?.districtId) {
          changeDropDownItems(1, i);
          break;
        }
      }
    }
  }

  void changeRegisterModel(RegisterModel registerModels) {registerModel.value = registerModels;}

  void changeDistrictsModel(DistrictsModel districtsModel) {
    this.districtsModel.value = districtsModel;
    addDistrictsModel(Districts(id: 0, regionId: 0, name: 'Tanlang'));
  }

  void changeProvinceModel(ProvinceModel provinceModels) {
    provinceModel.value = provinceModels;
    addRegions(Regions(countryId: 0, id: 0, name: 'Tanlang'));
  }

  void addRegions(Regions regions) {provinceModel.value.regions!.insert(0, regions);}

  void addDistrictsModel(Districts districtsModels) {districtsModel.value.districts!.insert(0, districtsModels);}

  void clearProvinceModel() {provinceModel.value = ProvinceModel();}

  void clearDistrictsModel() {districtsModel.value = DistrictsModel();}

  void changeLoginModel(LoginModel loginModel) {this.loginModel.value = loginModel;}

  void clearLoginModel() {loginModel.value = LoginModel();}

  int getType() {return dropDownItems[2];}

  String getQueryString(String action, String uid) {
    String returnUrl = "";

    switch (action) {
      case "wxl":
        returnUrl = "act=wxl&uid=null&dt=";
        break;
      case "bmb":
        returnUrl = "act=bmb&uid=$uid&dt=";
        break;
      case "prjshrwx":
        returnUrl = "act=prjshrwx&uid=$uid&dt=";
        break;
      case "emreg":
        returnUrl = "act=emreg&uid=null&dt=";
        break;
      case "eml":
        returnUrl = "act=eml&uid=null&dt=";
        break;
      case "login":
        returnUrl= "act=login&uid=null&dt=";
        break;
      case "sendcode":
        returnUrl= "act=sendcode&uid=null&dt=";
        break;
      case "checkcode":
        returnUrl= "act=checkcode&uid=null&dt=";
        break;
      case "signup":
        returnUrl= "act=signup&uid=null&dt=";
        break;
      case "changeprofile":
        returnUrl= "act=changeprofile&uid=null&dt=";
        break;
      case "regions":
        returnUrl= "act=regions&uid=null&dt=";
        break;
      case "districts":
        returnUrl= "act=districts&uid=null&dt=";
        break;
      case "settings":
        returnUrl= "act=settings&uid=null&dt=";
        break;
      case "prjshrem":
        returnUrl= "act=prjshrem&uid=$uid&dt=";
        break;
      case "logout":
        returnUrl= "act=delaccount&uid=$uid&dt=";
        break;
      case "alterpd":
        returnUrl= "act=alterpd&uid=$uid&dt=";
        break;
      case "resetpd":
        returnUrl= "act=resetpd&uid=null&dt=";
        break;
      case "reset":
        returnUrl= "act=reset&uid=null&dt=";
        break;
      case "getNicknameAndMobile":
        returnUrl= "act=userdet&uid=$uid&dt=";
        break;
      case "altermb":
        returnUrl= "act=altermb&uid=$uid&dt=";
        break;
      case "prjmng":
        returnUrl= "act=prjmng&uid=$uid&dt=";
        break;
      case "prjadd":
        returnUrl= "act=prjadd&uid=$uid&dt=";
        break;
      case "prjdel":
        returnUrl= "act=prjdel&uid=$uid&dt=";
        break;
      case "prjren":
        returnUrl= "act=prjren&uid=$uid&dt=";
        break;
      case "prjnote":
        returnUrl= "act=prjnote&uid=$uid&dt=";
        break;
      case "prjjoin":
        returnUrl= "act=prjjoin&uid=$uid&dt=";
        break;
      case "prjtrf":
        returnUrl= "act=prjtrf&uid=$uid&dt=";
        break;
      case "prjrecv":
        returnUrl= "act=prjrecv&uid=$uid&dt=";
        break;
      case "prjjoinren":
        returnUrl= "act=prjjoinren&uid=$uid&dt=";
        break;
      case "prjstat":
        returnUrl= "act=prjstat&uid=$uid&dt=";
        break;
      case "prjexit":
        returnUrl= "act=prjexit&uid=$uid&dt=";
        break;
      case "swadd":
        returnUrl= "act=swadd&uid=$uid&dt=";
        break;
      case "swmng":
        returnUrl= "act=swmng&uid=$uid&dt=";
        break;

      case "swren":
        returnUrl= "act=swren&uid=$uid&dt=";
        break;
      case "swnote":
        returnUrl= "act=swnote&uid=$uid&dt=";
        break;
      case "swdel":
        returnUrl= "act=swdel&uid=$uid&dt=";
        break;
      case "swpnote":
        returnUrl= "act=swpnote&uid=$uid&dt=";
        break;
      case "swkey":
        returnUrl= "act=swkey&uid=$uid&dt=";
        break;
      case "swfwv":
        returnUrl= "act=swfwv&uid=$uid&dt=";
        break;
      case "swrst":
        returnUrl= "act=swrst&uid=$uid&dt=";
        break;
      case "swreb":
        returnUrl= "act=swreb&uid=$uid&dt=";
        break;
      case "swupd":
        returnUrl= "act=swupd&uid=$uid&dt=";
        break;
      case "swsort":
        returnUrl= "act=swsort&uid=$uid&dt=";
        break;
      case "swconf":
        returnUrl= "act=swconf&uid=$uid&dt=";
        break;
      case "swdet":
        returnUrl= "act=swdet&uid=$uid&dt=";
        break;
      case "swcall":
        returnUrl= "act=swcall&uid=$uid&dt=";
        break;
      case "swtask":
        returnUrl= "act=swtask&uid=$uid&dt=";
        break;
      default:
        break;
    }

    return returnUrl;
  }


  final TextEditingController searchController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final RefreshController refreshController = RefreshController(initialRefresh: false);
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  final TextEditingController nameProjectController = TextEditingController();
  final TextEditingController switchNameProjectController = TextEditingController();
  final TextEditingController switchSerialProjectController = TextEditingController();
  final TextEditingController noteProjectController = TextEditingController();
  final TextEditingController passwordProjectController = TextEditingController();


  late TabController tabController;


  String maskString(String input) {
    if (input.length < 20) return input;
    String prefix = input.substring(0, 6);
    String suffix = input.substring(19);
    String replacement = '*' * (20 - 6);
    return '$prefix$replacement$suffix';
  }

  String getSettings(String name) {
    if (settingsInfoModel.value.settings == null) return "";
    for (var i = 0; i < settingsInfoModel.value.settings!.length; i++) {
      if (settingsInfoModel.value.settings![i].name == name) {
        return settingsInfoModel.value.settings![i].value.toString();
      }
    }
    return "";
  }

  String formatPower(double? power) {
    if (power! <= 0) return "--";
    return "${power.toStringAsFixed(1)}W";
  }

  String trafficToString(double kb) {
    if (kb <= 0) return "--";

    double gb = kb / 1024 / 1024 / 1024;
    if (gb >= 1) {
      if (gb != gb.floor()) return "${gb.toStringAsFixed(0)}Gb";
      return "${gb.toInt()}Gb";
    }

    double mb = kb / 1024 / 1024;
    if (mb >= 1) {
      if (mb != mb.floor()) return "${mb.toStringAsFixed(0)}Mb";
      return "${mb.toInt()}Mb";
    }

    if (kb != kb.floor()) return "${kb.toStringAsFixed(0)}Kb";
    return "${kb.toInt()}Kb";
  }

  static const int switchTypeUnknown = 0;
  static const int switchTypeM42 = 1;
  static const int switchTypeF411 = 2;
  static const int switchTypeF82 = 3;
  static const int switchTypeM82 = 4;
  static const int switchTypeG82 = 5;
  static const int switchTypeG83 = 6;
  static const int switchTypeG163 = 7;
  static const int switchTypeF163 = 8;

  static const int portDetailsHeader = -200;
  static const int portTypeLan1 = -100;
  static const int portTypeLan2 = -99;
  static const int portTypeLan3 = -98;
  static const int portTypeLan4 = -97;
  static const int portTypeSfp = -50;


  List<String> getPortMap(int type) {
    switch (type) {
      case switchTypeF411:
        return ['', '', '', '1', '2', '3', '4', '', 'L1', 'SFP', '', ''];
      case switchTypeM42:
        return ['', '', '', '1', '2', '3', '4', '', 'L1', 'L2', '', ''];
      case switchTypeF82:
      case switchTypeM82:
        return ['', '', '', '1', '2', '3', '4', '5', '6', '7', '8', 'L1', 'L2'];
      case switchTypeG82:
        return ['', '', '', '1', '2', '3', '4', '5', '6', '7', '8', 'L1', 'L2', 'SFP'];
      case switchTypeG83:
        return ['', '', '', '1', '2', '3', '4', '5', '6', '7', '8', 'L1', 'L2', 'SFP'];
      case switchTypeF163:
      case switchTypeG163:
        return ['', '', '', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', 'L1', 'L2', 'SFP'];
    }
    return ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
  }

  int typeFromSerialNumber(String serialNo) {
    if (serialNo.startsWith("HIM42") || serialNo.startsWith("PS106D") || serialNo.startsWith("PS204DM")) {
      return switchTypeM42;
    } else if (serialNo.startsWith("HIF411") || serialNo.startsWith("GPS204")) {
      return switchTypeF411;
    } else if (serialNo.startsWith("HIF82") || serialNo.startsWith("GPS208")) {
      return switchTypeF82;
    } else if (serialNo.startsWith("HIM82") || serialNo.startsWith("PS208DM")) {
      return switchTypeM82;
    } else if (serialNo.startsWith("HIG82") || serialNo.startsWith("PS208G")) {
      return switchTypeG82;
    } else if (serialNo.startsWith("HIG83") || serialNo.startsWith("PS308G")) {
      return switchTypeG83;
    } else if (serialNo.startsWith("HIG163") || serialNo.startsWith("PS316G")) {
      return switchTypeG163;
    } else if (serialNo.startsWith("HIF163") || serialNo.startsWith("GPS316")) {
      return switchTypeF163;
    } else {
      return switchTypeF82;
    }
  }

  String getTypeName(int type) {
    switch (type) {
      case switchTypeM42:
        return "GPS208";
      case switchTypeF411:
        return "HIF411";
      case switchTypeF82:
        return "HIF82";
      case switchTypeM82:
        return "HIM82";
      case switchTypeG82:
        return "HIG82";
      case switchTypeG83:
        return "HIG83";
      case switchTypeG163:
        return "HIG163";
      case switchTypeF163:
        return "HIF163";
      default:
        return "HIF82";
    }
  }

  List<String> getPortList(int type) {
    List<String> result = getPortMap(type);
    //['', '', '', '1', '2', '3', '4', '', 'L1', 'L2', '', ''];  '' item from list remove
    for (int i = 0; i < result.length; i++) {
      if (result[i] == '') {
        print('remove $result[$i]');
        result.removeAt(i);
      } else {
        print('keep $result[$i]');
      }
    }
    return result;
  }


}
