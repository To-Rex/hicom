import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'get_controller.dart';

class ApiController extends GetxController {
  final GetController _getController = Get.put(GetController());
  static const String _baseUrl = 'https://ildizkitoblari.uz';

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


}
