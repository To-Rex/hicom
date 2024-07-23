import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';
import '../../controllers/tea.dart';
import '../../pages/auth/login_page.dart';
import '../../resource/colors.dart';
import '../text_fild.dart';

class InstrumentComponents {
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

  void showToast(context,String title,String message, error,sec) => Get.snackbar(
      title.tr,
      message.tr,
      backgroundColor: error ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.onSurface,
      colorText: error ? Theme.of(context).colorScheme.onError : Theme.of(context).colorScheme.surface,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.only(
          bottom: Get.height * 0.03,
          left: Get.width * 0.04,
          right: Get.width * 0.04
      ),
      borderRadius: 12,
      duration: Duration(seconds: sec),
      icon: error ? Icon(
        Icons.error,
        color: Theme.of(context).colorScheme.onError,
      ) : null,
    );

  void showDialogConnectivity(context) => showDialog(context: context, builder: (BuildContext context) => AlertDialog(
          title: Text('Diqqat!'.tr),
          content: Text('Internet bog‘lanmadi'.tr),
          actions: <Widget>[
            TextButton(
                child: Text('Iltimos, qayta urinib ko‘ring'.tr),
                onPressed: () {
                  Navigator.of(context).pop();
                }
            ),
          ],
        ));

  bottomBuildLanguageDialog(BuildContext context,title,cat) => Get.bottomSheet(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
        enableDrag: true,
        isScrollControlled: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SizedBox(
                  height: Get.height * 0.7,
                  width: double.infinity,
                  child: Column(
                      children: [
                        Container(height: Get.height * 0.005, width: Get.width * 0.2, margin: EdgeInsets.only(top: Get.height * 0.02, bottom: Get.height * 0.03), decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSurface, borderRadius: BorderRadius.circular(10.0))),
                        Text(title.toString().tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.045)),
                        SizedBox(height: Get.height * 0.02),
                        if (cat == 0)
                          Expanded(
                              child: ListView.builder(
                                  itemCount: _getController.provinceModel.value.regions!.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (index != 0) {
                                              Get.back();
                                              _getController.changeDropDownItems(0, index);
                                              ApiController().getRegions(Tea.encryptTea('{"country_id": 1,"region_id": ${_getController.provinceModel.value.regions![_getController.dropDownItems[0]].id.toString()}}',ApiController.key), 'districts');
                                            }
                                          });
                                        },
                                        child: Padding(
                                            padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
                                            child: Column(
                                                children: [
                                                  SizedBox(height: Get.height * 0.01),
                                                  Container(
                                                      height: Get.height * 0.04,
                                                      width: Get.width,
                                                      margin: EdgeInsets.only(bottom: Get.height * 0.01),
                                                      child: Center(
                                                          child: Row(
                                                              children: [
                                                                Text(_getController.provinceModel.value.regions![index].name.toString(), style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04),),
                                                                const Spacer(),
                                                                if (_getController.dropDownItems[0] == index)
                                                                  Icon(TablerIcons.circle_check, color: Theme.of(context).colorScheme.onSurface)
                                                                else
                                                                  Icon(TablerIcons.circle, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5))
                                                              ]
                                                          )
                                                      )
                                                  ),
                                                  if (_getController.provinceModel.value.regions!.length - 1 != index)
                                                    const Divider(),
                                                  if (_getController.provinceModel.value.regions!.length - 1 == index)
                                                    SizedBox(height: Get.height * 0.01),
                                                ]
                                            )
                                        )
                                    );
                                  }
                              )
                          )
                        else if (cat == 1)
                          Expanded(
                              child: Obx(() => ListView.builder(
                                  itemCount: _getController.districtsModel.value.districts!.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: () {
                                          if (index != 0) {
                                            Get.back();
                                            setState(() {
                                              _getController.changeDropDownItems(1, index);
                                            });
                                          }
                                        },
                                        child: Padding(padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
                                            child: Column(
                                                children: [
                                                  SizedBox(height: Get.height * 0.01),
                                                  Container(
                                                      height: Get.height * 0.04,
                                                      width: Get.width,
                                                      margin: EdgeInsets.only(bottom: Get.height * 0.01),
                                                      child: Center(
                                                          child: Row(
                                                              children: [
                                                                Text(_getController.districtsModel.value.districts![index].name.toString(),
                                                                    style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04)),
                                                                const Spacer(),
                                                                if (_getController.dropDownItems[1] == index)
                                                                  Icon(TablerIcons.circle_check, color: Theme.of(context).colorScheme.onSurface)
                                                                else
                                                                  Icon(TablerIcons.circle, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5))
                                                              ]
                                                          )
                                                      )
                                                  ),
                                                  //if (_getController.state.length - 1 != index)
                                                  const Divider()
                                                ]
                                            )
                                        )
                                    );
                                  }
                              ))
                          )
                        else
                          Expanded(
                              child: ListView.builder(
                                  itemCount: _getController.dropDownItem.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: () {
                                          setState(() {
                                            Get.back();
                                            _getController.changeDropDownItems(2, index);
                                          });
                                        },
                                        child: Padding(
                                            padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
                                            child: Column(
                                                children: [
                                                  SizedBox(height: Get.height * 0.01),
                                                  Container(
                                                      height: Get.height * 0.04,
                                                      width: Get.width,
                                                      margin: EdgeInsets.only(bottom: Get.height * 0.01),
                                                      child: Center(
                                                          child: Row(
                                                              children: [
                                                                Text(_getController.dropDownItem[index].tr,style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04),),
                                                                const Spacer(),
                                                                if (_getController.dropDownItems[2] == index)
                                                                  Icon(TablerIcons.circle_check, color: Theme.of(context).colorScheme.onSurface)
                                                                else
                                                                  Icon(TablerIcons.circle, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5))
                                                              ]
                                                          )
                                                      )
                                                  ),
                                                  if (_getController.dropDownItem.length - 1 != index)
                                                    const Divider()
                                                ]
                                            )
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

  bottomSheetEditName(BuildContext context, pidId) => Get.bottomSheet(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
        enableDrag: true,
        isScrollControlled: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                  height: Get.height * 0.45,
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0))),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppBar(
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
                          title: Text('Loyihani tahrirlash'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.045)),
                          centerTitle: false,
                          backgroundColor: Theme.of(context).colorScheme.surface,
                          elevation: 0,
                          leadingWidth: 0,
                          leading: Container(),
                          actions: [
                            IconButton(onPressed: () => Get.back(), icon: Icon(TablerIcons.x, color: Theme.of(context).colorScheme.onSurface, size: Get.width * 0.05))
                          ]
                        ),
                        SizedBox(height: Get.height * 0.02),
                        TextFields(title: '${'Loyiha nomi'.tr}:', hintText: 'Kiriting'.tr, controller: _getController.nameProjectController, maxLengthCharacters: 40),
                        SizedBox(height: Get.height * 0.02),
                        TextFields(title: '${'Qo‘shimcha ma’lumot'.tr}:',hintText: 'Kiriting'.tr, controller: _getController.noteProjectController, maxLengthCharacters: 128),
                        SizedBox(height: Get.height * 0.04),
                        Padding(padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
                            child: ElevatedButton(
                                onPressed: () => {
                                  if (_getController.nameProjectController.text == '') {
                                    showToast(context, 'Diqqat!'.tr, 'Loyiha nomini kiriting.'.tr, true, 3)
                                  } else {
                                    ApiController().renameProjects(pidId, _getController.nameProjectController.text, _getController.noteProjectController.text)
                                  }
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: AppColors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                child: SizedBox(
                                    width: Get.width,
                                    height: Get.height * 0.06,
                                    child: Center(child: Text('Saqlash'.tr, style: TextStyle(color: AppColors.white, fontSize: Get.width * 0.04))))
                            )
                        )
                      ]
                  )
              );
            })
    );

  bottomSwitchEditName(BuildContext context, pidId,sn,index,online) => Get.bottomSheet(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
        enableDrag: true,
        isScrollControlled: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                  height: Get.height * 0.45,
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0))),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppBar(
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
                          title: Text('Qurilmani tahrirlash'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.045)),
                          centerTitle: false,
                          backgroundColor: Theme.of(context).colorScheme.surface,
                          elevation: 0,
                          leadingWidth: 0,
                          leading: Container(),
                          actions: [
                            IconButton(onPressed: () => Get.back(), icon: Icon(TablerIcons.x, color: Theme.of(context).colorScheme.onSurface, size: Get.width * 0.05))
                          ]
                        ),
                        SizedBox(height: Get.height * 0.02),
                        TextFields(title: '${'Qurilma nomi'.tr}:', hintText: 'Kiriting'.tr, controller: _getController.nameProjectController, maxLengthCharacters: 40),
                        SizedBox(height: Get.height * 0.02),
                        TextFields(title: '${'Qo‘shimcha ma’lumot'.tr}:',hintText: 'Kiriting'.tr, controller: _getController.noteProjectController, maxLengthCharacters: 128),
                        SizedBox(height: Get.height * 0.04),
                        Padding(padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
                            child: ElevatedButton(
                                onPressed: () => {
                                  if (_getController.nameProjectController.text == '') {
                                    showToast(context, 'Diqqat!'.tr, 'Qurilma nomini kiriting.'.tr, true, 3)
                                  } else {
                                    ApiController().renameSwitch(pidId, sn)
                                  }
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: AppColors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                child: SizedBox(
                                    width: Get.width,
                                    height: Get.height * 0.06,
                                    child: Center(child: Text('Saqlash'.tr, style: TextStyle(color: AppColors.white, fontSize: Get.width * 0.04))))
                            )
                        )
                      ]
                  )
              );
            })
    );

  bottomSheetUsers(BuildContext context, pidId) => Get.bottomSheet(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
        enableDrag: true,
        isScrollControlled: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                  height: Get.height * 0.6,
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0))),
                  width: double.infinity,
                  child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppBar(
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
                            title: Text('Loyihani kuzatuvchilari'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.045)),
                            centerTitle: false,
                            backgroundColor: Theme.of(context).colorScheme.surface,
                            elevation: 0,
                            leadingWidth: 0,
                            leading: Container(),
                            actions: [
                              IconButton(onPressed: () => Get.back(), icon: Icon(TablerIcons.x, color: Theme.of(context).colorScheme.onSurface, size: Get.width * 0.05))
                            ]
                        ),
                        SizedBox(height: Get.height * 0.02),
                        //Null check operator used on a null value
                        if (_getController.getUsersModel.value.join != null)
                          ListView.builder(
                              itemCount: _getController.getUsersModel.value.join!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return ListTile(
                                    leading: Icon(Icons.person, color: Theme.of(context).colorScheme.onSurface, size: Get.width * 0.05),
                                    title: Text(_getController.getUsersModel.value.join![index].name.toString()),
                                    trailing: Icon(TablerIcons.circle, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5))
                                );
                              }
                          )
                      ]
                  ))
              );
            })
    );

  bottomSheetShare(BuildContext context, pidId) => Get.bottomSheet(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
        enableDrag: true,
        isScrollControlled: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                  height: Get.height * 0.45,
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0))),
                  width: double.infinity,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppBar(
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
                            title: Text('Loyihani ulashish'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.045)),
                            centerTitle: false,
                            backgroundColor: Theme.of(context).colorScheme.surface,
                            elevation: 0,
                            leadingWidth: 0,
                            leading: Container(),
                            actions: [
                              IconButton(onPressed: () => Get.back(), icon: Icon(TablerIcons.x, color: Theme.of(context).colorScheme.onSurface, size: Get.width * 0.05))
                            ]
                        ),
                        SizedBox(height: Get.height * 0.02),
                        TextFields(title: '${'Kuzatuvchi telefon raqami'.tr}:',hintText: 'Kiriting'.tr, controller: _getController.nameProjectController, maxLengthCharacters: 40),
                        SizedBox(height: Get.height * 0.02),
                        TextFields(title: '${'Kuzatuvchi nomi'.tr}:',hintText: 'Kiriting'.tr, controller: _getController.noteProjectController, maxLengthCharacters: 40),
                        SizedBox(height: Get.height * 0.04),
                        Padding(padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
                            child: ElevatedButton(
                                onPressed: () => {
                                  if (_getController.nameProjectController.text == '') {
                                    showToast(context, 'Diqqat!'.tr,'Kuzatuvchi telefon raqami kiriting'.tr, true, 3)
                                  } else if (_getController.noteProjectController.text == '') {
                                    showToast(context, 'Diqqat!'.tr, 'Kuzatuvchi nomi kiriting'.tr, true, 3)
                                  } else {
                                    ApiController().projectShare(pidId)
                                    //close bottom sheet
                                  }
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: AppColors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                child: SizedBox(
                                    width: Get.width,
                                    height: Get.height * 0.06,
                                    child: Center(child: Text('Saqlash'.tr, style: TextStyle(color: AppColors.white, fontSize: Get.width * 0.04))))
                            )
                        )
                      ]
                  )
              );
            })
    );

  bottomSheetProjectAdd(BuildContext context, pidId) => Get.bottomSheet(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
        enableDrag: true,
        isScrollControlled: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                  height: Get.height * 0.45,
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0))),
                  width: double.infinity,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppBar(
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
                            title: Text('Loyihani ulashish'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.045)),
                            centerTitle: false,
                            backgroundColor: Theme.of(context).colorScheme.surface,
                            elevation: 0,
                            leadingWidth: 0,
                            leading: Container(),
                            actions: [
                              IconButton(onPressed: () => Get.back(), icon: Icon(TablerIcons.x, color: Theme.of(context).colorScheme.onSurface, size: Get.width * 0.05))
                            ]
                        ),
                        SizedBox(height: Get.height * 0.02),
                        TextFields(title: '${'Kuzatuvchi telefon raqami'.tr}:',hintText: 'Kiriting'.tr, controller: _getController.nameProjectController, maxLengthCharacters: 40),
                        SizedBox(height: Get.height * 0.02),
                        TextFields(title: '${'Kuzatuvchi nomi'.tr}:',hintText: 'Kiriting'.tr, controller: _getController.noteProjectController, maxLengthCharacters: 40),
                        SizedBox(height: Get.height * 0.04),
                        Padding(padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
                            child: ElevatedButton(
                                onPressed: () => {
                                  if (_getController.nameProjectController.text == '') {
                                    showToast(context, 'Diqqat!'.tr,'Kuzatuvchi telefon raqami kiriting'.tr, true, 3)
                                  } else if (_getController.noteProjectController.text == '') {
                                    showToast(context, 'Diqqat!'.tr, 'Kuzatuvchi nomi kiriting'.tr, true, 3)
                                  } else {
                                    ApiController().projectShare(pidId)
                                  }
                                },
                                //RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                                style: ElevatedButton.styleFrom(backgroundColor: AppColors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                child: SizedBox(
                                    width: Get.width,
                                    height: Get.height * 0.06,
                                    child: Center(child: Text('Saqlash'.tr, style: TextStyle(color: AppColors.white, fontSize: Get.width * 0.04))))
                            )
                        )
                      ]
                  )
              );
            })
    );

  void deleteProject(BuildContext context, String? pid) => Get.dialog(
        AlertDialog(
          title: Text('Diqqat!'.tr, style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: Get.width * 0.05)),
          content: Text('Loyiha o’chirilsinmi?'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04)),
          actions: [
            TextButton(
                onPressed: () => Get.back(),
                child: Text('Bekor qilish'.tr)
            ),
            TextButton(
                onPressed: () => {
                  Get.back(),
                  ApiController().projectDelete(pid)
                },
                child: Text('O‘chirish'.tr)
            )
          ],
        )
    );

  void deleteSwitch(BuildContext context, String? pid, sn) => Get.dialog(
        AlertDialog(
          title: Text('Diqqat!'.tr, style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: Get.width * 0.05)),
          content: Text('Qurilma o‘chirilsinmi?'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04)),
          actions: [
            TextButton(
                onPressed: () => Get.back(),
                child: Text('Bekor qilish'.tr)
            ),
            TextButton(
                onPressed: () => {
                  Get.back(),
                  ApiController().deleteSwitch(pid,sn)
                },
                child: Text('O‘chirish'.tr)
            )
          ],
        )
    );

  void infoPortDialog(BuildContext context) => Get.dialog(
        AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Text('Portlar holati'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.05)),
          content: SizedBox(
            width: Get.width,
            height: Get.height* 0.055,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      child: Column(
                          children: [
                            SvgPicture.asset('assets/svg_assets/port.svg', width: Get.width * 0.03, height: Get.height * 0.03,colorFilter: const ColorFilter.mode(AppColors.green, BlendMode.srcIn)),
                            Text('Yaxshi'.tr,maxLines: 1, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.027))
                          ]
                      )
                  ),
                  SizedBox(width: Get.width * 0.01),
                  SizedBox(
                      child: Column(
                          children: [
                            SvgPicture.asset('assets/svg_assets/port.svg', width: Get.width * 0.03, height: Get.height * 0.03,colorFilter: const ColorFilter.mode(AppColors.yellow, BlendMode.srcIn)),
                            Text('Normal'.tr,maxLines: 1, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.027))
                          ]
                      )
                  ),
                  SizedBox(width: Get.width * 0.01),
                  SizedBox(
                      child: Column(
                          children: [
                            SvgPicture.asset('assets/svg_assets/port.svg', width: Get.width * 0.03, height: Get.height * 0.03,colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn)),
                            Text('Past'.tr, maxLines: 1,style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.027))
                          ]
                      )
                  ),
                  SizedBox(width: Get.width * 0.01),
                  SizedBox(
                      child: Column(
                          children: [
                            SvgPicture.asset('assets/svg_assets/port.svg', width: Get.width * 0.03, height: Get.height * 0.03,colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn)),
                            Text('O`chiq'.tr, maxLines: 1,style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.027))
                          ]
                      )
                  )
                ]
            ),
          ),
          actions: [
            Column(
              children: [
                Text('dialoglar'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04)),
                Padding(padding: EdgeInsets.only(top: Get.height * 0.01), child: const Divider()),
                SizedBox(
                  width: Get.width,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      overlayColor: AppColors.blue.withOpacity(0.1),),
                      onPressed: () => {Get.back()}, child: Text('Ok'.tr, style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: Get.width * 0.04)))
                )
              ],
            )

          ],
        )
    );

  void loadingDialogs(BuildContext context) {
    final GetController getController = Get.put(GetController());
    Get.dialog(
        AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            title: Text('Kuting!'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.05)),
            content: SizedBox(
                width: Get.width,
                height: Get.height* 0.055,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: Theme.of(context).colorScheme.primary,)
                    ]
                )
            )
        )
    );

    // Observe the back variable
    ever(getController.back, (bool back) {
      if (!back) {
        Get.back();
      }
    });
  }

  void logOutDialog(BuildContext context) => Get.dialog(
        AlertDialog(
          title: Text('Tasdiqlash'.tr, style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: Get.width * 0.05)),
          content: Text('Hisobdan chiqishni xohlaysizmi?'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04)),
          actions: [
            TextButton(
                onPressed: () => Get.back(),
                child: Text('Bekor qilish'.tr)
            ),
            TextButton(
                onPressed: () => {
                  Get.back(),
                  _getController.isRequest.value = true,
                  _getController.sec.value = 0,
                  _getController.clearKey(),
                  _getController.clearUid(),
                  _getController.clearUser(),
                  Get.offAll(() => LoginPage())
                },
                child: Text('Ha'.tr)
            )
          ]
        )
    );

  void languageDialog(BuildContext context) => Get.bottomSheet(
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
                                              child: Column(
                                                children: [
                                                  Row(
                                                      children: [
                                                        Text(locale[index]['name'], style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04)),
                                                        const Spacer(),
                                                        if (locale[index]['locale'].toString() == _getController.language.toString())
                                                          Icon(TablerIcons.circle_check, color: Theme.of(context).colorScheme.onSurface),
                                                        if (locale[index]['locale'].toString() != _getController.language.toString())
                                                          Icon(TablerIcons.circle, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5))
                                                      ]
                                                  ),
                                                  SizedBox(height: Get.height * 0.01)
                                                ]
                                              ),
                                              onTap: (){
                                                updateLanguage(locale[index]['locale']);
                                                Get.back();
                                              }
                                          ),
                                          if (index != locale.length - 1)
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

  void rebootDialog(BuildContext context,projectId,serialNumber,index) => Get.dialog(
        AlertDialog(
          title: Text('Diqqat!'.tr, style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: Get.width * 0.05)),
          content: Text('Siz rostdan ham ushbu portni o‘chirib yoqishni xohlaysizmi?'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04)),
          actions: [
            TextButton(
                onPressed: () => Get.back(),
                child: Text('Bekor qilish'.tr)
            ),
            TextButton(
                onPressed: () => {
                  Get.back(),
                  ApiController().portRestart(projectId!, serialNumber!, index!)
                },
                child: Text('Ha'.tr)
            )
          ]
        )
    );

}