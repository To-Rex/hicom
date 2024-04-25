import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:hicom/resource/colors.dart';
import '../companents/set_support_item.dart';
import '../controllers/get_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatelessWidget {
  SupportPage({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Qo\'llab quvvatlash'.tr,
          style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.05),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back()),
        ),
      body: Column(
        children: [
          SizedBox(height: Get.height * 0.02),
          Container(
              width: _getController.width.value,
              margin: EdgeInsets.symmetric(horizontal: _getController.height.value * 0.015, vertical: _getController.height.value * 0.01),
              padding: EdgeInsets.all(_getController.height.value * 0.01),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.2), spreadRadius: 2, blurRadius: 2, offset: const Offset(1, 2))]),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SettingsSupportItem(
                      icon: Icon(TablerIcons.device_mobile, color: AppColors.primaryColor, size: _getController.height.value * 0.04),
                      title: 'Bog\'lanish'.tr,
                      onTap: () {launchUrl(Uri.parse('tel:+998916848100'));},
                      color: Theme.of(context).colorScheme.onBackground,
                      isNightMode: false,
                      isLanguage: false,
                      subTitle: '+998 (91) 684 81 00',
                    ),
                    const Divider(),
                    SettingsSupportItem(
                      icon: Icon(TablerIcons.app_window, color: AppColors.primaryColor, size: _getController.height.value * 0.04),
                      title: 'Web sahifa'.tr,
                      onTap: () {
                        launchUrl(Uri.parse('https://hicom.uz/'));
                      },
                      color: Theme.of(context).colorScheme.onBackground,
                      isNightMode: false,
                      isLanguage: false,
                      subTitle: 'https://hicom.uz/',
                    ),
                    const Divider(),
                    SettingsSupportItem(
                      icon: Icon(TablerIcons.map_pin, color: AppColors.primaryColor, size: _getController.height.value * 0.04),
                      title: 'Manzil'.tr,
                      onTap: () {
                        launchUrl(Uri.parse('https://www.google.com/maps/place/A.Navoiy+11-Dom/@40.5426183,70.9738684,17z/data=!3m1!4b1!4m6!3m5!1s0x38baef5de4263135:0x64726a31ecef6899!8m2!3d40.5426143!4d70.9787393!16s%2Fg%2F11pz0m72r6?entry=ttu'));
                      },
                      color: Theme.of(context).colorScheme.onBackground,
                      isNightMode: false,
                      isLanguage: false,
                      subTitle: 'Qo\'qon shaxar, A.Navoiy, 12 uy.',
                    ),
                  ])),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    launchUrl(Uri.parse('https://t.me/Hicom_uz'));
                  },
                  icon: Icon(
                      TablerIcons.brand_telegram,
                      color: Theme.of(context).colorScheme.onBackground,
                      size: _getController.height.value * 0.04)
              ),
              SizedBox(width: Get.width * 0.01),
              IconButton(
                  onPressed: () {
                    launchUrl(Uri.parse('https://m.facebook.com/hicom.uz'));
                  },
                  icon: Icon(TablerIcons.brand_facebook,
                      color: Theme.of(context).colorScheme.onBackground,
                      size: _getController.height.value * 0.04)
              ),
              SizedBox(width: Get.width * 0.01),
              IconButton(
                  onPressed: () {
                    launchUrl(Uri.parse('https://www.instagram.com/hicom.uz/'));
                  },
                  icon: Icon(TablerIcons.brand_instagram,
                      color: Theme.of(context).colorScheme.onBackground,
                      size: _getController.height.value * 0.04)
              ),
            ],
          ),
          SizedBox(height: Get.height * 0.03),
          Text(
            'Hicom.uz 1.0.0 (9)',
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.04),
          ),
          SizedBox(height: Get.height * 0.02),
        ],
      )
    );
  }

}