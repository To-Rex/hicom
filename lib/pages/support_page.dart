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
        title: Text('Qo‘llab quvvatlash'.tr,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.05),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back()),
        ),
      body: Column(
        children: [
          SizedBox(height: Get.height * 0.02),
          if (_getController.settingsInfoModel.value.settings != null)
            Card(
                color: Theme.of(context).colorScheme.surface,
                margin: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 5,
                child: Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.02, right: Get.width * 0.02, top: Get.height * 0.01, bottom: Get.height * 0.01),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (_getController.getSettings('ContactPhone') != '')
                            SettingsSupportItem(
                                icon: Icon(TablerIcons.device_mobile, color: AppColors.primaryColor, size: Get.height * 0.04),
                                title: 'Bog‘lanish'.tr,
                                onTap: () {launchUrl(Uri.parse('tel:${_getController.getSettings('ContactPhone')}'));},
                                color: Theme.of(context).colorScheme.onSurface,
                                isNightMode: false,
                                isLanguage: false,
                                subTitle: _getController.getSettings('ContactPhone')
                            ),
                          if (_getController.getSettings('ContactPhone') != '')
                            const Divider(),
                          if (_getController.getSettings('ContactSite') != '')
                            SettingsSupportItem(
                                icon: Icon(TablerIcons.app_window, color: AppColors.primaryColor, size: Get.height * 0.04),
                                title: 'Web sahifa'.tr,
                                onTap: () {
                                  launchUrl(Uri.parse(_getController.getSettings('ContactSite')));
                                },
                                color: Theme.of(context).colorScheme.onSurface,
                                isNightMode: false,
                                isLanguage: false,
                                subTitle: _getController.getSettings('ContactSite')
                            ),
                          if (_getController.getSettings('ContactSite') != '')
                            const Divider(),
                          if (_getController.getSettings('ContactAddress') != '')
                            SettingsSupportItem(
                                icon: Icon(TablerIcons.map_pin, color: AppColors.primaryColor, size: Get.height * 0.04),
                                title: 'Manzil'.tr,
                                onTap: () {
                                  launchUrl(Uri.parse('https://www.google.com/maps/place/${_getController.getSettings('ContactAddress')}'));
                                },
                                color: Theme.of(context).colorScheme.onSurface,
                                isNightMode: false,
                                isLanguage: false,
                                subTitle: _getController.getSettings('ContactAddress')
                            )
                        ]
                    )
                )
            ),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_getController.getSettings('ContactTelegram') != '')
              IconButton(
                  onPressed: () {
                    launchUrl(Uri.parse(_getController.getSettings('ContactTelegram')));
                  },
                  icon: Icon(
                      TablerIcons.brand_telegram,
                      color: AppColors.primaryColor,
                      size: Get.height * 0.04)
              ),
              if (_getController.getSettings('ContactTelegram') != '')
              SizedBox(width: Get.width * 0.01),
              if (_getController.getSettings('ContactFacebook') != '')
              IconButton(
                  onPressed: () {
                    launchUrl(Uri.parse(_getController.getSettings('ContactFacebook')));
                  },
                  icon: Icon(TablerIcons.brand_facebook,
                      color: AppColors.primaryColor,
                      size: Get.height * 0.04)
              ),
              if (_getController.getSettings('ContactFacebook') != '')
              SizedBox(width: Get.width * 0.01),
              if (_getController.getSettings('ContactInstagram') != '')
              IconButton(
                  onPressed: () {
                    launchUrl(Uri.parse(_getController.getSettings('ContactInstagram')));
                  },
                  icon: Icon(TablerIcons.brand_instagram,
                      color: AppColors.primaryColor,
                      size: Get.height * 0.04)
              ),
            ],
          ),
          SizedBox(height: Get.height * 0.03),
          Text(
            'Hicom.uz 1.0.0 (9)',
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Get.width * 0.04),
          ),
          SizedBox(height: Get.height * 0.02),
        ],
      )
    );
  }

}