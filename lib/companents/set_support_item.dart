import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/get_controller.dart';
import '../resource/colors.dart';

class SettingsSupportItem extends StatelessWidget {

  Icon icon;
  String title;
  String subTitle;
  Function onTap;
  Color color;
  bool isNightMode;
  bool isLanguage;

  SettingsSupportItem({super.key, required this.icon, required this.title, required this.subTitle, required this.onTap, required this.color, required this.isNightMode, required this.isLanguage});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: [
          icon,
          SizedBox(width: Get.width * 0.03),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: color, fontSize: Get.width * 0.04, fontWeight: FontWeight.w500)),
              Text(subTitle, style: TextStyle(color: color.withOpacity(0.5), fontSize: Get.width * 0.03, fontWeight: FontWeight.w500))
            ]
          ),
          const Spacer(),
          if (isLanguage)
            Text(Get.locale == const Locale('uz', 'UZ') ? 'O\'zbekcha' : Get.locale == const Locale('oz', 'OZ') ? 'Узбекча' : Get.locale == const Locale('ru', 'RU') ? 'Русский' : 'English', style: TextStyle(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5), fontSize: Get.width * 0.035, fontWeight: FontWeight.w500)),
          if (!isNightMode)
            IconButton(onPressed: () => onTap(), icon: Icon(Icons.chevron_right, size: Get.height * 0.035, color: color))
          else
            CupertinoSwitch(
              value: Theme.of(context).brightness == Brightness.dark,
              onChanged: (value) {
                AdaptiveTheme.of(context).brightness == Brightness.light ? AdaptiveTheme.of(context).setDark() : AdaptiveTheme.of(context).setLight();
              },
              activeColor: AppColors.green,
              trackColor: AppColors.grey.withOpacity(0.5),
              focusColor: AppColors.green,
              thumbColor: Theme.of(context).colorScheme.surface,
              applyTheme: true
            )
        ]
      ),
      onTap: () => onTap()
    );
  }
}