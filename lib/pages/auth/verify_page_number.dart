import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hicom/controllers/api_controller.dart';
import '../../companents/instrument/instrument_components.dart';
import '../../controllers/get_controller.dart';

class VerifyPageNumber extends StatelessWidget {
  final String phoneNumber;
  VerifyPageNumber({super.key, required this.phoneNumber});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    _getController.startTimer();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,surfaceTintColor: Colors.transparent,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, size: Get.width * 0.07),
              onPressed: () => Get.back()),
          actions: [
            IconButton(icon: Icon(Icons.language, size: Get.width * 0.06), onPressed: () {
              InstrumentComponents().languageDialog(context);
            })
          ]
      ),
      body: Column(
        children: [
          SizedBox(height: Get.height * 0.03),
          Container(
            width: Get.width,
            margin: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.13),
            child: Text('${'Kodni kiriting'.tr}:', style: TextStyle(fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize, fontWeight: FontWeight.w500))
          ),
          Container(
              width: Get.width,
              margin: EdgeInsets.only(top: Get.height * 0.01, left: Get.width * 0.03, right: Get.width * 0.03,bottom: Get.height * 0.03),
              //child: Text('${'Telefoningizga faollashtirish kodi SMS tarzida yuborildi.'.tr} $phoneNumber', style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7), fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize, fontWeight: FontWeight.w500))
              child: Text('${'Faollashtirish kodi'.tr} $phoneNumber ${'raqamiga SMS tarzida yuborildi.'.tr}', style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7), fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize, fontWeight: FontWeight.w500))
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
                      textInputAction: TextInputAction.next,
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
                        } else if (value.isEmpty) {
                          FocusScope.of(context).previousFocus();
                        } else {
                          FocusScope.of(context).previousFocus();
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
                      textInputAction: TextInputAction.next,
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
                        } else if (value.isEmpty) {
                          FocusScope.of(context).previousFocus();
                        } else {
                          FocusScope.of(context).previousFocus();
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
                      textInputAction: TextInputAction.next,
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
                        } else if (value.isEmpty) {
                          FocusScope.of(context).previousFocus();
                        } else {
                          FocusScope.of(context).previousFocus();
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
                      textInputAction: TextInputAction.next,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                      decoration: const InputDecoration(border: InputBorder.none),
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        } else if (value.isEmpty) {
                          FocusScope.of(context).previousFocus();
                        } else {
                          FocusScope.of(context).previousFocus();
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
                      textInputAction: TextInputAction.done,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                      decoration: const InputDecoration(border: InputBorder.none),
                      onChanged: (value) {
                        if (value.length == 1 && _getController.verifyCodeControllers[0].text.length == 1 && _getController.verifyCodeControllers[1].text.length == 1 && _getController.verifyCodeControllers[2].text.length == 1 && _getController.verifyCodeControllers[3].text.length == 1) {
                          FocusScope.of(context).nextFocus();
                          ApiController().checkCode();
                        } else if (value.isEmpty) {
                          FocusScope.of(context).previousFocus();
                        }
                      }
                    )
                  )
                ]
            )
          ),
          Padding(padding: EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.03),
              child: Obx(() =>_getController.countdownDuration.value.inSeconds == 0
                  ? TextButton(
                  style: ButtonStyle(overlayColor: WidgetStateProperty.all<Color>(Theme.of(context).colorScheme.onSurface.withOpacity(0.1))),
                  onPressed: () {ApiController().sendCode();_getController.resetTimer();},
                  child: Text('Kodni qayta yuborish'.tr, style: Theme.of(context).textTheme.bodyMedium))
              :TextButton(
                  style: ButtonStyle(overlayColor: WidgetStateProperty.all<Color>(Theme.of(context).colorScheme.onSurface.withOpacity(0.1))),
                  onPressed: () {},
                  child: Text('${'Kodni qayta yuborish'.tr}: ${_getController.countdownDuration.value.inMinutes.toString().padLeft(2, '0')}:${(_getController.countdownDuration.value.inSeconds % 60).toString().padLeft(2, '0')}', style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6), fontSize: Get.width * 0.035)))
              )
          )
        ]
      )
    );
  }
}