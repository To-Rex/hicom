import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../models/districts_model.dart';
import '../models/login_model.dart';
import '../models/province_model.dart';


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

  @override
  void onInit() {
    super.onInit();
    height.value = Get.height;
    width.value = Get.width;
  }

  var districtsModel = DistrictsModel().obs;
  var provinceModel = ProvinceModel().obs;
  var loginModel = LoginModel().obs;

  void changeDistrictsModel(DistrictsModel districtsModel) {
    this.districtsModel.value = districtsModel;
  }

  void changeProvinceModel(ProvinceModel provinceModel) {
    this.provinceModel.value = provinceModel;
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
