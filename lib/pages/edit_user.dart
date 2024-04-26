import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../companents/dropdown_item.dart';
import '../controllers/api_controller.dart';
import '../controllers/get_controller.dart';
import '../models/province_model.dart';
import '../resource/colors.dart';

class EditUser extends StatelessWidget {

  final GetController _getController = Get.put(GetController());
  void _onLoading() => _refreshController.loadComplete();
  void _getData() => _refreshController.refreshCompleted();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  var selectedValue = 'Uzbekistan';
  @override
  Widget build(BuildContext context) {
    ApiController().getData('I0N7xNMEgeesBx/mXPInIb0=','regions');
    ApiController().getData('I0N7xNMEgeesBx/mXPInIb0=','districts');
    return Scaffold(
      appBar: AppBar(
          title: Text('Hisobni taxrirlash'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: Get.width * 0.05, fontWeight: FontWeight.w500)),
          centerTitle: true,
          leading: IconButton(icon: Icon(Icons.arrow_back, size: Get.width * 0.07), onPressed: () => Get.back())
      ),
      body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          physics: const BouncingScrollPhysics(),
          header: CustomHeader(builder: (BuildContext context, RefreshStatus? mode) {return SizedBox(height: _getController.height.value * 0.1);}),
          footer: CustomFooter(builder: (BuildContext context, LoadStatus? mode) {return SizedBox(height: _getController.height.value * 0.1);}),
          onLoading: _onLoading,
          onRefresh: _getData,
          controller: _refreshController,
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(
                  left: _getController.width.value * 0.03,
                  right: _getController.width.value * 0.03,
                  top: _getController.height.value * 0.02
                ),
                child: Obx(() =>  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: _getController.height.value * 0.01),
                      Text('${'Ism va familiya'.tr}:', style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.04)),
                      SizedBox(height: _getController.height.value * 0.01),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: TextField(
                              controller: _getController.nameController,
                              decoration: InputDecoration(
                                  fillColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
                                  filled: true,
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                                  hintText: 'Kiriting'.tr,
                                  hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5), fontSize: _getController.width.value * 0.04)
                              ),
                              style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.04)
                          )
                      ),
                      SizedBox(height: _getController.height.value * 0.01),
                      Text('${'Mamlakat'.tr}:', style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.04)),
                      SizedBox(height: _getController.height.value * 0.01),
                      DropdownItem(
                          title: _getController.provinceModel.value.regions![_getController.dropDownItems[1]].name.toString(),
                          onTap: () => {
                            showCountryPicker(
                              context: context,
                              showPhoneCode: true,
                              useSafeArea: true,
                              onClosed: () => print('Dialog closed'),
                              showWorldWide: false,
                              useRootNavigator: true,
                              favorite: ['UZ','RU','KZ','TJ','KG','AF'],
                              countryListTheme: CountryListThemeData(
                                bottomSheetHeight: _getController.height.value * 0.7,
                                borderRadius: BorderRadius.circular(10),
                                bottomSheetWidth: _getController.width.value,
                                padding: EdgeInsets.only(top: _getController.height.value * 0.02),
                                backgroundColor: Theme.of(context).colorScheme.background,
                                flagSize: _getController.width.value * 0.06,
                                inputDecoration: InputDecoration(
                                  fillColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.03),
                                  border: InputBorder.none,
                                  labelText: 'Mamlakatlarni qidirish'.tr,
                                  labelStyle: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.04),
                                  enabledBorder: UnderlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: UnderlineInputBorder(borderRadius: BorderRadius.circular(10))
                                ),
                              ),
                              onSelect: (Country country) {print('Select country: ${country.displayName}');},
                            )
                            //ApiController().bottomBuildLanguageDialog(context,'Mamlakat'.tr,0)
                      }),
                      SizedBox(height: _getController.height.value * 0.01),
                      Text('${'Violyat'.tr}:', style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.04)),
                      SizedBox(height: _getController.height.value * 0.01),
                      if (_getController.provinceModel.value.regions != null)
                        DropdownItem(
                            title: _getController.provinceModel.value.regions![_getController.dropDownItems[1]].name.toString(),
                            onTap: () => {
                              print('Uzbekistan'),
                              ApiController().bottomBuildLanguageDialog(context,'Violyat'.tr,1)
                            }),
                      SizedBox(height: _getController.height.value * 0.01),
                      Text('${'Shaxar/Tuman'.tr}:', style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.04)),
                      SizedBox(height: _getController.height.value * 0.01),
                      if (_getController.districtsModel.value.districts != null)
                        DropdownItem(
                            title: _getController.provinceModel.value.regions![_getController.dropDownItems[1]].name.toString(),
                            onTap: () => {
                              ApiController().bottomBuildLanguageDialog(context,'Shaxar/Tuman'.tr,2)
                            }),
                      SizedBox(height: _getController.height.value * 0.01),
                      Text('${'Foydalanuvchi turi'.tr}:', style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.04)),
                      SizedBox(height: _getController.height.value * 0.01),
                      if (_getController.districtsModel.value.districts != null)
                        DropdownItem(
                            title: _getController.provinceModel.value.regions![_getController.dropDownItems[1]].name.toString(),
                            onTap: () => {
                              ApiController().bottomBuildLanguageDialog(context,'Foydalanuvchi turi'.tr,3)
                            }),
                      SizedBox(height: _getController.height.value * 0.05),
                      ElevatedButton(
                          onPressed: () => {},
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                              backgroundColor: MaterialStateProperty.all(AppColors.primaryColor)
                          ),
                          child: SizedBox(
                              width: _getController.width.value,
                              height: _getController.height.value * 0.06,
                              child: Center(child: Text('Saqlash'.tr, style: TextStyle(color: Theme.of(context).colorScheme.background, fontSize: _getController.width.value * 0.04))))
                      ),
                      SizedBox(height: _getController.height.value * 0.01),
                    ]
                )
                )
              )
          )
      )
    );
  }
}