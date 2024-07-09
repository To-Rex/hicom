import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:hicom/controllers/api_controller.dart';
import 'package:hicom/resource/colors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../controllers/get_controller.dart';

class VerifyPageNumber extends StatelessWidget {

  VerifyPageNumber({super.key});

  final GetController _getController = Get.put(GetController());


  final List locale =[
    {'name':'English','locale':const Locale('en','US')},
    {'name':'Russian','locale':const Locale('ru','RU')},
    {'name':'Uzbek','locale':const Locale('uz','UZ')},
    {'name':'Ўзбекча','locale':const Locale('oz','OZ')},
  ];

  updateLanguage(Locale locale){
    Get.updateLocale(locale);
    _getController.saveLanguage(locale);
  }

  bottomBuildLanguageDialog(BuildContext context){
    Get.bottomSheet(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
        enableDrag: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SizedBox(
                  height: Get.height * 0.5,
                  width: double.infinity,
                  child: Column(
                      children: [
                        Container(
                            height: Get.height * 0.005,
                            width: Get.width * 0.2,
                            margin: EdgeInsets.only(top: Get.height * 0.02, bottom: Get.height * 0.03),
                            decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSurface, borderRadius: BorderRadius.circular(10.0))
                        ),
                        Text('Tilni tanlang'.tr,
                          style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.045),
                        ),
                        Expanded(
                            child: ListView.builder(
                                itemCount: locale.length,
                                itemBuilder: (context, index){
                                  return Container(
                                      height: Get.height * 0.07,
                                      width: double.infinity,
                                      padding: EdgeInsets.only(left: Get.width * 0.035, right: Get.width * 0.035),
                                      child: Column(
                                        children: [
                                          InkWell(
                                              overlayColor: WidgetStateProperty.all(Colors.transparent),
                                              child: SizedBox(
                                                  height: Get.height * 0.05,
                                                  child: Center(
                                                      child: Row(
                                                          children: [
                                                            Text(locale[index]['name'], style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04)),
                                                            const Spacer(),
                                                            if (locale[index]['locale'].toString() == _getController.language.toString())
                                                              Icon(TablerIcons.circle_check, color: Theme.of(context).colorScheme.onSurface),
                                                            if (locale[index]['locale'].toString() != _getController.language.toString())
                                                              Icon(TablerIcons.circle, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5))
                                                          ]
                                                      )
                                                  )
                                              ),
                                              onTap: (){
                                                updateLanguage(locale[index]['locale']);
                                                Get.back();
                                              }
                                          ),
                                          const Divider()
                                        ],
                                      )
                                  );
                                }
                            )
                        )
                      ]
                  )
              );
            })
    );
  }

  @override
  Widget build(BuildContext context) {
    _getController.codeController.clear();
    _getController.startTimer();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, size: Get.width * 0.07),
            onPressed: () => Get.back()),
          actions: [
            IconButton(icon: Icon(Icons.language, size: Get.width * 0.06), onPressed: () {
              bottomBuildLanguageDialog(context);
            })
          ]
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
                        if (value.length == 1 && _getController.verifyCodeControllers[0].text.length == 1 && _getController.verifyCodeControllers[1].text.length == 1 && _getController.verifyCodeControllers[2].text.length == 1 && _getController.verifyCodeControllers[3].text.length == 1) {
                          FocusScope.of(context).nextFocus();
                          ApiController().checkCode();
                        } else if (value.isEmpty) {
                          FocusScope.of(context).previousFocus();
                        }
                      },
                    )
                  ),
                ]
            )
          ),
          Padding(padding: EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.03),
              child: Obx(() =>_getController.countdownDuration.value.inSeconds == 0
                  ? TextButton(onPressed: () {
                ApiController().sendCode();
                _getController.resetTimer();
              }, child: Text('Kodni qayta yuborish'.tr, style: Theme.of(context).textTheme.bodyMedium))
                  : Text('${'Sizga SMS Xabarnoma yubordik'.tr}: ${_getController.countdownDuration.value.inMinutes.toString().padLeft(2, '0')}:${(_getController.countdownDuration.value.inSeconds % 60).toString().padLeft(2, '0')}', style: Theme.of(context).textTheme.bodyMedium)
              )
          )
        ]
      )
    );
  }
}