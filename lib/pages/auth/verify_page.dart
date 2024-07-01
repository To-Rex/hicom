import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hicom/controllers/api_controller.dart';
import 'package:hicom/resource/colors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../controllers/get_controller.dart';

class VerifyPage extends StatelessWidget {

  VerifyPage({super.key});

  final GetController _getController = Get.put(GetController());


  final mackFormater = MaskTextInputFormatter(
      mask: '00000',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );

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
            child: Text('Kodni kiriting:'.tr, style: TextStyle(fontSize: Get.width * 0.07, fontWeight: FontWeight.w500))
          ),
          Container(
              width: Get.width,
              margin: EdgeInsets.only(top: Get.height * 0.01, left: Get.width * 0.03, right: Get.width * 0.03,bottom: Get.height * 0.03),
              child: Text('Telefoningizga faollashtirish kodi SMS tarzida yuborildi.'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7), fontSize: Get.width * 0.045, fontWeight: FontWeight.w500))
          ),
          Container(
              width: Get.width,
              height: Get.height * 0.06,
              margin: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
              child: Obx(() => TextField(
                controller: _getController.codeController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                obscureText: true,
                focusNode: FocusNode(),
                style: TextStyle(
                  fontSize: _getController.width.value * 0.04,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                maxLength: 5,
                buildCounter: (BuildContext context, {required int currentLength, required int? maxLength, required bool isFocused}) => null,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  hintText: '00000'.tr,
                  filled: true,
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none, // No border
                    borderRadius: BorderRadius.circular(12),
                  ),
                  errorBorder: InputBorder.none,
                  fillColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                  hintStyle: TextStyle(
                    fontSize: _getController.width.value * 0.04,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                  ),
                )
            ))
          ),
          const Spacer(),
          Container(
              width: Get.width,
              margin: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),),
                  onPressed: () => {
                    ApiController().checkCode(),
                    //Get.to(() => SamplePage())
                  },
                  child: Text('Tasdiqlash'.tr, style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: Get.width * 0.045, fontWeight: FontWeight.w500))
              )
          ),
          SizedBox(height: Get.height * 0.05)
        ]
      )
    );
  }
}