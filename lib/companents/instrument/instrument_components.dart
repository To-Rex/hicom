import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';
import '../../controllers/tea.dart';
import '../../resource/colors.dart';
import '../text_fild.dart';

class InstrumentComponents {
  final GetController _getController = Get.put(GetController());

  void showToast(context,String title,String message, error,sec) {
    Get.snackbar(
      title.tr,
      message.tr,
      backgroundColor: error ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.onBackground,
      colorText: error ? Theme.of(context).colorScheme.onError : Theme.of(context).colorScheme.surface,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.only(
          bottom: _getController.height.value * 0.03,
          left: _getController.width.value * 0.04,
          right: _getController.width.value * 0.04
      ),
      borderRadius: 12,
      duration: Duration(seconds: sec),
      icon: error ? Icon(
        Icons.error,
        color: Theme.of(context).colorScheme.onError,
      ) : null,
    );
  }

  void showDialogConnectivity(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Internet bağlanmadi'.tr),
          content: Text('Internet bağlanmadi'.tr),
          actions: <Widget>[
            TextButton(
                child: Text('Yana qayta urinish'.tr),
                onPressed: () {
                  Navigator.of(context).pop();
                }
            ),
          ],
        );
      },
    );
  }

  bottomBuildLanguageDialog(BuildContext context,title,cat){
    Get.bottomSheet(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
        enableDrag: true,
        isScrollControlled: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SizedBox(
                  height: _getController.height.value * 0.7,
                  width: double.infinity,
                  child: Column(
                      children: [
                        Container(height: _getController.height.value * 0.005, width: _getController.width.value * 0.2, margin: EdgeInsets.only(top: _getController.height.value * 0.02, bottom: _getController.height.value * 0.03), decoration: BoxDecoration(color: Theme.of(context).colorScheme.onBackground, borderRadius: BorderRadius.circular(10.0))),
                        Text(title.toString().tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.045)),
                        SizedBox(height: _getController.height.value * 0.02),
                        if (cat == 0)
                          Expanded(
                              child: ListView.builder(
                                  itemCount: _getController.provinceModel.value.regions!.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (index != 0) {
                                              _getController.changeDropDownItems(0, index);
                                              ApiController().getRegions(Tea.encryptTea('{"country_id": 1,"region_id": ${_getController.provinceModel.value.regions![_getController.dropDownItems[0]].id.toString()}}',ApiController.key), 'districts');
                                            }
                                          });
                                        },
                                        child: Padding(
                                            padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                                            child: Column(
                                                children: [
                                                  SizedBox(height: _getController.height.value * 0.01),
                                                  Container(
                                                      height: _getController.height.value * 0.04,
                                                      width: _getController.width.value,
                                                      margin: EdgeInsets.only(bottom: _getController.height.value * 0.01),
                                                      child: Center(
                                                          child: Row(
                                                              children: [
                                                                Text(_getController.provinceModel.value.regions![index].name.toString(), style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.04),),
                                                                const Spacer(),
                                                                if (_getController.dropDownItems[0] == index)
                                                                  Icon(TablerIcons.circle_check, color: Theme.of(context).colorScheme.onBackground)
                                                                else
                                                                  Icon(TablerIcons.circle, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5))
                                                              ]
                                                          )
                                                      )
                                                  ),
                                                  if (_getController.provinceModel.value.regions!.length - 1 != index)
                                                    const Divider(),
                                                  if (_getController.provinceModel.value.regions!.length - 1 == index)
                                                    SizedBox(height: _getController.height.value * 0.01),
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
                                            setState(() {
                                              _getController.changeDropDownItems(1, index);
                                            });
                                          }
                                        },
                                        child: Padding(padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                                            child: Column(
                                                children: [
                                                  SizedBox(height: _getController.height.value * 0.01),
                                                  Container(
                                                      height: _getController.height.value * 0.04,
                                                      width: _getController.width.value,
                                                      margin: EdgeInsets.only(bottom: _getController.height.value * 0.01),
                                                      child: Center(
                                                          child: Row(
                                                              children: [
                                                                Text(_getController.districtsModel.value.districts![index].name.toString(),
                                                                    style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.04)),
                                                                const Spacer(),
                                                                if (_getController.dropDownItems[1] == index)
                                                                  Icon(TablerIcons.circle_check, color: Theme.of(context).colorScheme.onBackground)
                                                                else
                                                                  Icon(TablerIcons.circle, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5))
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
                                            _getController.changeDropDownItems(2, index);
                                          });
                                        },
                                        child: Padding(
                                            padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                                            child: Column(
                                                children: [
                                                  SizedBox(height: _getController.height.value * 0.01),
                                                  Container(
                                                      height: _getController.height.value * 0.04,
                                                      width: _getController.width.value,
                                                      margin: EdgeInsets.only(bottom: _getController.height.value * 0.01),
                                                      child: Center(
                                                          child: Row(
                                                              children: [
                                                                Text(_getController.dropDownItem[index].tr,style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.04),),
                                                                const Spacer(),
                                                                if (_getController.dropDownItems[2] == index)
                                                                  Icon(TablerIcons.circle_check, color: Theme.of(context).colorScheme.onBackground)
                                                                else
                                                                  Icon(TablerIcons.circle, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5))
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
  }

  bottomSheetEditName(BuildContext context, pidId) {
    Get.bottomSheet(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
        enableDrag: true,
        isScrollControlled: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                  height: _getController.height.value * 0.45,
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0))),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppBar(
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
                          title: Text('Foydalanuvchi nomini o’zgartirish'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.045)),
                          centerTitle: false,
                          backgroundColor: Theme.of(context).colorScheme.background,
                          elevation: 0,
                          leadingWidth: 0,
                          leading: Container(),
                          actions: [
                            IconButton(onPressed: () => Get.back(), icon: Icon(TablerIcons.x, color: Theme.of(context).colorScheme.onBackground, size: _getController.width.value * 0.05))
                          ]
                        ),
                        SizedBox(height: _getController.height.value * 0.02),
                        TextFields(title: 'Loyihani nomi'.tr,hintText: 'Kiriting'.tr, controller: _getController.nameProjectController),
                        SizedBox(height: _getController.height.value * 0.02),
                        TextFields(title: 'Qo`shimcha ma`lumot'.tr,hintText: 'Kiriting'.tr, controller: _getController.noteProjectController),
                        SizedBox(height: _getController.height.value * 0.04),
                        Padding(padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                            child: ElevatedButton(
                                onPressed: () => {
                                  if (_getController.nameProjectController.text == '') {
                                    showToast(context, 'Loyihani nomini kiriting'.tr, 'Loyihani nomini kiriting'.tr, true, 3)
                                  } else if (_getController.noteProjectController.text == '') {
                                    showToast(context, 'Qo`shimcha ma`lumot kiriting'.tr, 'Qo`shimcha ma`lumot kiriting'.tr, true, 3)
                                  } else {
                                    ApiController().renameProjects(pidId, _getController.nameProjectController.text, _getController.noteProjectController.text)
                                  }
                                },
                                style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))), backgroundColor: MaterialStateProperty.all(AppColors.primaryColor3)),
                                child: SizedBox(
                                    width: _getController.width.value,
                                    height: _getController.height.value * 0.06,
                                    child: Center(child: Text('Saqlash'.tr, style: TextStyle(color: Theme.of(context).colorScheme.background, fontSize: _getController.width.value * 0.04))))
                            )
                        )
                      ]
                  )
              );
            })
    );
  }

  bottomSwitchEditName(BuildContext context, pidId,sn,index,online) {
    _getController.nameProjectController.text = online ? _getController.switchListModel.value.online![index].name! : _getController.switchListModel.value.offline![index].name!;
    _getController.noteProjectController.text = online ? _getController.switchListModel.value.online![index].note! : _getController.switchListModel.value.offline![index].note!;
    Get.bottomSheet(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
        enableDrag: true,
        isScrollControlled: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                  height: _getController.height.value * 0.45,
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0))),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppBar(
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
                          title: Text('Qurilmani tahrirlash'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.045)),
                          centerTitle: false,
                          backgroundColor: Theme.of(context).colorScheme.background,
                          elevation: 0,
                          leadingWidth: 0,
                          leading: Container(),
                          actions: [
                            IconButton(onPressed: () => Get.back(), icon: Icon(TablerIcons.x, color: Theme.of(context).colorScheme.onBackground, size: _getController.width.value * 0.05))
                          ]
                        ),
                        SizedBox(height: _getController.height.value * 0.02),
                        TextFields(title: 'Qurilmani nomi'.tr,hintText: 'Kiriting'.tr, controller: _getController.nameProjectController),
                        SizedBox(height: _getController.height.value * 0.02),
                        TextFields(title: 'Qo`shimcha ma`lumot'.tr,hintText: 'Kiriting'.tr, controller: _getController.noteProjectController),
                        SizedBox(height: _getController.height.value * 0.04),
                        Padding(padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                            child: ElevatedButton(
                                onPressed: () => {
                                  if (_getController.nameProjectController.text == '') {
                                    showToast(context, 'Diqqat!'.tr, 'Loyihani nomini kiriting'.tr, true, 3)
                                  } else if (_getController.noteProjectController.text == '') {
                                    showToast(context, 'Diqqat!'.tr, 'Qo`shimcha ma`lumot kiriting'.tr, true, 3)
                                  } else {
                                    ApiController().renameSwitch(pidId, sn)
                                  }
                                },
                                style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))), backgroundColor: MaterialStateProperty.all(AppColors.primaryColor3)),
                                child: SizedBox(
                                    width: _getController.width.value,
                                    height: _getController.height.value * 0.06,
                                    child: Center(child: Text('Saqlash'.tr, style: TextStyle(color: Theme.of(context).colorScheme.background, fontSize: _getController.width.value * 0.04))))
                            )
                        )
                      ]
                  )
              );
            })
    );
  }

  bottomSheetUsers(BuildContext context, pidId) {
    Get.bottomSheet(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
        enableDrag: true,
        isScrollControlled: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                  height: _getController.height.value * 0.6,
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0))),
                  width: double.infinity,
                  child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppBar(
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
                            title: Text('Loyihani kuzatuvchilari'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.045)),
                            centerTitle: false,
                            backgroundColor: Theme.of(context).colorScheme.background,
                            elevation: 0,
                            leadingWidth: 0,
                            leading: Container(),
                            actions: [
                              IconButton(onPressed: () => Get.back(), icon: Icon(TablerIcons.x, color: Theme.of(context).colorScheme.onBackground, size: _getController.width.value * 0.05))
                            ]
                        ),
                        SizedBox(height: _getController.height.value * 0.02),
                        //Null check operator used on a null value
                        if (_getController.getUsersModel.value.join != null)
                          ListView.builder(
                              itemCount: _getController.getUsersModel.value.join!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return ListTile(
                                    leading: Icon(Icons.person, color: Theme.of(context).colorScheme.onBackground, size: _getController.width.value * 0.05),
                                    title: Text(_getController.getUsersModel.value.join![index].name.toString()),
                                    trailing: Icon(TablerIcons.circle, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5))
                                );
                              }
                          )
                      ]
                  ))
              );
            })
    );
  }

  bottomCrackUser(BuildContext context) {
    Get.bottomSheet(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
        enableDrag: true,
        isScrollControlled: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                  height: _getController.height.value * 0.6,
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0))),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppBar(
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
                          title: Text('User crack'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.045)),
                          centerTitle: false,
                          backgroundColor: Theme.of(context).colorScheme.background,
                          elevation: 0,
                          leadingWidth: 0,
                          leading: Container(),
                          actions: [
                            IconButton(onPressed: () => Get.back(), icon: Icon(TablerIcons.x, color: Theme.of(context).colorScheme.onBackground, size: _getController.width.value * 0.05))
                          ]
                        ),
                        SizedBox(height: _getController.height.value * 0.02),
                        TextFields(title: 'User Data'.tr,hintText: 'Kiriting'.tr, controller: _getController.nameProjectController),
                        const Expanded(child: SizedBox()),
                        Padding(padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                            child: ElevatedButton(
                                onPressed: () => {
                                  _getController.addUserData(_getController.nameProjectController.text)
                                },
                                style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))), backgroundColor: MaterialStateProperty.all(AppColors.primaryColor3)),
                                child: SizedBox(
                                    width: _getController.width.value,
                                    height: _getController.height.value * 0.06,
                                    child: Center(child: Text('Saqlash'.tr, style: TextStyle(color: Theme.of(context).colorScheme.background, fontSize: _getController.width.value * 0.04))))
                            )
                        ),
                        SizedBox(height: _getController.height.value * 0.02)
                      ]
                  )
              );
            })
    );
  }

  bottomSheetShare(BuildContext context, pidId) {
    Get.bottomSheet(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
        enableDrag: true,
        isScrollControlled: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                  height: _getController.height.value * 0.45,
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0))),
                  width: double.infinity,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppBar(
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
                            title: Text('Loyihani ulashish'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.045)),
                            centerTitle: false,
                            backgroundColor: Theme.of(context).colorScheme.background,
                            elevation: 0,
                            leadingWidth: 0,
                            leading: Container(),
                            actions: [
                              IconButton(onPressed: () => Get.back(), icon: Icon(TablerIcons.x, color: Theme.of(context).colorScheme.onBackground, size: _getController.width.value * 0.05))
                            ]
                        ),
                        SizedBox(height: _getController.height.value * 0.02),
                        TextFields(title: 'Kuzatuvchi telefon raqami'.tr,hintText: 'Kiriting'.tr, controller: _getController.nameProjectController),
                        SizedBox(height: _getController.height.value * 0.02),
                        TextFields(title: 'Kuzatuvchi nomi'.tr,hintText: 'Kiriting'.tr, controller: _getController.noteProjectController),
                        SizedBox(height: _getController.height.value * 0.04),
                        Padding(padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
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
                                style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))), backgroundColor: MaterialStateProperty.all(AppColors.primaryColor3)),
                                child: SizedBox(
                                    width: _getController.width.value,
                                    height: _getController.height.value * 0.06,
                                    child: Center(child: Text('Saqlash'.tr, style: TextStyle(color: Theme.of(context).colorScheme.background, fontSize: _getController.width.value * 0.04))))
                            )
                        )
                      ]
                  )
              );
            })
    );
  }

  bottomSheetProjectAdd(BuildContext context, pidId) {
    Get.bottomSheet(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
        enableDrag: true,
        isScrollControlled: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                  height: _getController.height.value * 0.45,
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0))),
                  width: double.infinity,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppBar(
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
                            title: Text('Loyihani ulashish'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.045)),
                            centerTitle: false,
                            backgroundColor: Theme.of(context).colorScheme.background,
                            elevation: 0,
                            leadingWidth: 0,
                            leading: Container(),
                            actions: [
                              IconButton(onPressed: () => Get.back(), icon: Icon(TablerIcons.x, color: Theme.of(context).colorScheme.onBackground, size: _getController.width.value * 0.05))
                            ]
                        ),
                        SizedBox(height: _getController.height.value * 0.02),
                        TextFields(title: 'Kuzatuvchi telefon raqami'.tr,hintText: 'Kiriting'.tr, controller: _getController.nameProjectController),
                        SizedBox(height: _getController.height.value * 0.02),
                        TextFields(title: 'Kuzatuvchi nomi'.tr,hintText: 'Kiriting'.tr, controller: _getController.noteProjectController),
                        SizedBox(height: _getController.height.value * 0.04),
                        Padding(padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
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
                                style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))), backgroundColor: MaterialStateProperty.all(AppColors.primaryColor3)),
                                child: SizedBox(
                                    width: _getController.width.value,
                                    height: _getController.height.value * 0.06,
                                    child: Center(child: Text('Saqlash'.tr, style: TextStyle(color: Theme.of(context).colorScheme.background, fontSize: _getController.width.value * 0.04))))
                            )
                        )
                      ]
                  )
              );
            })
    );
  }

  void deleteProject(BuildContext context, String? pid) {
    Get.dialog(
        AlertDialog(
          title: Text('Diqqat!'.tr, style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: _getController.width.value * 0.05)),
          content: Text('Loyiha o’chirilsinmi?'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.04)),
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
                child: Text('O’chirish'.tr)
            )
          ],
        )
    );
  }

  void deleteSwitch(BuildContext context, String? pid, sn) {
    Get.dialog(
        AlertDialog(
          title: Text('Diqqat!'.tr, style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: _getController.width.value * 0.05)),
          content: Text('Qurilma o’chirilsinmi?'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.04)),
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
                child: Text('O’chirish'.tr)
            )
          ],
        )
    );
  }

  void infoPortDialog(BuildContext context) {
    Get.dialog(
        AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Text('Portlar holati'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: _getController.width.value * 0.05)),
          content: SizedBox(
            width: _getController.width.value,
            height: _getController.height.value * 0.055,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      child: Column(
                          children: [
                            SvgPicture.asset('assets/svg_assets/port.svg', width: _getController.width.value * 0.03, height: _getController.height.value * 0.03,colorFilter: const ColorFilter.mode(AppColors.green, BlendMode.srcIn)),
                            Text('Yaxshi',maxLines: 1, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: _getController.width.value * 0.027))
                          ]
                      )
                  ),
                  SizedBox(
                      child: Column(
                          children: [
                            SvgPicture.asset('assets/svg_assets/port.svg', width: _getController.width.value * 0.03, height: _getController.height.value * 0.03,colorFilter: const ColorFilter.mode(AppColors.yellow, BlendMode.srcIn)),
                            Text('Normal',maxLines: 1, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: _getController.width.value * 0.027))
                          ]
                      )
                  ),
                  SizedBox(
                      child: Column(
                          children: [
                            SvgPicture.asset('assets/svg_assets/port.svg', width: _getController.width.value * 0.03, height: _getController.height.value * 0.03,colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn)),
                            Text('Past', maxLines: 1,style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: _getController.width.value * 0.027))
                          ]
                      )
                  ),
                  SizedBox(
                      child: Column(
                          children: [
                            SvgPicture.asset('assets/svg_assets/port.svg', width: _getController.width.value * 0.03, height: _getController.height.value * 0.03,colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn)),
                            Text('O`chiq', maxLines: 1,style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: _getController.width.value * 0.027))
                          ]
                      )
                  )
                ]
            ),
          ),
          actions: [
            Column(
              children: [
                Text('Agar belgi sariq yoki to\'q sariq bo\'lsa, tarmoq kabeli va kristall boshini tekshiring, chiziq juda uzun yoki yomon simli material tufayli portning ultra uzoq masofali funksiyasini yoqishga harakat qiling.'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: _getController.width.value * 0.04)),
                Padding(padding: EdgeInsets.only(top: _getController.height.value * 0.01), child: const Divider()),
                SizedBox(
                  width: Get.width,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      overlayColor: AppColors.blue.withOpacity(0.1),),
                      onPressed: () => {Get.back()}, child: Text('Ok'.tr, style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: _getController.width.value * 0.04)))
                )
              ],
            )

          ],
        )
    );
  }
}