import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicom/controllers/api_controller.dart';
import 'package:hicom/resource/colors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../controllers/get_controller.dart';

class VerifyPageNumber extends StatelessWidget {

  VerifyPageNumber({super.key});

  final GetController _getController = Get.put(GetController());


  final mackFormater = MaskTextInputFormatter(
      mask: '00000',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );

  @override
  Widget build(BuildContext context) {
    _getController.codeController.clear();
    _getController.startTimer();
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
            child: Text('Kodni kiriting:'.tr, style: TextStyle(fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize, fontWeight: FontWeight.w500))
          ),
          Container(
              width: Get.width,
              margin: EdgeInsets.only(top: Get.height * 0.01, left: Get.width * 0.03, right: Get.width * 0.03,bottom: Get.height * 0.03),
              child: Text('Telefoningizga faollashtirish kodi SMS tarzida yuborildi.'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7), fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize, fontWeight: FontWeight.w500))
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.15, vertical: Get.height * 0.04),
            child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: Theme.of(context).textTheme.headlineLarge!.fontSize! * 1.4,
                      height: Theme.of(context).textTheme.headlineLarge!.fontSize! * 1.6,
                      decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: _getController.verifyCodeControllers[0],
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    )
                  ),
                  Container(
                      width: Theme.of(context).textTheme.headlineLarge!.fontSize! * 1.4,
                      height: Theme.of(context).textTheme.headlineLarge!.fontSize! * 1.6,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    child: TextField(
                      controller: _getController.verifyCodeControllers[1],
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      textAlign: TextAlign.center,
                      /*style: TextStyle(
                          fontSize: Get.width * 0.07,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black
                      ),*/
                      style: Theme.of(context).textTheme.headlineSmall,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    )
                  ),
                  Container(
                      width: Theme.of(context).textTheme.headlineLarge!.fontSize! * 1.4,
                      height: Theme.of(context).textTheme.headlineLarge!.fontSize! * 1.6,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    child: TextField(
                      controller: _getController.verifyCodeControllers[2],
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      textAlign: TextAlign.center,
                      /*style: TextStyle(
                          fontSize: Get.width * 0.07,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black
                      ),*/
                      style: Theme.of(context).textTheme.headlineSmall,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    )
                  ),
                  Container(
                      width: Theme.of(context).textTheme.headlineLarge!.fontSize! * 1.4,
                      height: Theme.of(context).textTheme.headlineLarge!.fontSize! * 1.6,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    child: TextField(
                      controller: _getController.verifyCodeControllers[3],
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      textAlign: TextAlign.center,
                      /*style: TextStyle(
                          fontSize: Get.width * 0.07,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black
                      ),*/
                      style: Theme.of(context).textTheme.headlineSmall,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    )
                  ),
                  Container(
                      width: Theme.of(context).textTheme.headlineLarge!.fontSize! * 1.4,
                      height: Theme.of(context).textTheme.headlineLarge!.fontSize! * 1.6,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    child: TextField(
                      controller: _getController.verifyCodeControllers[4],
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                        ApiController().checkCode();
                      },
                    )
                  ),
                ]
            )
          ),
          Obx(() =>_getController.countdownDuration.value.inSeconds == 0
              ? TextButton(onPressed: () {
                _getController.resetTimer();
          }, child: Text('Kodni qayta yuborish'.tr, style: Theme.of(context).textTheme.bodyMedium))
              : Text('Sizga SMS Xabarnoma yubordik: ${_getController.countdownDuration.value.inMinutes.toString().padLeft(2, '0')}:${(_getController.countdownDuration.value.inSeconds % 60).toString().padLeft(2, '0')}', style: Theme.of(context).textTheme.bodyMedium)
          ),
        ]
      )
    );
  }
}