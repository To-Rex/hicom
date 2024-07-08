import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hicom/companents/instrument/instrument_components.dart';
import 'package:hicom/controllers/tea.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../companents/dropdown_item.dart';
import '../companents/text_fild.dart';
import '../controllers/api_controller.dart';
import '../controllers/get_controller.dart';
import '../resource/colors.dart';

class EditUser extends StatelessWidget {

  EditUser({super.key});

  final GetController _getController = Get.put(GetController());
  final RefreshController _refreshController = RefreshController(initialRefresh: false);


  void _onLoading() => _refreshController.loadComplete();
  void _getData() => _refreshController.refreshCompleted();

  @override
  Widget build(BuildContext context) {
    _getController.dropDownItemsTitle[0] = 'Uzbekistan'.tr;
    ApiController().getRegions('I0N7xNMEgeesBx/mXPInIb0=','regions').then((value) => _getController.getProvince()).then((value) =>ApiController().getRegions(Tea.encryptTea('{"country_id": 1,"region_id": ${_getController.provinceModel.value.regions![_getController.dropDownItems[0]].id.toString()}}',ApiController.key), 'districts').then((value) => _getController.getDistricts()));

    //ApiController().getRegions('I0N7xNMEgeesBx/mXPInISow/TDVbdLGAOLl9weENjw=','districts');
    return Scaffold(
      appBar: AppBar(
          title: Text('Hisobni taxrirlash'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.05, fontWeight: FontWeight.w500)),
          centerTitle: true,
          leading: IconButton(icon: Icon(Icons.arrow_back, size: Get.width * 0.07), onPressed: () => Get.back())
      ),
      body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          physics: const BouncingScrollPhysics(),
          header: CustomHeader(builder: (BuildContext context, RefreshStatus? mode) {return SizedBox(height: Get.height * 0.1);}),
          footer: CustomFooter(builder: (BuildContext context, LoadStatus? mode) {return SizedBox(height: Get.height * 0.1);}),
          onLoading: _onLoading,
          onRefresh: _getData,
          controller: _refreshController,
          child: Obx(() => SingleChildScrollView(
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
                            if (_getController.dropDownItemsTitle[0] == 'Uzbekistan'.tr){
                              ApiController().getRegions(Tea.encryptTea('{"country_id": 1}', '50UvFayZ2w5u3O9B'),'regions')
                            } else {
                              }
                          }),
                    ),
                    if (_getController.dropDownItemsTitle[0] == 'Uzbekistan'.tr && _getController.provinceModel.value.regions != null && _getController.provinceModel.value.regions!.isNotEmpty)
                      Padding(padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03), child:Text('${'Viloyat'.tr}:', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04))),
                    if (_getController.dropDownItemsTitle[0] == 'Uzbekistan'.tr && _getController.provinceModel.value.regions != null && _getController.provinceModel.value.regions!.isNotEmpty)
                      Container(
                          margin: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03,bottom: Get.height * 0.02,top: Get.height * 0.01),
                          child: DropdownItem(
                              title: _getController.provinceModel.value.regions![_getController.dropDownItems[0]].name.toString(),
                              onTap: () => {
                                InstrumentComponents().bottomBuildLanguageDialog(context,'Violyat'.tr,0),
                                _getController.dropDownItems[1] = 0
                              })
                      ),
                    if (_getController.dropDownItemsTitle[0] == 'Uzbekistan'.tr && _getController.districtsModel.value.districts != null && _getController.provinceModel.value.regions!.isNotEmpty)
                      Padding(padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03), child:Text('${'Shaxar/Tuman'.tr}:', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04))),
                    if (_getController.dropDownItemsTitle[0] == 'Uzbekistan'.tr && _getController.districtsModel.value.districts != null && _getController.provinceModel.value.regions!.isNotEmpty)
                      Container(
                          margin: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03,bottom: Get.height * 0.02,top: Get.height * 0.01),
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
                                ApiController().editUser()
                              }
                            },
                            style: ButtonStyle(shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))), backgroundColor: WidgetStateProperty.all(AppColors.primaryColor)),
                            child: SizedBox(
                                width: Get.width,
                                height: Get.height * 0.06,
                                child: Center(child: Text('Saqlash'.tr, style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: Get.width * 0.04))))
                        )
                    ),
                    SizedBox(height: Get.height * 0.01),
                  ]
              )))
      )
    );
  }
}