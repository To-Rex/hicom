import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: Text('Loyiha qo\'shish'.tr),
        centerTitle: true,
      ),
      body:  SingleChildScrollView(
        child: Column(
            children: [
              SizedBox(height: _getController.height.value * 0.05),
              TextFields(title: 'Loyiha nomi'.tr,hintText: 'Kiriting'.tr, controller: _getController.nameProjectController),
              SizedBox(height: _getController.height.value * 0.02),
              TextFields(title: 'Qurilma nomi'.tr,hintText: 'Kiriting'.tr, controller: _getController.switchNameProjectController),
              SizedBox(height: _getController.height.value * 0.02),
              TextFields(title: 'Qurilmaning ishlab chiqarish raqami'.tr,hintText: 'Kiriting'.tr, controller: _getController.switchSerialProjectController,isQrCode: true),
              SizedBox(height: _getController.height.value * 0.02),
              TextFields(title: 'Qurilma paroli'.tr,hintText: 'Kiriting'.tr, controller: _getController.passwordProjectController),
              SizedBox(height: _getController.height.value * 0.2),
              Padding(padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                  child: ElevatedButton(
                      onPressed: () => {
                        if(_getController.nameProjectController.text.isEmpty){
                          InstrumentComponents().showToast(Get.context!, 'Diqqat!', 'Loyiha nomini kiriting'.tr, true, 3)
                        } else if (_getController.switchNameProjectController.text.isEmpty){
                          InstrumentComponents().showToast(Get.context!, 'Diqqat!', 'Qurilma nomini kiriting'.tr, true, 3)
                        } else if (_getController.switchSerialProjectController.text.isEmpty){
                          InstrumentComponents().showToast(Get.context!, 'Diqqat!', 'Qurilmaning ishlab chiqarish raqamini kiriting'.tr, true, 3)
                        } else if (_getController.passwordProjectController.text.isEmpty){
                          InstrumentComponents().showToast(Get.context!, 'Diqqat!', 'Qurilma parolini kiriting'.tr, true, 3)
                        } else {
                          ApiController().addProjects()
                        }
                      },
                      style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))), backgroundColor: MaterialStateProperty.all(AppColors.primaryColor3)),
                      child: SizedBox(
                          width: _getController.width.value,
                          height: _getController.height.value * 0.06,
                          child: Center(child: Text('Saqlash'.tr, style: TextStyle(color: Theme.of(context).colorScheme.background, fontSize: _getController.width.value * 0.04))))
                  )
              ),
              SizedBox(height: _getController.height.value * 0.03),
            ]
        )
      )
    );
  }
}