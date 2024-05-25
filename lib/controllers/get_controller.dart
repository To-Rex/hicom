import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../models/districts_model.dart';
import '../models/login_model.dart';
import '../models/province_model.dart';
import '../models/register_model.dart';


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

  changeFullName(String name) {
    fullName.value = name;
  }

  //get token from storage

 String getKey() {
   if (GetStorage().read('key') != null) {
     return GetStorage().read('key').toString();
   } else {
     return '50UvFayZ2w5u3O9B';
   }
  }

  void writeKey(String token) {GetStorage().write('key', token);}

  void clearKey() {
    GetStorage().remove('key');
  }

  void writeUid(String uid) {
    GetStorage().write('uid', uid);
  }

  String getUid() {return GetStorage().read('uid') ?? '';}

  void clearUid() {
    GetStorage().remove('uid');
  }

  void writeUser(LoginModel loginModel) {
    GetStorage().write('user', jsonEncode(loginModel.toJson()));
  }

  void getUser() {
    if (GetStorage().read('user') != null) {
      loginModel.value = LoginModel.fromJson(jsonDecode(GetStorage().read('user')));
    }
  }

  void clearUser() {
    GetStorage().remove('user');
  }

  //number and session
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

  @override
  void onInit() {
    super.onInit();
    height.value = Get.height;
    width.value = Get.width;
  }

  var districtsModel = DistrictsModel().obs;
  var provinceModel = ProvinceModel().obs;
  var loginModel = LoginModel().obs;
  var registerModel = RegisterModel().obs;

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

  void changeRegisterModel(RegisterModel registerModels) {
    registerModel.value = registerModels;
  }

  void changeDistrictsModel(DistrictsModel districtsModel) {
    this.districtsModel.value = districtsModel;
    addDistrictsModel(Districts(id: 0, regionId: 0, name: 'Tanlang'));
  }

  void changeProvinceModel(ProvinceModel provinceModels) {
    provinceModel.value = provinceModels;
    addRegions(Regions(countryId: 0, id: 0, name: 'Tanlang'));
  }


  //provinceModel.value = provinceModels.regions.insert(0, Regions(countryId: 0, id: 0, name: 'Tanlang'));
  void addRegions(Regions regions) {
    provinceModel.value.regions!.insert(0, regions);
  }


  void addDistrictsModel(Districts districtsModels) {
    districtsModel.value.districts!.insert(0, districtsModels);
  }

  void clearProvinceModel() {
    provinceModel.value = ProvinceModel();
  }

  void clearDistrictsModel() {
    districtsModel.value = DistrictsModel();
  }

  void changeLoginModel(LoginModel loginModel) {
    this.loginModel.value = loginModel;
  }

  void clearLoginModel() {
    loginModel.value = LoginModel();
  }

  int getType() {
    return dropDownItems[2];
  }

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


}
