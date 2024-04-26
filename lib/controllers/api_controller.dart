import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hicom/controllers/tea.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
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

  Future<void> getData(data,act) async {
    var response = await get(Uri.parse('${_baseUrl+getController.getQueryString('regions', 'null') + data}&key=$key'));
    debugPrint(response.body);
    _getController.fullName.value = TEA.decryptTEA(response.body);
    if (response.statusCode == 200) {
      if (act == 'regions') {
        _getController.changeProvinceModel(ProvinceModel.fromJson(jsonDecode(TEA.decryptTEA(response.body))));
      }else if (act == 'districts') {
        _getController.changeDistrictsModel(DistrictsModel.fromJson(jsonDecode(TEA.decryptTEA(response.body))));
      }
    }else {
      showToast(Get.context!, 'Xatolik', 'Xatolik yuz berdi'.tr, true, 3);
    }
  }

}
