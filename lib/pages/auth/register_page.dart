import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hicom/controllers/api_controller.dart';

import '../../companents/dropdown_item.dart';
import '../../companents/instrument/instrument_components.dart';
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
        title: Text('Ma’lumotlarni kiriting'.tr),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back, size: Get.width * 0.06), onPressed: () => Get.back())
      ),
      body: Obx(() => SingleChildScrollView(
          child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height * 0.05),
                  TextFields(title: 'Ism-familiyangizni kiriting'.tr,hintText: 'Kiriting'.tr, controller: _getController.nameController),
                  SizedBox(height: Get.height * 0.02),
                  Padding(padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03), child:Text('${'Mamlakat'.tr}:', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04)),),
                  Container(
                    margin: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03, bottom: Get.height * 0.02, top: Get.height * 0.01),
                    child: DropdownItem(
                        title: _getController.dropDownItemsTitle.first,
                        onTap: () => {
                          _getController.clearDistrictsModel(),
                          _getController.clearProvinceModel(),
                          showCountryPicker(
                              context: context,
                              showPhoneCode: true,
                              useSafeArea: true,
                              showWorldWide: false,
                              useRootNavigator: true,
                              favorite: ['UZ','RU','KZ','TJ','KG','AF'],
                              countryListTheme: CountryListThemeData(
                                  bottomSheetHeight: Get.height * 0.7,
                                  borderRadius: BorderRadius.circular(10),
                                  bottomSheetWidth: Get.width,
                                  flagSize: Get.width * 0.06,
                                  inputDecoration: InputDecoration(
                                      fillColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                                      filled: true,
                                      disabledBorder: UnderlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                      focusColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                                      hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5), fontSize: Get.width * 0.04),
                                      contentPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                                      border: InputBorder.none,
                                      labelText: 'Mamlakatlarni qidirish'.tr,
                                      labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04),
                                      enabledBorder: UnderlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                      focusedBorder: UnderlineInputBorder(borderRadius: BorderRadius.circular(10))
                                  )
                              ),
                              onSelect: (Country country) {
                                _getController.changeDropDownItemsTitle(0,country.name.toString());
                              }
                          ),
                        if (_getController.dropDownItemsTitle[0] != 'Uzbekistan'.tr){
                          ApiController().getRegions(Tea.encryptTea('{"country_id": 1}', '50UvFayZ2w5u3O9B'),'regions')
                        } else {
                          _getController.clearDistrictsModel(),
                          _getController.clearProvinceModel(),
                          _getController.dropDownItems[0] = 0,
                          _getController.dropDownItems[1] = 0,
                          _getController.dropDownItems[2] = 0,
                        }
                        }),
                  ),
                  if (_getController.provinceModel.value.regions != null && _getController.provinceModel.value.regions!.isNotEmpty)
                    Padding(padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03), child:Text('${'Viloyat'.tr}:', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04))),
                  if (_getController.provinceModel.value.regions != null && _getController.provinceModel.value.regions!.isNotEmpty)
                    SizedBox(height: Get.height * 0.01),
                  if (_getController.provinceModel.value.regions != null && _getController.provinceModel.value.regions!.isNotEmpty)
                    Container(
                      margin: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03,bottom: Get.height * 0.02),
                      child: DropdownItem(
                          title: _getController.provinceModel.value.regions![_getController.dropDownItems[0]].name.toString(),
                          onTap: () => {
                            InstrumentComponents().bottomBuildLanguageDialog(context,'Violyat'.tr,0),
                            _getController.dropDownItems[1] = 0
                          })
                    ),
                  if (_getController.districtsModel.value.districts != null && _getController.provinceModel.value.regions!.isNotEmpty)
                    Padding(padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03), child:Text('${'Shaxar/Tuman'.tr}:', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04))),
                  if (_getController.districtsModel.value.districts != null && _getController.provinceModel.value.regions!.isNotEmpty)
                    SizedBox(height: Get.height * 0.01),
                  if (_getController.districtsModel.value.districts != null && _getController.provinceModel.value.regions!.isNotEmpty)
                    Container(
                      margin: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03,bottom: Get.height * 0.02),
                      child: DropdownItem(
                          title: _getController.districtsModel.value.districts![_getController.dropDownItems[1]].name.toString(),
                          onTap: () => {
                            InstrumentComponents().bottomBuildLanguageDialog(context,'Shaxar/Tuman'.tr,1),
                          })
                    ),
                  Padding(padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03), child:Text('${'Foydalanuvchi turi'.tr}:', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04))),
                  Container(
                    margin: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03,bottom: Get.height * 0.02,top: Get.height * 0.02),
                    child: DropdownItem(
                        title: _getController.dropDownItem[_getController.dropDownItems[2]].toString(),
                        onTap: () => {
                          InstrumentComponents().bottomBuildLanguageDialog(context,'Foydalanuvchi turi'.tr,2)
                        }),
                  ),
                  SizedBox(height: Get.height * 0.05),
                  Padding(padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
                      child: ElevatedButton(
                          onPressed: () => {
                            if (_getController.nameController.text.isEmpty) {
                              InstrumentComponents().showToast(context,'Xatolik'.tr, 'Ism-familiyangizni kiriting'.tr, true, 3)
                            } else if (_getController.dropDownItems[0] == 0 && _getController.dropDownItemsTitle[0] == 'Uzbekistan') {
                              InstrumentComponents().showToast(context,'Xatolik'.tr,'Viloyatni tanlang'.tr, true, 3)
                            } else if (_getController.dropDownItems[1] == 0 && _getController.dropDownItemsTitle[0] == 'Uzbekistan') {
                              InstrumentComponents().showToast(context,'Xatolik'.tr,'Shaxarni tanlang yoki Tumanni tanlang'.tr, true, 3)
                            } else{
                              ApiController().signUp()
                            }
                          },
                          style: ButtonStyle(shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))), backgroundColor: WidgetStateProperty.all(AppColors.primaryColor)),
                          child: SizedBox(
                              width: Get.width,
                              height: Get.height * 0.06,
                              child: Center(child: Text('Saqlash'.tr, style: TextStyle(color: AppColors.white, fontSize: Get.width * 0.04))))
                      )
                  ),
                  SizedBox(height: Get.height * 0.01),
                ]
          )))
    );
  }
}