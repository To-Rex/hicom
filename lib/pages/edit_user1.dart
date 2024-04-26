import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/api_controller.dart';
import '../controllers/get_controller.dart';
import '../models/province_model.dart';

class EditUser1 extends StatelessWidget {

  final GetController _getController = Get.put(GetController());
  void _onLoading() => _refreshController.loadComplete();
  void _getData() => _refreshController.refreshCompleted();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  List<String> state = [
    'Uzbekistan',
    'China',
    'Japan',
    'Korea',
    'India',
    'Turkmenistan',
  ];
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
                      ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child:  DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              fillColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
                              filled: true,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                            ),
                            style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.04),
                            value: selectedValue,
                            onChanged: (String? newValue) {
                              selectedValue = newValue!;
                            },
                            items: state.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          )
                      ),
                      SizedBox(height: _getController.height.value * 0.01),
                      Text('${'Violyat'.tr}:', style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.04)),
                      SizedBox(height: _getController.height.value * 0.01),
                      if (_getController.provinceModel.value.regions != null)
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child:  DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                fillColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
                                filled: true,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                              ),
                              style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.04),
                              value: _getController.provinceModel.value.regions![_getController.dropDownItems[1]].name,
                              onChanged: (String? newValue) {
                                _getController.changeDropDownItems(1, _getController.provinceModel.value.regions!.indexWhere((region) => region.name == newValue));
                                debugPrint(_getController.dropDownItems[1].toString());
                              },
                              items: _getController.provinceModel.value.regions!.map((e) => DropdownMenuItem(
                                  value: e.name,
                                  child: Text(e.name.toString(), style: TextStyle(fontSize: Get.width * 0.04)))
                              ).toList(),
                            )
                        ),
                      SizedBox(height: _getController.height.value * 0.01),
                      Text('${'Shaxar/Tuman'.tr}:', style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.04)),
                      SizedBox(height: _getController.height.value * 0.01),
                      if (_getController.districtsModel.value.districts != null)
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child:  DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                fillColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
                                filled: true,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                              ),
                              style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.04),
                              value: _getController.districtsModel.value.districts![_getController.dropDownItems[2]].name,
                              onChanged: (String? newValue) {
                                _getController.changeDropDownItems(2, _getController.districtsModel.value.districts!.indexWhere((region) => region.name == newValue));
                              },
                              items: _getController.districtsModel.value.districts!.map((e) => DropdownMenuItem(
                                  value: e.name,
                                  child: Text(e.name.toString(), style: TextStyle(fontSize: Get.width * 0.04)))
                              ).toList(),
                            )
                        )
                    ]
                )
                )
              )
          )
      )
    );
  }
}