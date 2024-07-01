import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hicom/controllers/api_controller.dart';
import 'package:hicom/resource/colors.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../controllers/get_controller.dart';

class LoginPage extends StatelessWidget {

  LoginPage({super.key});

  final GetController _getController = Get.put(GetController());

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
            child: Text('Telefon raqamingizni kiriting:'.tr, style: TextStyle(fontSize: Get.width * 0.065, fontWeight: FontWeight.w500))
          ),
          Container(
              width: Get.width,
              margin: EdgeInsets.only(top: Get.height * 0.01, left: Get.width * 0.03, right: Get.width * 0.03,bottom: Get.height * 0.03),
              child: Text('Biz Tasdiqlash kodini jo‘natamiz.'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7), fontSize: Get.width * 0.045, fontWeight: FontWeight.w500))
          ),
          Container(
              width: Get.width,
              //height: Get.height * 0.06,
              margin: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
              ),
              child: IntlPhoneField(
                  controller: _getController.phoneController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  flagsButtonPadding: EdgeInsets.only(left: _getController.width.value * 0.01, right: _getController.width.value * 0.01),
                  onChanged: (phone) {},
                invalidNumberMessage: null,
                  decoration: InputDecoration(
                    hintText: 'Telefon raqam',
                    hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5), fontSize: Get.width * 0.04),
                    border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(7)), borderSide: BorderSide.none),
                    counterText: '',
                    counter: null,
                    semanticCounterText: null,
                    error: null,
                    errorText: null,
                    isDense: true,
                  ),
                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04),
                  showCountryFlag: true,
                  showCursor: true,
                  showDropdownIcon: false,
                  initialCountryCode: 'UZ',
                  dropdownTextStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04),
                  onCountryChanged: (phone) {
                    _getController.code.value = '+${phone.fullCountryCode}';
                  }
              )
          ),
          const Spacer(),
          Container(
              width: Get.width,
              margin: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),),
                  onPressed: () => {
                    ApiController().sendCode(),
                  },
                  child: Text('Tasdiqlash'.tr, style: TextStyle(color: AppColors.white, fontSize: Get.width * 0.045, fontWeight: FontWeight.w500))
              )
          ),
          SizedBox(height: Get.height * 0.05)
        ]
      )
    );
  }
}