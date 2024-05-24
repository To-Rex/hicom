import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hicom/controllers/api_controller.dart';

import '../../companents/text_fild.dart';
import '../../controllers/get_controller.dart';
import '../../controllers/tea.dart';

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
                  SizedBox(height: _getController.height.value * 0.01),
                  Text('${'Viloyat'.tr}:', style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.04)),
                  SizedBox(height: _getController.height.value * 0.01),
                  Container(
                    margin: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: DropdownButtonFormField(
                          borderRadius: BorderRadius.circular(10),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: _getController.height.value * 0.02, horizontal: _getController.width.value * 0.02),
                              fillColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
                              filled: true,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none
                          ),
                          value: _getController.selectedCountry.value,
                          items: _getController.countryList.map((country) => DropdownMenuItem(
                              enabled: _getController.countryList[0] == country ? false : true,
                              value: country,
                              child: Text(_getController.countryList[0] == country ? 'Viloyat tanlang'.tr : country, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.04))
                          )).toList(),
                          onChanged: (value) => {
                            _getController.selectedCountry.value = value.toString(),
                            ApiController().getRegions(Tea.encryptTea('{"country_id": 1,"region_id": "${_getController.getDropDownItems(value.toString())}"}', '50UvFayZ2w5u3O9B'),'districts')
                          },
                        )
                    )
                  ),
                  SizedBox(height: _getController.height.value * 0.01),
                  Text('${'Tuman/shaxar'.tr}:', style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.04)),
                  SizedBox(height: _getController.height.value * 0.01),
                  Container(
                      margin: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: DropdownButtonFormField(
                            borderRadius: BorderRadius.circular(10),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: _getController.height.value * 0.02, horizontal: _getController.width.value * 0.02),
                                fillColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
                                filled: true,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none
                            ),
                            value: _getController.selectedDistrict.value,
                            items: _getController.districtsList.map((country) => DropdownMenuItem(
                                enabled: _getController.districtsList[0] == country ? false : true,
                                value: country,
                                child: Text(_getController.districtsList[0] == country ? 'Tuman/shaxar tanlang'.tr : country, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.04))
                            )).toList(),
                            onChanged: (value) => {
                              _getController.selectedDistrict.value = value.toString(),
                              ApiController().getRegions(Tea.encryptTea('{"country_id": 1,"region_id": "${_getController.getDropDownItems(value.toString())}"}', '50UvFayZ2w5u3O9B'),'districts')
                            },
                          )
                      )
                  )
                ]
          ))
      )
    );
  }
}