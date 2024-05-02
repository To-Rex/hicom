import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hicom/resource/colors.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../controllers/get_controller.dart';

class VerifyPage extends StatelessWidget {

  VerifyPage({super.key});

  final GetController _getController = Get.put(GetController());
  var code = '+998';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, size: Get.width * 0.07),
            onPressed: () => Get.back())
      ),
      body: Column(
        children: [
          SizedBox(height: Get.height * 0.03),
          Container(
            width: Get.width,
            margin: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.13),
            child: Text('Telefon raqamingizni kiriting:'.tr, style: TextStyle(fontSize: Get.width * 0.07, fontWeight: FontWeight.w500))
          ),
          Container(
              width: Get.width,
              margin: EdgeInsets.only(top: Get.height * 0.01, left: Get.width * 0.03, right: Get.width * 0.03,bottom: Get.height * 0.03),
              child: Text('Biz Tasdiqlash kodini jo‘natamiz.'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7), fontSize: Get.width * 0.045, fontWeight: FontWeight.w500))
          ),


          const Spacer(),
          Container(
              width: Get.width,
              margin: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),),
                  onPressed: () => {},
                  child: Text('Tasdiqlash'.tr, style: TextStyle(color: Theme.of(context).colorScheme.background, fontSize: Get.width * 0.045, fontWeight: FontWeight.w500))
              )
          ),
          SizedBox(height: Get.height * 0.05)
        ]
      )
    );
  }
}