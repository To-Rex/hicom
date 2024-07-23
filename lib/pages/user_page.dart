import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:hicom/companents/instrument/instrument_components.dart';
import 'package:hicom/companents/set_item.dart';
import 'package:hicom/controllers/api_controller.dart';
import 'package:hicom/pages/support_page.dart';
import 'package:hicom/resource/colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../controllers/get_controller.dart';
import 'package:share_link/share_link.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'edit_user.dart';
import 'instruction_page.dart';

class UserPage extends StatelessWidget {
  UserPage({super.key});

  final GetController _getController = Get.put(GetController());

  void showRateDialog(BuildContext context) {
    Get.defaultDialog(
      title: 'Dasturni baholash'.tr,
      titleStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04),
      backgroundColor: Theme.of(context).colorScheme.surface,
        confirm: ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                backgroundColor: AppColors.primaryColor,
                minimumSize: Size(Get.width * 0.4, Get.height * 0.05),
            ),
            child: Text('Bekor qilish'.tr, style: TextStyle(color: AppColors.white, fontSize: Get.width * 0.04))
        ),

        content: Column(
        children: [
          RatingBar.builder(
            initialRating: 3,
            minRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
            onRatingUpdate: (rating) => {
              Get.back(),
              Get.showSnackbar(
                GetSnackBar(
                  title: 'Dasturni baholash'.tr,
                  message: 'Yuborildi'.tr,
                  backgroundColor: AppColors.black70.withOpacity(0.7),
                  duration: const Duration(seconds: 2),
                  margin: const EdgeInsets.all(10.0),
                  borderRadius: 10.0
                )
              )
            }
          ),
          SizedBox(height: Get.height * 0.01),
        ]
      )
    );
  }

  final _refreshController = RefreshController(initialRefresh: false);

  void _onLoading() => _refreshController.loadComplete();
  void _getData() => _refreshController.refreshCompleted();

  @override
  Widget build(BuildContext context) {
    _getController.getUser();
    _getController.nameController.text = _getController.loginModel.value.user?.name ?? '';
    return Scaffold(
        appBar: AppBar(leading: IconButton(icon: Icon(Icons.arrow_back, size: Get.width * 0.07), onPressed: () => Get.back()), centerTitle: true, title: Text('Mening hisobim'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.05),)),
        body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            physics: const BouncingScrollPhysics(),
            header: CustomHeader(builder: (BuildContext context, RefreshStatus? mode) {return SizedBox(height: Get.height * 0.1);}),
            footer: CustomFooter(builder: (BuildContext context, LoadStatus? mode) {return SizedBox(height: Get.height * 0.1);}),
            onLoading: _onLoading,
            onRefresh: _getData,
            controller: _refreshController,
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Obx(() => Column(
                    children: [
                      SizedBox(height: Get.height * 0.02),
                      Card(
                        margin: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 5,
                        color: Theme.of(context).colorScheme.surface,
                        child: Padding(
                          padding: EdgeInsets.all(Get.height * 0.02),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          if (_getController.loginModel.value.user != null)
                                            Text(_getController.loginModel.value.user!.name.toString(), style: TextStyle(fontSize: Get.height * 0.025, fontWeight: FontWeight.w500)),
                                          SizedBox(height: Get.height * 0.01),
                                          if (_getController.loginModel.value.user != null)
                                            Text(_getController.loginModel.value.user!.phone.toString(), style: TextStyle(fontSize: Get.height * 0.025, fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                      const Spacer(),
                                      SvgPicture.asset('assets/svg_assets/user.svg', width: Get.height * 0.08, height: Get.height * 0.08)
                                    ]
                                ),
                                SizedBox(height: Get.height * 0.01),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                    onPressed: () {
                                      _getController.changeDropDownItemsType();
                                      Get.to(() => EditUser(), transition: Transition.fadeIn);
                                    },
                                    child: Text('Tahrirlash'.tr, style: TextStyle(fontSize: Get.height * 0.02, fontWeight: FontWeight.w500, color: AppColors.white))),
                                SizedBox(height: Get.height * 0.01),
                                const Divider(),
                                SizedBox(height: Get.height * 0.01),
                                InkWell(
                                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                                  child: Row(
                                      children: [
                                        Icon(TablerIcons.logout, color: AppColors.red, size: Get.height * 0.035),
                                        SizedBox(width: Get.height * 0.01),
                                        Text('Hisobdan chiqish'.tr, style: TextStyle(fontSize: Get.width * 0.045, fontWeight: FontWeight.w500, color: AppColors.red))
                                      ]
                                  ),
                                  onTap: (){
                                    InstrumentComponents().logOutDialog(context);
                                  },
                                  onLongPress: (){
                                    ApiController().deleteUser();
                                  },
                                )
                              ])
                        )
                      ),
                      SizedBox(height: Get.height * 0.02),
                      Card(
                          margin: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          elevation: 5,
                          color: Theme.of(context).colorScheme.surface,
                          child: Padding(
                            padding: EdgeInsets.all(Get.height * 0.02),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SettingsItem(
                                      icon: Icon(Theme.of(context).brightness != Brightness.dark ? TablerIcons.sun : TablerIcons.moon, color: Theme.of(context).colorScheme.onSurface, size: Get.height * 0.04),
                                      title: 'Dastur mavzusi'.tr,
                                      onTap: () {
                                        _getController.setRequest();
                                      },
                                      color: Theme.of(context).colorScheme.onSurface,
                                      isNightMode: true,
                                      isLanguage: false
                                  ),
                                  const Divider(),
                                  SettingsItem(
                                      icon: Icon(TablerIcons.world, color: Theme.of(context).colorScheme.onSurface, size: Get.height * 0.04),
                                      title: 'Dastur tili'.tr,
                                      onTap: () {
                                        InstrumentComponents().languageDialog(context);
                                      },
                                      color: Theme.of(context).colorScheme.onSurface, isNightMode: false,
                                      isLanguage: true
                                  ),
                                  const Divider(),
                                  SettingsItem(
                                      icon: Icon(TablerIcons.info_circle, color: Theme.of(context).colorScheme.onSurface, size: Get.height * 0.04),
                                      title: 'Foydalanish yo‘riqnomasi'.tr,
                                      onTap: () {
                                        Get.to(() => InstructionPage(), transition: Transition.fadeIn);
                                      },
                                      color: Theme.of(context).colorScheme.onSurface,
                                      isNightMode: false,
                                      isLanguage: false
                                  ),
                                  const Divider(),
                                  SettingsItem(
                                      icon: Icon(TablerIcons.headphones, color: Theme.of(context).colorScheme.onSurface, size: Get.height * 0.04),
                                      title: 'Qo‘llab quvvatlash'.tr,
                                      onTap: () {
                                        ApiController().getSettings();
                                        Get.to(() => SupportPage(), transition: Transition.fadeIn);
                                      },
                                      color: Theme.of(context).colorScheme.onSurface,
                                      isNightMode: false,
                                      isLanguage: false
                                  ),
                                  const Divider(),
                                  SettingsItem(
                                      icon: Icon(TablerIcons.star, color: Theme.of(context).colorScheme.onSurface, size: Get.height * 0.04),
                                      title: 'Dasturni baholash'.tr,
                                      onTap: () {
                                        showRateDialog(context);
                                      },
                                      color: Theme.of(context).colorScheme.onSurface,
                                      isNightMode: false,
                                      isLanguage: false
                                  ),
                                  const Divider(),
                                  SettingsItem(
                                      icon: Icon(TablerIcons.share, color: Theme.of(context).colorScheme.onSurface, size: Get.height * 0.04),
                                      title: 'Dasturni ulashish'.tr,
                                      onTap: () {
                                        ShareLink.shareUri(Uri.parse('http://play.google.com/store/apps/details?id=com.uz.hicom'), subject: 'Hicom.uz');
                                      },
                                      color: Theme.of(context).colorScheme.onSurface,
                                      isNightMode: false,
                                      isLanguage: false
                                  )
                                ]
                            )
                          )
                      ),
                      SizedBox(height: Get.height * 0.02),
                      Text('©Hicom 2024', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04))
                    ]
                ))
            )
        )
    );
  }
}
