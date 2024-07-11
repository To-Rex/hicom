import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:hicom/controllers/api_controller.dart';
import 'package:hicom/resource/colors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../controllers/get_controller.dart';

class VerifyPage extends StatelessWidget {

  VerifyPage({super.key});

  final GetController _getController = Get.put(GetController());

  final List locale =[
    {'name':'English','locale':const Locale('en','US')},
    {'name':'Русский','locale':const Locale('ru','RU')},
    {'name':'O‘zbekcha','locale':const Locale('uz','UZ')},
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


  final mackFormater = MaskTextInputFormatter(
      mask: '00000',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );

  @override
  Widget build(BuildContext context) {
    _getController.codeController.clear();
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
              child: TextField(
                  controller: _getController.codeController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  obscureText: false,
                  focusNode: FocusNode(),
                  style: TextStyle(fontSize: Get.width * 0.04, color: Theme.of(context).colorScheme.onSurface),
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
                          fontSize: Get.width * 0.04,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)
                      )
                  )
              )
          ),
          const Expanded(child: SizedBox()),
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
                  child: Text('Tasdiqlash'.tr, style: TextStyle(color: Colors.white, fontSize: Get.width * 0.045, fontWeight: FontWeight.w500))
              )
          ),
          SizedBox(height: Get.height * 0.05)
        ]
      )
    );
  }
}