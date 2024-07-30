import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
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

  @override
  Widget build(BuildContext context) {
    ApiController().getRegions(Tea.encryptTea('{"country_id": 1}', '50UvFayZ2w5u3O9B'),'regions');
     return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,surfaceTintColor: Colors.transparent,
          title: Text('Ma’lumotlarni kiriting'.tr,style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Theme.of(context).textTheme.titleLarge!.fontSize, fontWeight: FontWeight.w400)),
          centerTitle: true,
          leading: IconButton(icon: Icon(Icons.arrow_back, size: Get.width * 0.06), onPressed: () => Get.back()),
          actions: [
            IconButton(icon: Icon(Icons.language, size: Get.width * 0.06), onPressed: () {
              bottomBuildLanguageDialog(context);
            })
          ]
      ),
      body: Obx(() => SingleChildScrollView(
          child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height * 0.05),
                  TextFields(title: '${'Ism-familiyangizni kiriting'.tr}:',hintText: 'Kiriting'.tr, controller: _getController.nameController, maxLengthCharacters: 40),
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
                                      fillColor: AppColors.grey.withOpacity(0.1),
                                      filled: true,
                                      disabledBorder: UnderlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                      focusColor: AppColors.grey.withOpacity(0.1),
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
                                if (_getController.dropDownItemsTitle[0] == 'Uzbekistan' || _getController.dropDownItemsTitle[0] == 'Uzbekistan') {
                                  ApiController().getRegions(Tea.encryptTea('{"country_id": 1}', '50UvFayZ2w5u3O9B'),'regions');
                                }
                                _getController.changeDropDownItemsTitle(0,country.name.toString());
                              }
                          )
                        })
                  ),
                  if (_getController.dropDownItemsTitle[0] == 'Uzbekistan' && _getController.provinceModel.value.regions != null && _getController.provinceModel.value.regions!.isNotEmpty)
                    Padding(padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03), child:Text('${'Viloyat'.tr}:', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04))),
                  if (_getController.dropDownItemsTitle[0] == 'Uzbekistan' && _getController.provinceModel.value.regions != null && _getController.provinceModel.value.regions!.isNotEmpty)
                    SizedBox(height: Get.height * 0.01),
                  if (_getController.dropDownItemsTitle[0] == 'Uzbekistan' && _getController.provinceModel.value.regions != null && _getController.provinceModel.value.regions!.isNotEmpty)
                    Container(
                      margin: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03,bottom: Get.height * 0.02),
                      child: DropdownItem(
                          title: _getController.provinceModel.value.regions![_getController.dropDownItems[0]].name.toString(),
                          onTap: () => {
                            InstrumentComponents().bottomBuildLanguageDialog(context,'Viloyat'.tr,0),
                            _getController.dropDownItems[1] = 0
                          })
                    ),
                  if (_getController.dropDownItemsTitle[0] == 'Uzbekistan' && _getController.districtsModel.value.districts != null && _getController.provinceModel.value.regions!.isNotEmpty)
                    Padding(padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03), child:Text('${'Shaxar/Tuman'.tr}:', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04))),
                  if (_getController.dropDownItemsTitle[0] == 'Uzbekistan' && _getController.districtsModel.value.districts != null && _getController.provinceModel.value.regions!.isNotEmpty)
                    SizedBox(height: Get.height * 0.01),
                  if (_getController.dropDownItemsTitle[0] == 'Uzbekistan' && _getController.districtsModel.value.districts != null && _getController.provinceModel.value.regions!.isNotEmpty)
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
                        })
                  ),
                  SizedBox(height: Get.height * 0.05),
                  Container(
                      padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
                      height: 50.h,
                      child: ElevatedButton(
                          onPressed: () => {
                            if (_getController.nameController.text.isEmpty) {
                              InstrumentComponents().showToast(context,'Xatolik'.tr, 'Ism-familiyangizni kiriting'.tr, true, 3)
                            } else if (_getController.dropDownItems[0] == 0 && _getController.dropDownItemsTitle[0] == 'Uzbekistan') {
                              InstrumentComponents().showToast(context,'Xatolik'.tr,'Viloyatni tanlang'.tr, true, 3)
                            } else if (_getController.dropDownItems[1] == 0 && _getController.dropDownItemsTitle[0] == 'Uzbekistan') {
                              InstrumentComponents().showToast(context,'Xatolik'.tr,'Shaxarni yoki Tumanni tanlang'.tr, true, 3)
                            } else{
                              ApiController().signUp()
                            }
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: AppColors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                          child: SizedBox(
                              width: Get.width,
                              height: Get.height * 0.06,
                              child: Center(child: Text('Saqlash'.tr, style: TextStyle(color: AppColors.white, fontSize: Get.width * 0.04))))
                      )
                  ),
                  SizedBox(height: Get.height * 0.01)
                ]
          )))
    );
  }
}