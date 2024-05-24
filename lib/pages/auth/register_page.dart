import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hicom/controllers/api_controller.dart';

import '../../companents/dropdown_item.dart';
import '../../companents/text_fild.dart';
import '../../controllers/get_controller.dart';
import '../../controllers/tea.dart';
import '../../resource/colors.dart';

class RegisterPage extends StatelessWidget{

  RegisterPage({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    ApiController().getRegions(Tea.encryptTea('{"country_id": 1}', '50UvFayZ2w5u3O9B'),'regions');
     return Scaffold(
      appBar: AppBar(
        title: Text('ma’lumotlarni kiriting'.tr),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back, size: Get.width * 0.06), onPressed: () => Get.back())
      ),
      body: Obx(() => SingleChildScrollView(
          child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height * 0.05),
                  TextFields(title: 'Ismingizni kiriting'.tr,hintText: 'salom', controller: _getController.nameController),
                  SizedBox(height: _getController.height.value * 0.02),
                  if (_getController.provinceModel.value.regions != null)
                    Padding(padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03), child:Text('${'Viloyat'.tr}:', style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.04))),
                  if (_getController.provinceModel.value.regions != null)
                    SizedBox(height: _getController.height.value * 0.01),
                  if (_getController.provinceModel.value.regions != null)
                    Container(
                      margin: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03,bottom: _getController.height.value * 0.02),
                      child: DropdownItem(
                          title: _getController.provinceModel.value.regions![_getController.dropDownItems[0]].name.toString(),
                          onTap: () => {
                            ApiController().bottomBuildLanguageDialog(context,'Violyat'.tr,0)
                          })
                    ),
                  if (_getController.districtsModel.value.districts != null)
                    Padding(padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03), child:Text('${'Shaxar/Tuman'.tr}:', style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.04))),
                  if (_getController.districtsModel.value.districts != null)
                    SizedBox(height: _getController.height.value * 0.01),
                  if (_getController.districtsModel.value.districts != null)
                    Container(
                      margin: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03,bottom: _getController.height.value * 0.02),
                      child: DropdownItem(
                          title: _getController.districtsModel.value.districts![_getController.dropDownItems[1]].name.toString(),
                          onTap: () => {
                            ApiController().bottomBuildLanguageDialog(context,'Shaxar/Tuman'.tr,1)
                          })
                    ),
                  Padding(padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03), child:Text('${'Foydalanuvchi turi'.tr}:', style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.04))),
                  Container(
                    margin: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03,bottom: _getController.height.value * 0.02,top: _getController.height.value * 0.02),
                    child: DropdownItem(
                        title: _getController.dropDownItem[_getController.dropDownItems[2]].toString(),
                        onTap: () => {
                          ApiController().bottomBuildLanguageDialog(context,'Foydalanuvchi turi'.tr,2)
                        }),
                  ),
                  SizedBox(height: _getController.height.value * 0.05),
                  Padding(padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03), child:ElevatedButton(
                      onPressed: () => {
                        Get.back()
                      },
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                          backgroundColor: MaterialStateProperty.all(AppColors.primaryColor)
                      ),
                      child: SizedBox(
                          width: _getController.width.value,
                          height: _getController.height.value * 0.06,
                          child: Center(child: Text('Saqlash'.tr, style: TextStyle(color: Theme.of(context).colorScheme.background, fontSize: _getController.width.value * 0.04))))
                  )),
                  SizedBox(height: _getController.height.value * 0.01),
                ]
          ))
      )
    );
  }
}