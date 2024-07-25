import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicom/companents/instrument/instrument_components.dart';
import 'package:hicom/controllers/api_controller.dart';
import '../../companents/text_fild.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';

class AddProjectPage extends StatelessWidget {
  AddProjectPage({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,surfaceTintColor: Colors.transparent,title: Text('Loyiha qo‘shish'.tr), centerTitle: true),
      body:  SingleChildScrollView(
        child: Column(
            children: [
              SizedBox(height: Get.height * 0.05),
              TextFields(title: '${'Loyiha nomi'.tr}:',hintText: 'Kiriting'.tr, controller: _getController.nameProjectController, maxLengthCharacters: 40),
              SizedBox(height: Get.height * 0.02),
              TextFields(title: '${'Qurilma nomi'.tr}:',hintText: 'Kiriting'.tr, controller: _getController.switchNameProjectController, maxLengthCharacters: 40),
              SizedBox(height: Get.height * 0.02),
              TextFields(title: '${'Qurilmaning ishlab chiqarish raqami'.tr}:',hintText: 'Kiriting'.tr, controller: _getController.switchSerialProjectController,isQrCode: true, maxLengthCharacters: 100),
              SizedBox(height: Get.height * 0.02),
              //yulduzchali parol qpyish kerak edi
              TextFields(title: '${'Qurilma paroli'.tr}:',hintText: 'Kiriting'.tr, controller: _getController.passwordProjectController,isPassword: true, maxLengthCharacters: 40),
              SizedBox(height: Get.height * 0.25),
              Container(
                height: 50.h,
                  padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
                  child: ElevatedButton(
                      onPressed: () => {
                        if(_getController.nameProjectController.text.isEmpty){
                          InstrumentComponents().showToast(Get.context!, 'Diqqat!', 'Loyiha nomini kiriting.'.tr, true, 3)
                        } else if (_getController.switchNameProjectController.text.isEmpty){
                          InstrumentComponents().showToast(Get.context!, 'Diqqat!', 'Qurilma nomini kiriting.'.tr, true, 3)
                        } else if (_getController.switchSerialProjectController.text.isEmpty){
                          InstrumentComponents().showToast(Get.context!, 'Diqqat!', 'Qurilmaning ishlab chiqarish raqamini kiriting.'.tr, true, 3)
                        } else if (_getController.passwordProjectController.text.isEmpty){
                          InstrumentComponents().showToast(Get.context!, 'Diqqat!', 'Qurilmaning parolini kiriting.'.tr, true, 3)
                        } else {
                          ApiController().addProjects()
                        }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      child: SizedBox(
                          width: Get.width,
                          height: Get.height * 0.06,
                          child: Center(child: Text('Saqlash'.tr, style: TextStyle(color: AppColors.white, fontSize: Get.width * 0.04)))
                      )
                  )
              ),
              SizedBox(height: Get.height * 0.03)
            ]
        )
      )
    );
  }
}