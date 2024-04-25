import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:hicom/companents/set_item.dart';
import 'package:hicom/resource/colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../controllers/get_controller.dart';

class UserPage extends StatelessWidget {
  UserPage({super.key});

  final GetController _getController = Get.put(GetController());

  final List locale =[
    {'name':'English','locale':const Locale('en','US')},
    {'name':'Russian','locale':const Locale('ru','RU')},
    {'name':'Uzbek','locale':const Locale('uz','UZ')},
    {'name':'Ўзбекча','locale':const Locale('oz','OZ')},
  ];

  updateLanguage(Locale locale){
    Get.updateLocale(locale);
  }

  bottomBuildLanguageDialog(BuildContext context){
    Get.bottomSheet(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
        enableDrag: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SizedBox(
                height: _getController.height.value * 0.5,
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      height: _getController.height.value * 0.005,
                      width: _getController.width.value * 0.2,
                      margin: EdgeInsets.only(top: _getController.height.value * 0.02, bottom: _getController.height.value * 0.03),
                      decoration: BoxDecoration(color: Theme.of(context).colorScheme.onBackground, borderRadius: BorderRadius.circular(10.0))
                    ),
                    Text('Tilni tanlang'.tr,
                      style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.045),
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: locale.length,
                            itemBuilder: (context, index){
                              return Container(
                                height: _getController.height.value * 0.07,
                                width: double.infinity,
                                padding: EdgeInsets.only(left: _getController.width.value * 0.035, right: _getController.width.value * 0.035),
                                child: Column(
                                  children: [
                                    InkWell(
                                        overlayColor: MaterialStateProperty.all(Colors.transparent),
                                        child: SizedBox(
                                            height: _getController.height.value * 0.05,
                                            child: Center(
                                                child: Row(
                                                    children: [
                                                      Text(locale[index]['name'], style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.04)),
                                                      const Spacer(),
                                                      if (locale[index]['locale'] == Get.locale)
                                                        Icon(TablerIcons.circle_check, color: Theme.of(context).colorScheme.onBackground),
                                                      if (locale[index]['locale'] != Get.locale)
                                                        Icon(TablerIcons.circle, color: Theme.of(context).colorScheme.onBackground),
                                                    ]
                                                )
                                            )
                                        ),
                                        onTap: (){
                                          updateLanguage(locale[index]['locale']);
                                        }),
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

  void _onLoading() async {
    _getController.refreshController.loadComplete();
  }

  void _getData() {
    _getController.refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(icon: Icon(Icons.arrow_back, size: _getController.height.value * 0.035), onPressed: () => Get.back()),
            centerTitle: true,
            title: Text('Mening hisobim'.tr)),
        body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            physics: const BouncingScrollPhysics(),
            header: CustomHeader(builder: (BuildContext context, RefreshStatus? mode) {return SizedBox(height: _getController.height.value * 0.1);}),
            footer: CustomFooter(builder: (BuildContext context, LoadStatus? mode) {return SizedBox(height: _getController.height.value * 0.1);}),
            onLoading: _onLoading,
            onRefresh: _getData,
            controller: _getController.refreshController,
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: _getController.height.value * 0.02),
                    Container(
                        width: _getController.width.value,
                        margin: EdgeInsets.symmetric(horizontal: _getController.height.value * 0.015, vertical: _getController.height.value * 0.01),
                        padding: EdgeInsets.all(_getController.height.value * 0.02),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: const Offset(1, 2) // changes position of shadow
                              )
                            ]),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Foydalanuvchi nomi'.tr, style: TextStyle(fontSize: _getController.height.value * 0.025, fontWeight: FontWeight.w500)),
                                      SizedBox(height: _getController.height.value * 0.01),
                                      Text('+998995340313'.tr, style: TextStyle(fontSize: _getController.height.value * 0.025, fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                  const Spacer(),
                                  Icon(Icons.account_circle, color: AppColors.primaryColor, size: _getController.height.value * 0.08),
                                ],
                              ),
                              SizedBox(height: _getController.height.value * 0.01),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                  onPressed: () {},
                                  child: Text('Tahrirlash'.tr, style: TextStyle(fontSize: _getController.height.value * 0.02, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.background))),
                              SizedBox(height: _getController.height.value * 0.01),
                              const Divider(),
                              Row(children: [
                                Icon(Icons.logout, color: AppColors.red, size: _getController.height.value * 0.035),
                                SizedBox(width: _getController.height.value * 0.01),
                                Text('Hisobdan chiqish'.tr, style: TextStyle(fontSize: _getController.width.value * 0.045, fontWeight: FontWeight.w500, color: AppColors.red))
                              ])
                            ])),
                    SizedBox(height: _getController.height.value * 0.02),
                    Container(
                        width: _getController.width.value,
                        margin: EdgeInsets.symmetric(horizontal: _getController.height.value * 0.015, vertical: _getController.height.value * 0.01),
                        padding: EdgeInsets.all(_getController.height.value * 0.01),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: const Offset(1, 2)
                              )
                            ]),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SettingsItem(
                                  icon: Icon(
                                      //Icons.nightlight_outlined,
                                      Theme.of(context).brightness != Brightness.dark ? Icons.wb_sunny_outlined : Icons.nightlight_outlined,
                                      color: Theme.of(context).colorScheme.onBackground,
                                      size: _getController.height.value * 0.04),
                                  title: 'Dastur mavzusi'.tr,
                                  onTap: () {},
                                  color: Theme.of(context).colorScheme.onBackground,
                                isNightMode: true),
                              const Divider(),
                              SettingsItem(
                                  icon: Icon(Icons.language, color: Theme.of(context).colorScheme.onBackground, size: _getController.height.value * 0.04),
                                  title: 'Dastur tili'.tr,
                                  onTap: () {
                                    bottomBuildLanguageDialog(context);
                                    //buildLanguageDialog(context);
                                  },
                                  color: Theme.of(context).colorScheme.onBackground, isNightMode: false),
                              const Divider(),
                              SettingsItem(
                                  icon: Icon(Icons.question_mark_outlined, color: Theme.of(context).colorScheme.onBackground, size: _getController.height.value * 0.04),
                                  title: 'Foydalanish yo\'riqnomasi'.tr,
                                  onTap: () {},
                                  color: Theme.of(context).colorScheme.onBackground,
                                  isNightMode: false
                              ),
                              const Divider(),
                              SettingsItem(
                                  icon: Icon(Icons.headphones_outlined, color: Theme.of(context).colorScheme.onBackground, size: _getController.height.value * 0.04),
                                  title: 'Qo\'llab quvvatlash'.tr,
                                  onTap: () {},
                                  color: Theme.of(context).colorScheme.onBackground,
                                  isNightMode: false
                              ),
                              const Divider(),
                              SettingsItem(
                                  icon: Icon(Icons.star_outline_rounded, color: Theme.of(context).colorScheme.onBackground, size: _getController.height.value * 0.04),
                                  title: 'Dasturni baholash'.tr,
                                  onTap: () {},
                                  color: Theme.of(context).colorScheme.onBackground,
                                  isNightMode: false
                              ),
                              const Divider(),
                              SettingsItem(
                                  icon: Icon(Icons.share_outlined, color: Theme.of(context).colorScheme.onBackground, size: _getController.height.value * 0.04),
                                  title: 'Dasturni ulashish'.tr,
                                  onTap: () {},
                                  color: Theme.of(context).colorScheme.onBackground,
                                  isNightMode: false
                              ),
                            ]))
                  ],
                ))));
  }
}
